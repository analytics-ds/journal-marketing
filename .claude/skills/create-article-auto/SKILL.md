# Skill : Creer un article evergreen SEO (full auto) — Journal Marketing

Cette skill produit **automatiquement** un article evergreen SEO, bilingue FR + EN, a partir d'un mot-cle pris dans `roadmap.yaml`. Aucun input humain, aucun point d'arret, publication directe sur GitHub.

Elle est declenchee par une routine cloud planifiee (cron quotidien, 1h UTC). Elle peut aussi etre lancee manuellement pour tester.

Ce blog est **Journal Marketing** (journal-marketing.fr), media debrande sur le marketing digital. Deux differences majeures avec la version reseau de cette skill :
1. **L'analyse SERP passe par CrazySERP**, pas par SerpAPI ni par WebSearch seul.
2. **Le contenu vit sous `content/fr/` et `content/en/`**, pas `content/blog/`.

## Quand l'utiliser

- Declenchement automatique via la routine cloud.
- Declenchement manuel : `/create-article-auto` depuis la racine du repo `journal-marketing`.

## Pre-requis dans le blog

- `roadmap.yaml` a la racine, avec au moins une entree `status: todo`.
- `hugo.toml` configure FR (racine) + EN (`/en/`).
- `data/authors.yaml` present (8 personas).
- `content/fr/blog/` et `content/en/blog/` existent.
- `.claude/scripts/fetch-image.sh` present.
- Remote git `origin` configure, acces push sur `main`.

## Philosophie : full auto, pas de human in the loop

Aucune question a l'utilisateur. Toutes les decisions sont prises par l'agent a partir de :
- le mot-cle et la categorie de la roadmap,
- l'analyse SERP CrazySERP (ou le repli, voir Etape 1),
- le contexte du site (`CLAUDE.md` du blog, `data/authors.yaml`, `hugo.toml`),
- les articles deja publies (scan de `content/fr/blog/`).

Si une etape bloque (image introuvable, build Hugo casse, push rejete apres rebase), l'agent **n'insiste pas** : il passe l'entree en `status: failed` avec le message d'erreur, commit le roadmap seul, et sort en code non-zero.

**Exceptions qui ne sont JAMAIS un motif d'echec** : l'indisponibilite de CrazySERP (Etape 1) et l'absence d'image hero (Etape 5). Dans les deux cas on continue et on publie.

## Regles editoriales non negociables de ce blog

Elles priment sur toute habitude generique. Les agents rediger ont deja derape dessus par le passe.

- **Debranding strict** : le site publie ne mentionne JAMAIS datashake. Ni le nom, ni un lien `datashake.fr`, ni un CTA agence, ni une allusion a une agence "nous". Cette skill ne produit **jamais** de classement d'agences : uniquement de l'evergreen informationnel.
- **Jamais de tiret cadratin (—) ni demi-cadratin (–)**, nulle part : titre, meta, body, alt, FAQ. Utiliser virgule, point, deux-points, ou reformuler.
- **Jamais de point median (·)** dans un texte visible.
- **Accents obligatoires** partout dans le contenu FR (é, à, è, ù, ç).
- **Pas de tutoiement**, pas de "je / tu / nous / vous". Ton impersonnel.
- **Pas de separateur horizontal** (`---`) dans le body.
- **Pas de `&`** dans les H2 et H3.
- Pas de chiffre invente. Si une donnee n'est pas sourcee par la SERP, ne pas la citer. Les agents de ce blog ont deja produit des ratios fabriques.

## Etape 0 — Selection de l'entree roadmap

1. Se placer a la racine du repo.
2. `git pull --rebase origin main`. Si echec : abort avec log clair.
3. Lire `roadmap.yaml`.
4. Filtrer : `status == todo` **ET** `scheduled_date <= today` (YYYY-MM-DD).
5. Trier par `scheduled_date` croissante, prendre la premiere.
6. Si aucune entree eligible : loguer "Aucune entree roadmap eligible aujourd'hui" et **exit 0**. Ne jamais avancer une entree future.

L'entree fournit : `kw`, `category`, `scheduled_date`.

La `category` doit etre l'une des 7 rubriques du blog. Ne jamais en inventer une :

| Categorie FR (roadmap et frontmatter FR) | Categorie EN (frontmatter EN) |
|---|---|
| SEO | SEO |
| IA et GEO | AI and GEO |
| Contenu | Content |
| Social et influence | Social and influence |
| Publicité en ligne | Online advertising |
| Data et mesure | Data and measurement |
| Outils et comparatifs | Tools and comparisons |

