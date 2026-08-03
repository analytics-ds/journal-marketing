---
title: "Refonte de site : la checklist SEO pour ne rien perdre"
translationKey: "checklist-seo-refonte-site"
date: "2026-07-24T14:30:00+02:00"
lastmod: "2026-07-24T14:30:00+02:00"
description: "La checklist SEO complète pour une refonte sans perte de trafic : avant, pendant, après. Redirections 301, preservation du contenu, suivi des positions."
categories: ["SEO"]
tags: ["refonte", "seo", "checklist", "redirections", "preservation"]
author: "thomas-durand"
auteurs: ["thomas-durand"]
image: "/images/blog/checklist-seo-refonte-site.webp"
imageAlt: "Checklist SEO pour refonte de site avec phases avant, pendant et apres"
imageCredit: "Photo par Kristin Hardwick via StockSnap (CC0 1.0)"
faq:
  - question: "Peut-on faire une refonte sans redirect 301 ?"
    answer: "Techniquement oui, mais c'est très risqué. Sans redirections, Google voit les anciennes pages comme disparues et les nouvelles comme du contenu dupliqué ou nouveau. Le trafic peut mettre 6 à 12 mois à se rétablir, s'il se rétablit. Les backlinks ne transfèrent pas leur pouvoir vers les nouvelles URLs. À moins d'une refonte très mineure, les 301 sont non négociables."
  - question: "Combien de temps avant de revoir mon trafic normal ?"
    answer: "Cela dépend de la taille et la complexité du site. Pour un site de 100 à 500 pages avec une bonne exécution SEO, comptez 4 à 8 semaines. Pour un site de plusieurs milliers de pages, prévoyez 3 à 6 mois. Les sites avec beaucoup de backlinks externes peuvent être plus lents à récupérer car Google doit valider que les liens pointent toujours vers du contenu valide."
  - question: "Doit-on refondre le site avant ou après une migration technique majeure ?"
    answer: "Si possible, combinez les deux en une seule opération. Faire deux migrations majeures (changement de CMS + changement de design) l'une après l'autre prolonge la confusion pour Google et double les risques. Une migration unique, bien planifiée, est plus simple à gérer. Si vous devez les séparer, commencez par la migration technique (pour stabiliser l'architecture), puis le redesign quelques semaines après que Google ait ré-stabilisé l'indexation."
---

> **En bref :**
> 1. Une refonte sans **checklist SEO** expose le site à une perte massive de trafic si les URLs, redirections et contenus performants ne sont pas préservés.
> 2. Les trois phases critiques (avant, pendant, après) doivent être documentées et planifiées avec les developpeurs et les équipes métier.
> 3. La récupération complète du trafic prend généralement plusieurs semaines à plusieurs mois selon la taille du site et la qualité de la **preservation du trafic**.

Une **refonte de site** modernise l'interface et améliore l'expérience utilisateur. Mais côté SEO, elle représente un risque critique : sans la bonne **checklist SEO**, un site peut perdre 30 à 80 % de son trafic organique en quelques semaines. Google ne reconnaît plus les URLs, les redirections cassent, le contenu performant disparaît. Une **checklist SEO pour refonte de site** doit couvrir trois phases : avant, pendant et après. Cet article détaille chaque étape et expose les délais de récupération.

## Pourquoi une refonte fait perdre du trafic SEO

Un moteur de recherche associe le classement d'une page à son URL, sa structure HTML, ses backlinks et son contenu. Une refonte recrée souvent la totalité de ces éléments. Si les redirections ne sont pas en place ou mal configurées, Google perd la trace du contenu existant. Il crawl le site, trouve de nouvelles URLs, les indexe, puis les enlève quand les anciennes continuent à recevoir des signaux de liens. Durant cette transition, la visibilité s'effondre.

La majorité des pertes proviennent de trois erreurs :
- **Pas de redirections 301** : les anciennes URLs restent actives mais n'envoient rien aux nouvelles.
- **Contenu réécrit ou appauvri** : le texte performant est remplacé par une version générique qui perd ses mots-clés principaux.
- **Maillage interne ignoré** : les liens internes sont supprimés ou pointent vers des URLs cassées.

Ces erreurs combinées créent un vide que Google met du temps à combler. La récupération est alors longue et douloureuse.

## Checklist avant la refonte : les préparatifs indispensables

Cette phase démarre plusieurs semaines avant le lancement. Elle crée la base de données et les règles dont vous aurez besoin.

