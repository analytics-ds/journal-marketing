---
title: "Website Redesign: the SEO Checklist to Prevent Traffic Loss"
translationKey: "checklist-seo-refonte-site"
date: "2026-07-24T14:30:00+02:00"
lastmod: "2026-07-24T14:30:00+02:00"
description: "Complete SEO checklist for a website redesign without traffic loss: before, during, after. 301 redirects, content preservation, position tracking."
categories: ["SEO"]
tags: ["redesign", "seo", "checklist", "redirects", "preservation"]
author: "thomas-durand"
auteurs: ["thomas-durand"]
image: "/images/blog/checklist-seo-refonte-site.webp"
imageAlt: "SEO checklist for website redesign with before, during and after phases"
imageCredit: "Photo par Kristin Hardwick via StockSnap (CC0 1.0)"
---

> **In short:**
> 1. A website redesign without an **SEO checklist** exposes your site to massive traffic loss if URLs, redirects, and high-performing content are not preserved.
> 2. The three critical phases (before, during, after) must be documented and planned with developers and business teams.
> 3. Full traffic recovery typically takes several weeks to several months depending on site size and **traffic preservation** quality.

A **website redesign** modernizes the interface and improves user experience. But from an SEO perspective, it represents a critical risk: without the right **SEO checklist**, a site can lose 30 to 80 percent of organic traffic within weeks. Google no longer recognizes URLs, redirects break, high-performing content disappears. An **SEO checklist for website redesign** must cover three phases: before, during, and after. This article details each step and exposes realistic recovery timelines.

## Why Redesigns Cause SEO Traffic Loss

A search engine ties a page's ranking to its URL, HTML structure, backlinks, and content. A redesign often recreates all of these elements. If redirects are not in place or misconfigured, Google loses track of the existing content. It crawls the site, finds new URLs, indexes them, then removes them when the old ones continue to receive link signals. During this transition, visibility collapses.

Most losses stem from three errors:
- **No 301 redirects**: old URLs remain active but send nothing to the new ones.
- **Rewritten or weakened content**: high-performing text is replaced by generic versions that lose their main keywords.
- **Internal linking ignored**: internal links are removed or point to broken URLs.

These errors combined create a void that Google takes time to fill. Recovery is then long and painful.

## Checklist Before the Redesign: Essential Preparation

This phase starts several weeks before launch. It creates the database and rules you will need.

**Complete site inventory**
- Export all URLs from the old site (via complete crawl, XML sitemap, or Google Search Console).
- Document the number of pages by type (articles, products, sheets, archives, etc.).
- Identify pages to archive or delete (zero traffic, obsolete content).
- Extract Google positions and traffic volume for each page via Google Analytics and rank tracking tools.

**High-performing content audit**
- Identify the 50 to 100 pages generating most of your organic traffic.
- Save the exact content of these pages (title, meta description, H1, paragraphs, lists).
- Note the characteristics that make them perform (length, structure, targeted keywords).
- Mark these pages as "to preserve" in your documentation.

