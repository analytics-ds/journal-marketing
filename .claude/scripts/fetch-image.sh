#!/bin/bash
# fetch-image.sh
# Recupere une image libre de droit compatible usage commercial depuis l'API publique
# Openverse (federe Flickr, Wikimedia, etc. — pas d'API key requise).
# Filtre sur les licences autorisant l'usage commercial et la modification (CC BY, CC0, PDM...).
# Telecharge l'image, la convertit en WebP si cwebp dispo, et affiche le chemin Hugo + credit.
#
# Usage : fetch-image.sh "<query>" "<slug>" [output_dir]
# Output stdout (3 lignes) :
#   ligne 1 : chemin Hugo de l'image (ex: /images/blog/mon-slug.webp)
#   ligne 2 : alt text suggere (titre de l'image)
#   ligne 3 : credit (ex: "Photo par <creator> via <source> — <license>")
# Output stderr : messages d'info/erreur
# Exit codes : 0 OK, 1 args, 2 API vide, 3 pas de resultat, 4 download, 5 format

set -e

QUERY="$1"
SLUG="$2"
OUTPUT_DIR="${3:-static/images/blog}"

if [ -z "$QUERY" ] || [ -z "$SLUG" ]; then
    echo "Usage: $0 <query> <slug> [output_dir]" >&2
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

# URL-encode la query (gere les accents)
QUERY_ENCODED=$(printf '%s' "$QUERY" | python3 -c "import sys,urllib.parse; print(urllib.parse.quote(sys.stdin.read().strip()))" 2>/dev/null || echo "$QUERY" | sed 's/ /+/g')

USER_AGENT="blog-site-template/1.0 (+https://github.com/analytics-ds)"