**Inventaire complet du site**
- Exporter toutes les URLs de l'ancien site (via un crawl complet, un sitemap XML ou Google Search Console).
- Documenter le nombre de pages par type (articles, produits, fiches, archives, etc.).
- Identifier les pages à archiver ou à supprimer (trafic nul, contenu obsolète).
- Extraire les positions Google et le volume de trafic de chaque page via Google Analytics et les outils de suivi de classement.

**Audit du contenu performant**
- Identifier les 50 à 100 pages générant la majorité du trafic organique.
- Sauvegarder le contenu exact de ces pages (titre, méta description, H1, paragraphes, listes).
- Noter les caractéristiques qui les rendent performantes (longueur, structure, mots-clés ciblés).
- Marquer ces pages comme "à préserver" dans votre documentation.

**Crawl de référence**
- Lancer un crawl technique complet de l'ancien site (Screaming Frog, Semrush) en documentant pages indexées, liens internes, redirections, balises de titre et métadonnées.
- Sauvegarder ce rapport comme base de comparaison post-refonte.
- Consulter nos [cinq signaux clés du crawl budget](https://leviers.ai/blog/crawl-budget-5-signaux/) pour comprendre l'indexation actuelle.

**Cartographie des redirections**
- Créer un tableau Excel ou Google Sheets avec deux colonnes : "Ancienne URL" et "Nouvelle URL".
- Remplir ce tableau pour chaque page qui est déplacée, renommée ou fusionnée.
- Valider les mappings avec les développeurs avant le lancement.
- Inclure les redirections pour les variantes (www, http/https, avec et sans trailing slash).

**Préparation du fichier htaccess ou config serveur**
- Si vous utilisez Apache, préparer le fichier `.htaccess` avec les règles 301.
- Si vous utilisez Nginx ou autre, préparer la configuration serveur correspondante.
- Faire une révision croisée : développeurs + référenceur.

## Checklist pendant la refonte : préserver le SEO

Cette phase court du début du développement jusqu'à la mise en ligne. Elle interfère directement avec l'exécution technique.

**Plan de redirections 301 en place**
- Implémenter toutes les redirections avant la mise en ligne du site nouveau.
- Vérifier que chaque redirection fonctionne (tester avec curl ou un outil de redirection).
- Vérifier le statut HTTP 301 (pas 302, 307 ou 302 temporaire).

**Preservation des balises et contenus**
- Copier et conserver intégralement le contenu des pages performantes identifiées en phase 1.
- S'assurer que chaque balise H1, H2, titre et méta description correspondent au contenu original (ou à une version améliorée du même contenu, jamais appauvrie).
- Conserver les images et leurs attributs alt.

**Maillage interne intact**
- Recréer tous les liens internes pointant vers les pages clés.
- Mettre à jour les ancres de lien pour qu'elles restent pertinentes et contextuelles.
- Vérifier que les liens des ménus, pieds de page et appels à l'action pointent vers les bonnes URLs.

**Environnement de recette isolé de Google**
- Deployer le site nouveau sur un environnement de staging ou de test inaccessible aux moteurs de recherche.
- Ajouter une directive `User-agent: *` / `Disallow: /` dans le `robots.txt` de la recette.
- Ou utiliser une authentification HTTP pour bloquer l'accès.
- Faire tous les tests SEO sur la recette avant la mise en production.

**Tests SEO en recette**
- Vérifier la validité HTML et la responsivité mobile.
- Vérifier les [Core Web Vitals](https://leviers.ai/blog/core-web-vitals-2026/).
- Valider les balises Open Graph et schema.org.

## Checklist après la refonte : valider et corriger

Cette phase démarre le jour du lancement et s'étend sur plusieurs semaines.

**Verification des redirections**
- Quelques heures après la mise en ligne, crawler le site complet et vérifier que les anciennes URLs renvoient bien vers les nouvelles.
- Tester un échantillon de 100+ URLs avec Google Search Console ou un outil de redirection.
- Chercher les chaînes de redirections (URL A → URL B → URL C au lieu de A → C directement).

**Mise à jour du sitemap et robots.txt**
- Publier un nouveau sitemap.xml listant toutes les URLs de production.
- Vérifier que toutes les anciennes URLs sont supprimées du sitemap.
- Vérifier que le robots.txt ne bloque pas les pages importantes.
- Soumettre le sitemap à Google Search Console.

**Suivi des positions et du crawl**
- Consulter [nos outils de suivi de positions](https://leviers.ai/blog/comparatif-outils-suivi-position/) pour tracker les changements de classement.
- Exécuter des crawls hebdomadaires le premier mois pour comparer avec le crawl de référence.
- Monitorer le nombre de pages indexées dans Google Search Console et le trafic dans Google Analytics 4.

**Correction rapide des 404**
- Identifier les URLs en 404 via GSC ou crawl.
- Créer les redirections manquantes.
- Vérifier les backlinks externes et les rediriger correctement.

**Reconstruction du contexte Google**
- Laisser passer 2 à 4 semaines pour que Google redécouvre et ré-évalue les nouvelles URLs.
- Durant cette période, continuer à monitorer le trafic, les erreurs de crawl et l'indexation.
- Publier du contenu nouveau ou optimisé pour accélérer la re-crawl.

## Tableau synthétique : la checklist complète par phase

| Tâche | Avant | Pendant | Après |
|---|---|---|---|
| **Audit et documentation** | Exporter URLs, crawl technique, positions Google | | Comparer crawl ancien vs nouveau |
| **Redirections 301** | Cartographier URL ancienne → nouvelle | Implémenter et tester toutes les redirections | Vérifier redirections et chercher les 404 |
| **Contenu performant** | Identifier et sauvegarder les pages clés | Préserver contenu exact, balises H1/H2, meta | Monitorer positions des pages migrées |
| **Maillage interne** | Documenter les liens clés | Recréer liens et mettre à jour URLs | Vérifier liens cassés et ajuster |
| **Robots.txt et sitemap** | Vérifier ancien robots.txt | Préparer nouveau robots.txt et sitemap | Publier sitemap, soumettre à GSC |
| **Performance et Core Web Vitals** | Benchmark ancien site | Tester responsivité mobile et CWV en recette | Monitorer CWV en production |
| **Blocage des moteurs** | | Bloquer Google sur environnement de test (robots.txt / auth) | |
| **Monitoring et alertes** | | | Crawls hebdomadaires, trafic quotidien, indexation |

## Délais réalistes de récupération du trafic

La récupération du trafic organique après une refonte dépend de la qualité de votre exécution SEO :

**Semaine 1 à 2 : Découverte et chute initiale**
Le trafic baisse souvent de 20 à 40 % immédiatement après le lancement. C'est normal : Google crawle le nouveau site, valide les redirections et comprend la nouvelle structure. Les positions baissent temporairement puis commencent à se stabiliser si les redirections sont correctes.

**Semaines 3 à 12 : Récupération progressive**
Le trafic remonte graduellement. Une majorité des pages anciennement performantes retrouvent leurs positions initiales ou améliorées. Cette phase varie selon l'ancienneté du site, la taille et la qualité des signaux de liens entrants.

**Au-delà de 12 semaines : Stabilisation**
Si tout a été exécuté correctement, le trafic devrait avoir récupéré 80 à 100 % de son niveau d'avant refonte. Si le trafic reste en dessous de 70 % après trois mois, il y a probablement des problèmes : redirections manquantes, contenu appauvri, bloquage accidentel des robots.

## Questions fréquentes

<details>
<summary>Peut-on faire une refonte sans redirect 301 ?</summary>

Techniquement oui, mais c'est très risqué. Sans redirections, Google voit les anciennes pages comme disparues et les nouvelles comme du contenu dupliqué ou nouveau. Le trafic peut mettre 6 à 12 mois à se rétablir, s'il se rétablit. Les backlinks ne transfèrent pas leur pouvoir vers les nouvelles URLs. À moins d'une refonte très mineure, les 301 sont non négociables.

</details>

<details>
<summary>Combien de temps avant de revoir mon trafic normal ?</summary>

Cela dépend de la taille et la complexité du site. Pour un site de 100 à 500 pages avec une bonne exécution SEO, comptez 4 à 8 semaines. Pour un site de plusieurs milliers de pages, prévoyez 3 à 6 mois. Les sites avec beaucoup de backlinks externes peuvent être plus lents à récupérer car Google doit valider que les liens pointent toujours vers du contenu valide.

</details>

<details>
<summary>Doit-on refondre le site avant ou après une migration technique majeure ?</summary>

Si possible, combinez les deux en une seule opération. Faire deux migrations majeures (changement de CMS + changement de design) l'une après l'autre prolonge la confusion pour Google et double les risques. Une migration unique, bien planifiée, est plus simple à gérer. Si vous devez les séparer, commencez par la migration technique (pour stabiliser l'architecture), puis le redesign quelques semaines après que Google ait ré-stabilisé l'indexation.

</details>
