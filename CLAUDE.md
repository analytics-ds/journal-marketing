# Journal Marketing (média vitrine marketing digital)

Site média vitrine sur le marketing digital, opéré en interne par datashake mais **totalement débrandé** (aucune mention datashake dans le site publié : ni nom, ni lien, ni CTA agence). Marque publique : **Journal Marketing, le journal du marketing digital** (ndd **journal-marketing.fr** acheté par Ruben le 2026-08-03, ex-nom de travail "Leviers"). Hugo statique, en ligne via GitHub Pages : repo `analytics-ds/journal-marketing`, workflow Actions (push sur main = deploy, cron mardi/vendredi 3h Paris), CNAME journal-marketing.fr.

## Statut et particularités (V1, 2026-07-24)

- **Pas un PBN client** : média interne datashake, utilisé par l'équipe et surtout par les **sales comme vitrine** à montrer aux prospects.
- **Débranding strict (demande Damien 2026-07-24)** : le site publié ne doit JAMAIS mentionner datashake. Le CTA home et le footer pointent vers la newsletter, l'auteur organisation est "La rédaction". Toute nouvelle prod doit respecter ça.
- **V1 = travail du style uniquement** : les 12 articles actuels sont des contenus courts bidon, générés pour juger la typographie des pages. Ne pas les prendre pour du contenu réel.
- **Bilingue FR + EN depuis le 2026-07-24** (aligné sur la règle réseau) : FR à la racine (`content/fr/`), EN sous `/en/` (`content/en/`), `translationKey` partagé entre les paires, switcher FR/EN dans le header, hreflang auto dans le head, textes d'UI via `i18n/fr.toml` + `i18n/en.toml`. Catégories traduites (mapping dans les menus de `hugo.toml` : IA et GEO / AI and GEO, Publicité en ligne / Online advertising...). Auteurs : `role`/`bio` en `fr:` + `en:` dans `data/authors.yaml`. Règle de template : liens de navigation en `relLangURL`, assets (images, css) en `relURL`.
- **Nom de domaine : `journal-marketing.fr`** (acheté par Ruben, 2026-08-03). Déploiement prévu sur GitHub Pages (org `analytics-ds`), pas encore fait.
- **En ligne depuis le 2026-08-03** : https://journal-marketing.fr (via GitHub Pages, DNS GoDaddy). Preview locale toujours possible via `hugo server`. Workflow git réseau : PULL avant modifs, push direct sur main.

## Design system (V2, portail tech news)

Inspiration principale : **universdelatech.fr** (choix de Damien après une V1 trop Pretto). Codes repris : topbar bleu roi (badge rouge Paris + date), ticker "À ne pas rater", hero sombre avec article vedette en overlay + colonne tendances, bulles rondes de rubriques avec compteur, pills pastel à puce colorée par rubrique, temps de lecture à l'horloge partout, sections alternées (grille blanche, mosaïque sombre, bande crème), liens "En voir plus" rouges avec chevron, barre de progression de lecture violette sur les articles, partage social rond coloré, sidebar article "Sommaire + Plus d'articles" (mini-card sombre), footer gris clair avec bloc newsletter et bouton violet.

- **Tout le style vit dans `static/css/main.css`**, piloté par variables CSS dans `:root` : rebranding (charte datashake, futur ndd) = éditer uniquement le bloc `:root`.
- Typo : Plus Jakarta Sans (titres, 700/800) + Inter (corps). Google Fonts.
- Couleurs : blanc, encre `#0A0A0C`, violet primaire `#7B1FFF`, rouge accents `#F0281E`, topbar bleue `#1226AA`, sombre `#0B0B0F`, crème `#FDF3E3`.
- Pills par rubrique : classes `pill-<slug>` (SEO vert, GEO et IA violet, Contenu orange, Netlinking bleu, Data et Analytics rose), alignées sur les couleurs des covers.
- Covers d'articles : **photos libres de droit Openverse** (WebP dans `static/images/blog/`, licences commercial+modification, champ `imageCredit` OBLIGATOIRE dans le frontmatter). Script : `.claude/scripts/fetch-image.sh "<query>" "<slug>"` (copié du template réseau). **Toujours vérifier visuellement (Read) chaque image téléchargée avant intégration** : les premiers résultats Openverse sont souvent hors sujet. Avatars auteurs : SVG monogrammes dans `static/images/authors/`.
- Partials réutilisables : `pill.html` (pill catégorie), `clock.html` (temps de lecture), `card.html`, `avatar.html`.
- Interdits charte Damien : jamais de tiret cadratin ni de point médian dans tout texte visible (HTML, titles, contenus).