**Reference crawl**
- Run a complete technical crawl of the old site (Screaming Frog, Semrush) documenting indexed pages, internal links, existing redirects, title tags and metadata.
- Save this report as a baseline for post-redesign comparison.
- Consult our [five key crawl budget signals](https://leviers.ai/en/blog/crawl-budget-5-signals/) to understand current indexing.

**Redirect mapping**
- Create an Excel or Google Sheets table with two columns: "Old URL" and "New URL".
- Fill this table for each page that is moved, renamed, or merged.
- Validate mappings with developers before launch.
- Include redirects for variants (www, http/https, with and without trailing slash).

**Htaccess file or server config preparation**
- If you use Apache, prepare the `.htaccess` file with 301 rules.
- If you use Nginx or other, prepare the corresponding server configuration.
- Have it reviewed by developers and SEO.

## Checklist During Redesign: Preserve SEO

This phase runs from the start of development until the new site goes live. It directly interferes with technical execution.

**301 redirect plan in place**
- Implement all redirects before the new site goes live.
- Verify that each redirect works (test with curl or a redirect checker).
- Verify HTTP status 301 (not 302, 307, or temporary 302).

**Preservation of tags and content**
- Copy and fully preserve the content of high-performing pages identified in phase 1.
- Ensure each H1, H2, title, and meta description matches the original content (or an improved version of the same content, never diminished).
- Preserve images and their alt attributes.

**Internal linking intact**
- Recreate all internal links pointing to key pages.
- Update link anchors so they remain relevant and contextual.
- Verify that menu, footer, and call-to-action links point to the correct URLs.

**Staging environment isolated from Google**
- Deploy the new site on a staging or test environment inaccessible to search engines.
- Add a `User-agent: *` / `Disallow: /` directive in the staging `robots.txt`.
- Or use HTTP authentication to block access.
- Perform all SEO tests on staging before production deployment.

**SEO testing in staging**
- Verify HTML validity and mobile responsiveness.
- Verify [Core Web Vitals](https://leviers.ai/en/blog/core-web-vitals-2026/).
- Validate Open Graph tags and schema.org.

## Checklist After Redesign: Validate and Correct

This phase starts on launch day and extends over several weeks.

**Redirect verification**
- A few hours after going live, crawl the site completely and verify that old URLs properly redirect to new ones.
- Test a sample of 100+ URLs with Google Search Console or a redirect checker.
- Look for redirect chains (URL A → URL B → URL C instead of A → C directly).

**Sitemap and robots.txt update**
- Publish a new sitemap.xml listing all production URLs.
- Verify all old URLs are removed from the sitemap.
- Verify robots.txt does not block important pages.
- Submit the sitemap to Google Search Console.

**Position and crawl tracking**
- Check [our rank tracking tools](https://leviers.ai/en/blog/rank-tracking-tools-comparison/) to track ranking changes.
- Run weekly crawls during the first month to compare against the baseline.
- Monitor indexed pages in Google Search Console and organic traffic in Google Analytics 4.

**Rapid 404 correction**
- Identify 404 URLs via GSC or crawl.
- Create missing redirects.
- Verify external backlinks and redirect them correctly.

**Rebuilding Google's context**
- Allow 2 to 4 weeks for Google to rediscover and re-evaluate new URLs.
- During this period, continue monitoring traffic, crawl errors, and indexation.
- Publish new or optimized content to accelerate re-crawl.

## Summary Table: Complete Checklist by Phase

| Task | Before | During | After |
|---|---|---|---|
| **Audit and documentation** | Export URLs, technical crawl, Google positions | | Compare old vs new crawl |
| **301 redirects** | Map old URL → new URL | Implement and test all redirects | Verify redirects and look for 404s |
| **High-performing content** | Identify and save key pages | Preserve exact content, H1/H2 tags, meta | Monitor positions of migrated pages |
| **Internal linking** | Document key links | Recreate links and update URLs | Check broken links and adjust |
| **Robots.txt and sitemap** | Verify old robots.txt | Prepare new robots.txt and sitemap | Publish sitemap, submit to GSC |
| **Performance and Core Web Vitals** | Benchmark old site | Test mobile responsiveness and CWV in staging | Monitor CWV in production |
| **Blocking search engines** | | Block Google from test environment (robots.txt / auth) | |
| **Monitoring and alerts** | | | Weekly crawls, daily traffic, indexation |

## Realistic Recovery Timelines

Traffic recovery after a redesign depends on the quality of your SEO execution:

**Week 1 to 2: Discovery and initial drop**
Traffic often drops 20 to 40 percent immediately after launch. This is normal: Google crawls the new site, validates redirects, and understands the new structure. Positions drop temporarily, then begin to stabilize if redirects are correct.

**Weeks 3 to 12: Progressive recovery**
Traffic increases gradually. A majority of previously high-performing pages recover their original positions or improve. This phase varies depending on site age, size, and quality of incoming link signals.

**Beyond 12 weeks: Stabilization**
If everything has been executed correctly, traffic should have recovered 80 to 100 percent of its pre-redesign level. If traffic remains below 70 percent after three months, there are likely unidentified issues: missing redirects, diminished content, unintended robot blocking.

## Frequently Asked Questions

<details>
<summary>Can you do a redesign without 301 redirects?</summary>

Technically yes, but it is very risky. Without redirects, Google sees the old pages as gone and the new ones as duplicate or new content. Traffic can take 6 to 12 months to recover, if it recovers at all. Backlinks do not transfer their power to the new URLs. Unless a very minor redesign, 301s are non-negotiable.

</details>

<details>
<summary>How long before I see my traffic return to normal?</summary>

It depends on site size and complexity. For a site of 100 to 500 pages with good SEO execution, plan for 4 to 8 weeks. For a site with several thousand pages, expect 3 to 6 months. Sites with many external backlinks may be slower to recover because Google must validate that links still point to valid content.

</details>

<details>
<summary>Should you redesign before or after a major technical migration?</summary>

If possible, combine both in one operation. Doing two major migrations (CMS change plus design change) one after the other prolongs confusion for Google and doubles the risks. One well-planned migration is simpler to manage. If you must separate them, start with the technical migration (to stabilize architecture), then redesign a few weeks after Google has re-stabilized indexation.

</details>