## Etape 1 — Analyse SERP via CrazySERP

**CrazySERP remplace SerpAPI sur ce blog.** Un seul appel renvoie les resultats organiques, les People Also Ask, les recherches associees, l'AI Overview complete et le volume de recherche. La cle est fournie dans le prompt de la routine (variable `CRAZYSERP_API_KEY`), jamais ecrite dans le repo : **le repo est public**.

### 1.1 Appel

```bash
curl -s --max-time 240 -G "https://crazyserp.com/api/search" \
  --data-urlencode "q=<kw>" \
  --data-urlencode "gl=fr" \
  --data-urlencode "hl=fr" \
  --data-urlencode "location=France" \
  --data-urlencode "page=1" \
  -H "Authorization: Bearer $CRAZYSERP_API_KEY" \
  -o /tmp/serp.json
```

Points de vigilance, tous verifies en production :

- **`--max-time 240` est obligatoire.** Une requete jamais scrapee par CrazySERP prend de 60 s a plusieurs minutes (elle scrape en direct). Un timeout court perd le credit sans rien recuperer.
- **`location=France` et rien d'autre** pour un ciblage national. Ne jamais ecrire `Paris,France` : ce format resout silencieusement vers `Paris,Ontario,Canada`. Le format canonique est a 3 niveaux (`Ville,Region,Pays`) et n'est pas utile ici.
- **Relire `params.location` et `credits_used` dans la reponse.** Ce sont les deux champs qui trahissent un appel parti de travers.
- **Ne pas utiliser `tbm`** (`nws`, `isch`, `vid`) : renvoie 0 resultat tout en debitant un credit.
- Un seul appel par article, `page=1`. Pas besoin du top 30 pour rediger.

### 1.2 Extraction

```bash
jq '{
  volume:   .volume.yearly_data[0].total_volume,
  aio:      .parsed_data.has_ai_overview,
  aio_txt:  .parsed_data.ai_overview.content,
  aio_src:  [.parsed_data.ai_overview.sources[]? | {title, url}],
  organic:  [.parsed_data.organic[]? | {position, title, description, url}],
  paa:      [.parsed_data.people_also_ask[]? | .question],
  related:  [.parsed_data.related[]? | .query],
  snippet:  .parsed_data.featured_snippet,
  stats:    .stats
}' /tmp/serp.json
```

### 1.3 Repli en cascade (ne jamais echouer sur cette etape)