## Structure éditoriale (validée 2026-07-24, mix UDLT + BDM + Search Engine Land + SEJ + Abondance)

- **7 rubriques** (catégories Hugo, jamais de `&` dans les noms) : SEO (inclut netlinking, technique, local), IA et GEO, Contenu, Social et influence, Publicité en ligne, Data et mesure, Outils et comparatifs.
- **2 axes transverses en tags** : plateformes (google, chatgpt, linkedin, tiktok...) et formats (guide, comparatif, actu, interview).
- Noms courts dans le menu (Social, Publicité, Data, Outils), noms complets dans les catégories.
- Typos de pages : HP (`layouts/index.html`), hub blog, rubrique/tag (term), index rubriques et sujets, auteurs (index + page), article (breadcrumb, sommaire sticky, bloc auteur, similaires), 404.
- Auteurs : `data/authors.yaml` (8 personas : thomas SEO, lea contenu, karim IA/GEO, sophie netlinking, julien data, nina social, marc paid, la-redaction org). Frontmatter article : `author: <slug>` (affichage) ET `auteurs: ["<slug>"]` (taxonomie page auteur).
- Dates localisées FR via `time.Format ":date_medium"` / `":date_long"`.

## Pièges Hugo connus (vécus sur ce projet)

- Les pages de terme utilisent `layouts/<taxonomie>/term.html` ; un `taxonomy.html` dans `_default/` capte les pages de terme (compat ancienne convention). D'où : index de taxonomie dans `layouts/categories/taxonomy.html` et `layouts/tags/taxonomy.html`, terms dans les `term.html` correspondants.
- `hugo server` ne voit pas les **nouveaux** fichiers de layout : redémarrer le serveur après ajout d'un template.
- Utiliser `hugo.Data.authors` (pas `.Site.Data`, déprécié).
- **Catégories accentuées** : `removePathAccents = true` donne des URLs sans accent (`/categories/publicite-en-ligne/`), MAIS les `pageRef` des menus doivent référencer le chemin AVEC accent (`/categories/publicité-en-ligne`) pour que `.Page` résolve. Les classes CSS pill (`pill-<urlize>`) sont bien sans accent.

## Commandes

```bash
# preview locale (depuis ce dossier)
hugo server --port 1414 --bind 127.0.0.1 --renderToMemory
# build de contrôle (ne pas écrire public/ dans le Drive)
hugo -d /tmp/mag-build
```

## Contenu réel (depuis le 2026-07-24)

- **14 articles réels bilingues** produits le 2026-07-24 : 7 réécritures anti-duplicate d'articles ai.datashake.fr (classements agences netlinking / GEO-AI Overviews / Shopify / WordPress, guide GEO, comparatif Perplexity-ChatGPT-AI Mode, techniques ChatGPT, outils Google Ads) + 6 nouveaux evergreen avec analyse SERP SerpAPI (persona, title/meta, erreurs SEO, checklist refonte, fiche Google, copywriting). Les 18 articles courts d'origine restent comme fond de catalogue.
- **Règles de production** : réécrire TOUJOURS les contenus repris d'ai.datashake.fr (site en ligne, duplicate sinon) en gardant les données ; datashake #1 des classements agences avec 1 lien https://datashake.fr max par article (uniquement dans les classements) ; brief agents rédacteurs dans le pattern du 2026-07-24 (charte typo à re-vérifier derrière eux : les agents laissent des cadratins et du tutoiement, et inventent des ratios, contrôler puis corriger).
- **Archives style UDLT (2026-07-24)** : pages de terme = liste verticale de cards horizontales + compteur d'articles + sidebar "Plus d'articles" (autres rubriques). Templates `layouts/{_default,categories,tags}/term.html` identiques.

## Socle SEO et GEO technique (2026-08-03)