# Requete Openverse :
# - license_type=commercial,modification → licences permettant commercial + modification (CC BY, CC0, PDM, CC BY-SA)
# - page_size=20 → PLAFOND anonyme d'Openverse (30 renvoie {"detail":...}), on score ensuite
#   sur le ratio et la largeur au lieu de prendre le 1er resultat
# - mature=false → filtre safe
# --- Filet de securite : placeholder SVG genere en local -----------------------
# L'environnement cloud des routines bloque les domaines commerciaux via son proxy
# egress (cf. "routines pbn.md"), donc le telechargement depuis les CDN d'images
# (Flickr, Wikimedia, Rawpixel) y echoue par conception. Sans ce filet, la skill
# publiait l'article SANS AUCUN visuel : 9 articles FR sur 14 entre le 10 et le
# 26/08/2026. Un placeholder de charte vaut mieux qu'un hero vide, et il ne peut
# jamais echouer puisqu'il ne sort pas de la machine.
emit_placeholder() {
    local reason="$1"
    local out="$OUTPUT_DIR/$SLUG.png"
    local gen
    gen="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)/make-placeholder.py"
    if [ ! -f "$gen" ]; then
        echo "[fetch-image] ERREUR : make-placeholder.py introuvable a cote du script" >&2
        exit 6
    fi
    if ! python3 "$gen" "$SLUG" "$out" >/dev/null; then
        echo "[fetch-image] ERREUR : generation du placeholder echouee" >&2
        exit 6
    fi
    echo "[fetch-image] PLACEHOLDER genere ($reason) : $out" >&2
    local hp
    hp=$(echo "$out" | sed -E 's|^\.?/?static/|/|')
    [[ "$hp" != /* ]] && hp="/$hp"
    # 3 lignes attendues par la skill. Alt et credit vides : rien a crediter sur un
    # visuel qu'on genere soi-meme, et la skill doit voir que ce n'est pas une photo.
    echo "$hp"
    echo ""
    echo ""
    exit 0
}

echo "[fetch-image] Recherche Openverse : $QUERY" >&2
# `|| true` obligatoire : avec set -e, un curl non-zero (proxy egress, DNS, timeout)
# tuait le script avant d'atteindre le filet placeholder.
JSON=$(curl -sL --max-time 20 \
    -H "User-Agent: $USER_AGENT" \
    -H "Accept: application/json" \
    "https://api.openverse.org/v1/images/?q=${QUERY_ENCODED}&license_type=commercial,modification&page_size=20&mature=false" || true)

if [ -z "$JSON" ] || echo "$JSON" | grep -q '^{"detail":'; then
    echo "[fetch-image] Openverse : reponse vide" >&2
    emit_placeholder "api-vide"
fi

# Extraction du 1er resultat via python (plus robuste que grep pour du JSON)
RESULT=$(echo "$JSON" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    results = data.get('results', [])
    # Le hero est rendu en 1200x520 (ratio 2.31) avec object-fit: cover.
    # Prendre le 1er resultat donnait des portraits (768x1024) recadres aux 3/4
    # et des vignettes de 500px upscalees. On score donc au lieu de prendre le 1er.
    TARGET_RATIO = 2.31
    def score(r):
        w = r.get('width') or 0
        h = r.get('height') or 0
        if not w or not h:
            return -1e9
        ratio = w / h
        # penalite d'ecart au ratio cible, tres forte sur le portrait
        pen = abs(ratio - TARGET_RATIO) * (60.0 if ratio < 1.0 else 22.0)
        # bonus de largeur, plafonne : au-dela de 1600px le hero n'en profite plus
        bonus = min(w, 1600) / 20.0
        if w < 900:
            bonus -= 45.0   # trop petit pour un hero 1200px, sera flou
        return bonus - pen
    cands = [r for r in results if r.get('url')]
    if not cands:
        sys.exit(3)
    cands.sort(key=score, reverse=True)
    r = cands[0]
    _w, _h = r.get('width') or 0, r.get('height') or 0
    print(f'[fetch-image] retenu {_w}x{_h} (ratio {(_w/_h if _h else 0):.2f}) sur {len(cands)} candidats', file=sys.stderr)
    print(r.get('url', ''))
    print(r.get('title', '') or '')
    creator = r.get('creator', '') or 'Auteur inconnu'
    source = r.get('source', '') or r.get('provider', '') or ''
    license_name = (r.get('license', '') or '').upper()
    license_version = r.get('license_version', '') or ''
    if license_name and license_version:
        lic = f'CC {license_name} {license_version}'
    elif license_name:
        lic = f'CC {license_name}'
    else:
        lic = 'CC'
    print(f'Photo par {creator} via {source.capitalize()} ({lic})')
except SystemExit:
    raise
except Exception as e:
    print(f'PARSE_ERROR: {e}', file=sys.stderr)
    sys.exit(3)
" 2>/dev/null) || {
    echo "[fetch-image] Openverse : aucun resultat pour '$QUERY'" >&2
    emit_placeholder "aucun-resultat"
}

IMAGE_URL=$(echo "$RESULT" | sed -n '1p')
IMAGE_TITLE=$(echo "$RESULT" | sed -n '2p')
IMAGE_CREDIT=$(echo "$RESULT" | sed -n '3p')

if [ -z "$IMAGE_URL" ]; then
    echo "[fetch-image] Openverse : URL image vide" >&2
    emit_placeholder "url-vide"
fi

# Telecharger l'image
TMP_FILE="/tmp/openverse-${SLUG}.img"
echo "[fetch-image] Telechargement : $IMAGE_URL" >&2
curl -sL --max-time 30 -H "User-Agent: $USER_AGENT" "$IMAGE_URL" -o "$TMP_FILE" || true

if [ ! -s "$TMP_FILE" ]; then
    echo "[fetch-image] telechargement echoue (proxy egress du sandbox ?)" >&2
    rm -f "$TMP_FILE"
    emit_placeholder "download-bloque"
fi

# Determiner l'extension a partir des magic bytes
FILE_TYPE=$(file -b --mime-type "$TMP_FILE")
case "$FILE_TYPE" in
    image/jpeg) SRC_EXT="jpg" ;;
    image/png)  SRC_EXT="png" ;;
    image/webp) SRC_EXT="webp" ;;
    image/gif)  SRC_EXT="gif" ;;
    *)
        echo "[fetch-image] format non supporte ($FILE_TYPE)" >&2
        rm -f "$TMP_FILE"
        emit_placeholder "format-$FILE_TYPE"
    ;;
esac

# Conversion WebP + REDIMENSIONNEMENT.
# Le hero est rendu en 1200 px de large : une source de 3000 a 6000 px partait
# telle quelle et pesait jusqu'a 826 Ko en `fetchpriority=high`, donc directement
# dans le LCP. On plafonne a 1600 px (marge pour les ecrans 2x) et q82.
MAX_W=1600
if command -v cwebp >/dev/null 2>&1; then
    OUTPUT_FILE="$OUTPUT_DIR/$SLUG.webp"
    # largeur de la source lue en python : ImageMagick n'est pas garanti sur les
    # deux Macs ni dans le cloud, python3 si (le script s'en sert deja plus haut)
    SRC_W=$(python3 - "$TMP_FILE" <<'PYW' 2>/dev/null || echo 0
import sys, struct
b=open(sys.argv[1],'rb').read()
w=0
try:
    if b[:2]==b'\xff\xd8':
        i=2
        while i<len(b)-9:
            if b[i]!=0xFF: i+=1; continue
            m=b[i+1]
            if m in (0xC0,0xC1,0xC2,0xC3):
                w=struct.unpack(">H", b[i+7:i+9])[0]; break
            if m in (0xD8,0xD9) or 0xD0<=m<=0xD7: i+=2; continue
            i+=2+struct.unpack(">H", b[i+2:i+4])[0]
    elif b[:8]==b'\x89PNG\r\n\x1a\n':
        w=struct.unpack(">I", b[16:20])[0]
    elif b[:4]==b'RIFF' and b[8:12]==b'WEBP':
        if b[12:16]==b'VP8X': w=int.from_bytes(b[24:27],'little')+1
        elif b[12:16]==b'VP8 ':
            i=b.find(b'\x9d\x01\x2a')
            if i>0: w=int.from_bytes(b[i+3:i+5],'little')&0x3fff
        elif b[12:16]==b'VP8L':
            w=(int.from_bytes(b[21:25],'little')&0x3fff)+1
except Exception:
    w=0
print(w)
PYW
)
    if [ "${SRC_W:-0}" -gt "$MAX_W" ] 2>/dev/null; then
        cwebp -quiet -q 82 -resize "$MAX_W" 0 "$TMP_FILE" -o "$OUTPUT_FILE"
        echo "[fetch-image] Converti en WebP + redimensionne a ${MAX_W}px : $OUTPUT_FILE" >&2
    else
        # largeur inconnue ou deja sous le plafond : on tente le resize borne, cwebp
        # ignore un -resize plus grand que la source uniquement si on le lui demande,
        # donc on passe par la version sans resize pour ne rien upscaler.
        cwebp -quiet -q 82 "$TMP_FILE" -o "$OUTPUT_FILE"
        echo "[fetch-image] Converti en WebP : $OUTPUT_FILE" >&2
    fi
elif command -v sips >/dev/null 2>&1; then
    # macOS sans cwebp : sips sait redimensionner, pas ecrire du WebP
    OUTPUT_FILE="$OUTPUT_DIR/$SLUG.$SRC_EXT"
    cp "$TMP_FILE" "$OUTPUT_FILE"
    sips -Z "$MAX_W" "$OUTPUT_FILE" >/dev/null 2>&1 || true
    echo "[fetch-image] cwebp absent, $SRC_EXT redimensionne par sips : $OUTPUT_FILE" >&2
elif [ "$SRC_EXT" = "webp" ]; then
    OUTPUT_FILE="$OUTPUT_DIR/$SLUG.webp"
    cp "$TMP_FILE" "$OUTPUT_FILE"
    echo "[fetch-image] Image deja en WebP, non redimensionnee : $OUTPUT_FILE" >&2
else
    # cas de l'environnement cloud : aucun outil d'image, on conserve la source
    OUTPUT_FILE="$OUTPUT_DIR/$SLUG.$SRC_EXT"
    cp "$TMP_FILE" "$OUTPUT_FILE"
    echo "[fetch-image] aucun outil d'image, conserve en $SRC_EXT : $OUTPUT_FILE" >&2
fi

rm -f "$TMP_FILE"

# Convertir le chemin fichier en chemin Hugo (retirer 'static/' du debut)
HUGO_PATH=$(echo "$OUTPUT_FILE" | sed -E 's|^\.?/?static/|/|')
[[ "$HUGO_PATH" != /* ]] && HUGO_PATH="/$HUGO_PATH"

# Output sur stdout : 3 lignes (path, alt, credit)
echo "$HUGO_PATH"
echo "$IMAGE_TITLE"
echo "$IMAGE_CREDIT"