1. **CrazySERP repond** : cas nominal.
2. **CrazySERP renvoie 402 (credits insuffisants)** : ne pas basculer silencieusement. Loguer `CRAZYSERP 402 credits epuises`, continuer en repli WebSearch, et le signaler dans le commit message pour que Damien le voie.
3. **CrazySERP injoignable** (timeout, DNS, 403 de l'egress proxy du sandbox cloud) : basculer sur `WebSearch` sur le `kw` (outil natif, execute cote serveur Anthropic, donc non soumis a la politique reseau du sandbox). Maximum 3 recherches. Exploiter uniquement titres et snippets.
4. **WebSearch aussi indisponible** : mode degrade, analyse a partir du seul `kw`, de la `category` et du contexte editorial du `CLAUDE.md`. **Publier quand meme.**

Dans tous les cas, noter le mode reellement utilise dans le log.

### 1.4 Ne pas ouvrir les pages concurrentes

Ne **PAS** utiliser `WebFetch` sur les URLs concurrentes : dans le sandbox cloud, les domaines commerciaux sont bloques par la politique reseau (403/503). L'analyse se fait sur les titres, descriptions, PAA et AI Overview renvoyes par l'API.

### 1.5 Synthese interne (aucun output humain)

L'agent determine :

- **Intention de recherche** : deduite du pattern des titres du top 10 (informationnelle, definitionnelle, comparative, transactionnelle).
- **Angles concurrents** : sous-themes recurrents dans les titres et descriptions.
- **Champ semantique** : termes recurrents, plus `parsed_data.highlights` si present (ce sont les termes que Google met en gras).
- **FAQ** : construire 4 a 6 questions a partir des `people_also_ask`. **Toujours reformuler**, jamais copier mot pour mot. S'il y a moins de 4 PAA, completer avec les `related` transformees en questions.
- **Tableau pertinent ?** : vrai si le kw ou les titres du top contiennent "meilleur", "top", "vs", "ou", "comparatif", "prix", "tarif". Faux sinon.
- **Longueur cible** : 1500 a 2000 mots.
- **AI Overview** : si `has_ai_overview` est vrai, lire `ai_overview.content`. Les sous-questions qu'elle traite indiquent ce que Google considere comme le noyau du sujet : les couvrir explicitement dans la structure Hn. **Ne jamais recopier le texte de l'AIO.** Noter dans le log `AIO : Declenchee` ou `AIO : Non declenchee`.

## Etape 2 — Title et meta description

Regles appliquees directement, pas d'appel a une autre skill. Une seule option, choix direct.

### Title
- Contient le `kw` dans le premier tiers.
- Maximum 60 caracteres (proxy sur les 580 px de la SERP).
- Le `title` du frontmatter ne contient **pas** le nom du site : Hugo l'ajoute deja dans la balise `<title>`.
- Pas de cadratin. Deux-points autorises.

### Meta description
- Maximum 155 caracteres.
- Contient le `kw`.
- Une phrase descriptive factuelle. Pas de call to action, pas de teasing.

## Etape 3 — Structure Hn

- **Pas de H1 dans le body.** Hugo genere le H1 a partir du `title`.
- 4 a 7 H2 batis sur les patterns identifies en 1.5. Priorite aux sujets presents chez 3 concurrents et plus, puis 2 et plus, puis les angles uniques a fort potentiel.
- 1 a 2 H2 d'angle propre au blog (positionnement lu dans `CLAUDE.md`).
- Si l'AIO est declenchee : au moins un H2 repond frontalement a la question centrale traitee par l'AIO, en 2 a 3 phrases denses placees juste sous le H2. C'est ce format qui se fait citer.
- Dernier H2 : "Questions frequentes", en accordeons `<details><summary>`.
- H3 : 1 a 3 par H2, optionnels.
- H2 explicites et auto-suffisants, lisibles hors contexte. Pas de "Introduction" ni "Conclusion" bruts.

## Etape 4 — Selection de l'auteur

1. Lire `data/authors.yaml` (8 personas).
2. Scorer chaque auteur sur les recoupements entre ses `topics` / `expertise` et le couple `kw` + `category`.
3. Prendre le meilleur score.
4. Egalite ou score nul : `la-redaction`.

Le meme identifiant sert en FR et en EN (les champs `role` et `bio` sont deja bilingues dans `authors.yaml`).

**Ce blog a deux champs auteur, les deux sont obligatoires** :
```yaml
author: "thomas-durand"
auteurs: ["thomas-durand"]
```
`author` sert a l'affichage, `auteurs` alimente la taxonomie des pages auteur. En oublier un casse silencieusement une des deux.

## Etape 5 — Image hero

```bash
bash .claude/scripts/fetch-image.sh "<kw traduit en anglais>" "<slug-fr>" "static/images/blog"
```

- Query en anglais : Openverse est majoritairement indexe en anglais.
- Sortie du script sur 3 lignes : chemin Hugo, alt suggere, credit.
- Si code non-zero : **un seul** nouvel essai avec une query plus generique (la categorie traduite en anglais).
- Si 2e echec : **ne pas marquer failed**. Publier sans hero, en omettant `image`, `imageAlt` et `imageCredit` du frontmatter.
- Si le script reussit, `imageCredit` est **obligatoire** dans le frontmatter, tel que renvoye. C'est la contrepartie de la licence.
- Verifier l'extension reelle du fichier ecrit (`.webp` attendu) et la reporter telle quelle dans `image`. Une extension inventee produit un hero casse sans erreur de build.

## Etape 6 — Maillage interne

1. Lister les `.md` de `content/fr/blog/` (hors `_index.md`).
2. Lire leur frontmatter : `title`, `categories`, `tags`, et le slug du fichier.
3. Scorer la proximite avec le nouvel article : categorie identique +3, tag partage +1 par tag, mot commun avec le `kw` +2.
4. Garder les 3 a 5 meilleurs.
5. Ancres en langue naturelle contenant le mot-cle de l'article cible.
6. Placer les liens de facon contextuelle dans le body, un par section. **Pas de bloc "Voir aussi" en fin d'article.**

**Maillage intra-langue strict** : la version FR pointe vers `/blog/...`, la version EN vers `/en/blog/...`. Ne jamais croiser.

**Verifier que chaque cible existe reellement** avant d'ecrire le lien : la cible doit etre un fichier present dans `content/fr/blog/` (respectivement `content/en/blog/`). Des liens internes morts ont deja ete introduits sur ce blog en recopiant les liens d'un article source.

## Etape 7 — Redaction FR

Fichier : `content/fr/blog/[slug-fr].md`.

### Frontmatter

```yaml
---
title: "[Title, <= 60 car, sans nom du site]"
translationKey: "[slug-generique-identique-FR-et-EN]"
date: "[YYYY-MM-DD]"
lastmod: "[YYYY-MM-DD]"
description: "[Meta description <= 155 car]"
categories: ["[Categorie FR exacte, cf. tableau etape 0]"]
tags: ["tag1", "tag2", "tag3", "tag4", "tag5"]
author: "[id-slug]"
auteurs: ["[id-slug]"]
image: "/images/blog/[slug].webp"
imageAlt: "[Description FR, <= 125 car]"
imageCredit: "[Credit exact renvoye par fetch-image.sh]"
faq:
  - question: "[Q1]"
    answer: "[R1, 3 a 5 phrases]"
  - question: "[Q2]"
    answer: "[R2, 2 a 4 phrases]"
---
```

**Le bloc `faq:` du frontmatter est obligatoire.** Il alimente le schema `FAQPage` de `layouts/partials/schema.html`. Les accordeons `<details>` du body ne suffisent pas : sans ce bloc, aucun balisage FAQ n'est genere. Les questions et reponses du frontmatter doivent etre **strictement identiques** a celles du body.

Les 2 axes de tags du blog : plateformes (`google`, `chatgpt`, `linkedin`, `tiktok`, `instagram`, `meta`...) et formats (`guide`, `comparatif`, `actu`, `interview`). Melanger les deux axes plus les tags de sujet.

### Body

- Premier paragraphe : contient le `kw` naturellement et pose le contexte, sans formule d'accroche creuse.
- Respecter la structure de l'etape 3, ni section en plus ni en moins.
- 1500 a 2000 mots.
- Densite du `kw` naturelle, 1 a 2 %. Variations et synonymes dans les H2.
- Mots-cles importants en **gras**, avec parcimonie.
- Au moins un tableau si l'etape 1.5 a note "tableau pertinent". Les tableaux passent par le render hook `layouts/_default/_markup/render-table.html` qui gere le scroll horizontal : ecrire du markdown de tableau standard, ne pas ecrire de HTML.
- Paragraphes de 3 a 5 phrases maximum.
- Liens internes de l'etape 6, places dans le corps des sections.
- Dernier H2 "Questions frequentes" en `<details><summary>`, aligne au mot pres sur le frontmatter `faq:`.

Relire le contenu produit contre la section "Regles editoriales non negociables" avant d'ecrire le fichier. Le controle typographique n'est pas optionnel :

```bash
grep -n "—\|–\|·" content/fr/blog/[slug-fr].md content/en/blog/[slug-en].md
```
Cette commande doit ne rien renvoyer. Si elle renvoie quelque chose, corriger avant de builder.

## Etape 8 — Redaction EN

Fichier : `content/en/blog/[slug-en].md`.

- **Meme `translationKey` que le FR**, a l'identique. C'est ce qui appaire les deux versions pour le hreflang et le switcher de langue. Une faute ici casse les deux silencieusement.
- Traduction fidele du FR, pas une nouvelle recherche de mots-cles.
- Slug EN traduit, pas translittere.
- `categories` en EN via le tableau de l'etape 0. `tags` traduits.
- `imageAlt` traduit. `image` et `imageCredit` identiques au FR.
- `author` et `auteurs` identiques au FR.
- Bloc `faq:` du frontmatter et accordeons du body traduits tous les deux.
- Memes interdits typographiques : ni cadratin, ni demi-cadratin, ni point median.

## Etape 9 — Build Hugo

### 9.0 Installer Hugo extended v0.161.1

Le sandbox cloud n'a pas Hugo, et la version fournie par `apt` (0.123.x) casse le build des sites multilingues du reseau. Installer exactement la version de la prod :

```bash
wget -q -O /tmp/hugo.deb https://github.com/gohugoio/hugo/releases/download/v0.161.1/hugo_extended_0.161.1_linux-amd64.deb \
  && (sudo dpkg -i /tmp/hugo.deb 2>/dev/null || { dpkg-deb -x /tmp/hugo.deb /tmp/hugobin && export PATH="/tmp/hugobin/usr/local/bin:$PATH"; })
hugo version   # doit afficher v0.161.1 extended
```

**Repli si le telechargement echoue en 403** (l'egress proxy du sandbox bloque `github.com/gohugoio/hugo/releases`, repo hors scope de la session, non debloquable car cross-owner) : passer par le wrapper npm, qui recupere le meme binaire et passe le proxy.

```bash
mkdir -p /tmp/hugobin-npm && cd /tmp/hugobin-npm && npm init -y >/dev/null 2>&1 && npm install hugo-extended@0.161.1
export PATH="/tmp/hugobin-npm/node_modules/.bin:$PATH"
hugo version
```

Si les deux echouent, utiliser le `hugo` present. **Ne jamais faire `apt install hugo`.** La version de la prod est dans `.github/workflows/hugo.yml`, s'y referer si elle a change.

### 9.1 Build et verification

```bash
hugo --gc --minify
```

- Exit code non-zero : marquer `failed` avec le log de l'erreur, abort.
- Verifier ensuite que les deux pages existent reellement dans le build :

```bash
ls public/blog/[slug-fr]/index.html public/en/blog/[slug-en]/index.html
```

Ce controle n'est pas cosmetique. Un article ecrit hors de `content/` a deja produit un 404 en production pendant plusieurs jours, **sans la moindre erreur de build**. Si un des deux fichiers manque, marquer `failed` avec l'erreur "page absente du build", meme si `hugo` a rendu 0.

## Etape 10 — Mise a jour roadmap et MEMORY.md

### roadmap.yaml

```yaml
  status: done
  published_date: "[YYYY-MM-DD]"
  published_url_fr: "https://journal-marketing.fr/blog/[slug-fr]/"
  published_url_en: "https://journal-marketing.fr/en/blog/[slug-en]/"
  error: null
```

### MEMORY.md

A la racine du repo. Le creer s'il n'existe pas, avec le titre `# MEMORY - Journal Marketing` suivi d'une section `## Publications`. Ajouter une ligne :

```
- YYYY-MM-DD | [Titre FR] (FR+EN) | [Categorie] | auto | AIO: [Declenchee|Non declenchee] | SERP: [crazyserp|websearch|degrade]
```

Le suffixe `auto` distingue ces articles de ceux produits a la main.

## Etape 11 — Commit et push

```bash
git add -A
git commit -m "Auto: publication evergreen - [Titre FR]"
git pull --rebase origin main
git push origin main
```

Push rejete apres rebase : retenter jusqu'a 3 fois (`pull --rebase` puis `push`). Toujours KO au bout de 3 : marquer `failed` avec l'erreur "push rejected 3x", commit du roadmap local, exit non-zero.

Le push sur `main` declenche le workflow GitHub Actions qui deploie sur GitHub Pages.

## Gestion des echecs (transversal)

A n'importe quelle etape, hors les deux exceptions listees plus haut :

1. Loguer le message d'erreur precis (etape et cause).
2. Mettre a jour l'entree de roadmap :
   ```yaml
     status: failed
     error: "[etape] [message]"
   ```
3. Supprimer les fichiers d'article partiellement ecrits, pour ne pas laisser de brouillon dans `content/`.
4. Commit du seul `roadmap.yaml`, message `Auto: roadmap update (failed)`.
5. Push.
6. Exit non-zero.

Une entree `failed` n'est **jamais** retentee automatiquement. Damien la corrige et la repasse en `todo`.

## Format de roadmap.yaml

```yaml
articles:
  - kw: "mot cle principal"
    category: "Une des 7 rubriques"
    volume: 1200        # informatif, ignore par l'agent
    kd: 35              # informatif, ignore par l'agent
    scheduled_date: "2026-08-10"
    status: todo
    published_date: null
    published_url_fr: null
    published_url_en: null
    error: null
```

Champs editables par l'humain : `kw`, `category`, `scheduled_date` (obligatoires), `volume` et `kd` (informatifs, **ignores par l'agent**), `status` (pour repasser un `failed` en `todo`).

Champs remplis par l'agent : `published_date`, `published_url_fr`, `published_url_en`, `error`, et bascule de `status`.

La roadmap est calee sur une rotation jour de la semaine / rubrique (lundi SEO, mardi Contenu, mercredi Publicite en ligne, jeudi IA et GEO, vendredi Data et mesure, samedi Social et influence, dimanche Outils et comparatifs), ce qui donne exactement 1 article par semaine et par rubrique avec un cron quotidien. Respecter cette rotation en ajoutant des entrees.

## Logs

Ecrire le deroulement dans `/tmp/create-article-auto-[YYYY-MM-DD-HHMM].log` :
- mot-cle et categorie traites,
- mode SERP reellement utilise (`crazyserp`, `websearch`, `degrade`) et `credits_used` si CrazySERP,
- `params.location` renvoye par CrazySERP,
- AIO declenchee ou non,
- auteur selectionne et raison,
- image recuperee (chemin et credit) ou absence,
- nombre de liens internes places,
- resultat du controle typographique,
- resultat du controle de presence des deux pages dans `public/`,
- temps total et exit code.