- **JSON-LD en `@graph` unique** : `layouts/partials/schema.html`, inclus par `head.html`. Génère Organization + WebSite partout, puis selon le type de page : BlogPosting (avec author, publisher, wordCount, timeRequired, articleSection, keywords) + Person + FAQPage + BreadcrumbList sur les articles, Person + ProfilePage sur les pages auteur, CollectionPage + BreadcrumbList sur les rubriques et sujets. Construit avec des `dict` Hugo passés à `jsonify` (échappement automatique, jamais de JSON écrit à la main).
- **Champ `faq` obligatoire dans le frontmatter** : il alimente le schema FAQPage. Les accordéons `<details>` du body ne suffisent pas. Un script d'extraction a été passé sur l'existant ; **tout nouvel article doit avoir son bloc `faq:` en frontmatter en plus des `<details>`** (questions et réponses identiques).
- **robots.txt dynamique** (`layouts/robots.txt`, `enableRobotsTXT = true`) : tout ouvert + **crawlers IA explicitement autorisés** (GPTBot, OAI-SearchBot, ClaudeBot, PerplexityBot, Google-Extended, Applebot-Extended, CCBot, MistralAI-User...). C'est un choix GEO assumé : on veut être crawlé par les moteurs génératifs.
- **head.html** : meta robots `max-image-preview:large` (nécessaire pour Discover et les AI Overviews), og:image par défaut, Twitter card, `article:published_time`/`modified_time`/`section`/`tag`, hreflang + `x-default` vers le FR, polices Google en non bloquant (`media="print"` + swap), favicon SVG.
- **Assets de marque** : `static/favicon.svg`, `static/images/logo.png` (512x512, utilisé par le schema Organization et l'apple-touch-icon), `static/images/og-default.png` (1200x630, image de partage par défaut). Générés par capture Playwright d'un gabarit HTML.
- **Plan du site** : `/plan-du-site/` (FR) et `/en/site-map/`, layout `layouts/_default/sitemap-html.html`, lié depuis le footer.
- **Search Console** : fichier de vérification `static/googled8eabe3c50a839fc.html` (ne pas supprimer). Sitemap à soumettre : `https://journal-marketing.fr/sitemap.xml` (index FR + EN).

## Piège vécu : article écrit hors de `content/`

Le 2026-08-03, l'article "Apparaître dans ChatGPT" (FR + EN) a été retrouvé dans `src/content/blog/` au lieu de `content/`, écrit là par un agent rédacteur qui avait mal interprété le `<racine>` du brief. Hugo ne buildait donc pas l'article : **404 en production pendant plusieurs jours, sans aucune erreur de build**. Il avait aussi échappé aux passes de contrôle (charte typo, extraction FAQ) qui ne scannaient que `content/`.

**Contrôle à faire après chaque batch d'agents rédacteurs** : `git ls-files | grep -v "^content/" | grep "\.md$"` doit ne renvoyer que les fichiers attendus (CLAUDE.md, README...), et le nombre d'articles buildés doit correspondre au nombre de fichiers dans `content/*/blog/`.

## Batch du 2026-08-04 : 8 classements d'agences

Reprise des 8 derniers comparatifs evergreen d'ai.datashake.fr (visuels IA, marketing 360, programmatique, SEO applications mobiles, SEO migration, SEO PME, SEO Webflow, web analytics). Le site passe à **40 articles par langue**. Il ne reste plus rien d'exploitable sur ai.datashake.fr : seul "meilleurs événements marketing mai 2026" a été écarté, c'est un article daté, pas un evergreen.

**Ce que le contrôle a rattrapé sur ce batch** (à refaire systématiquement après des agents rédacteurs) :
- **Liens internes cassés** : les agents recopient les liens de l'article source, qui pointent vers des articles d'ai.datashake inexistants ici (7 liens dans le seul article Webflow). Contrôle : vérifier que chaque `](/blog/xxx/)` correspond à un fichier de `content/`.
- **Format du lien datashake** : plusieurs agents ont laissé l'URL brute (`https://datashake.fr offre...`) au lieu d'un lien markdown avec ancre. Compter les liens avec `\]\(https://datashake\.fr\)` et non l'URL seule (un lien markdown contient l'URL deux fois, ce qui fausse le comptage).
- Cadratins et nombre de liens internes (minimum 3) : idem batch précédent.
- Le piège du dossier `src/` n'a PAS eu lieu grâce aux **chemins absolus complets** dans le brief. À conserver.

## À venir

- Compléter les rubriques Social / Publicité / Data
- Connexion GA4 datashake
- Routine cloud de publication evergreen (1 article / semaine / rubrique), à configurer depuis un autre compte Claude que celui de Damien
