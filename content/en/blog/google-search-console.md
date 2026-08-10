---
title: "Google Search Console: The Complete Guide"
translationKey: "google-search-console"
date: "2026-08-06"
lastmod: "2026-08-06"
description: "Google Search Console tracks a site's indexing, performance and traffic in Google results, and helps fix errors."
categories: ["SEO"]
tags: ["google", "guide", "indexing", "crawl", "webmaster"]
author: "thomas-durand"
auteurs: ["thomas-durand"]
image: "/images/blog/google-search-console.jpg"
imageAlt: "Illustration representing SEO optimization and site performance tracking"
imageCredit: "Photo par Sean MacEntee via Flickr (CC BY 2.0)"
faq:
  - question: "What is the point of using Google Search Console for a site?"
    answer: "Google Search Console gives access to the queries that actually bring traffic from Google, flags poorly indexed pages, and surfaces technical errors before they cost traffic. It is the only direct source of data sent by Google about how it crawls and displays a site."
  - question: "How do you use Google Search Console on a daily basis?"
    answer: "Common practice is to watch the performance report for queries that are rising or falling, check the coverage report after each publication, and act on email alerts as soon as they arrive rather than letting them pile up."
  - question: "Is Google Search Console a paid tool or a free one?"
    answer: "Google Search Console is entirely free, with no traffic cap and no feature reserved for a paid tier. A Google account is enough to activate it on an unlimited number of sites."
  - question: "How does Google Search Console differ from Google Analytics?"
    answer: "Google Search Console documents the relationship between a site and the Google search engine before the click: queries, positions, click through rate, indexing. Google Analytics measures what happens after the click, on the site itself, regardless of the visitor's channel of origin. The two tools are complementary and are best read together."
  - question: "How do you sign in to Google Search Console and add a site?"
    answer: "Signing in only requires a regular Google account at search.google.com/search-console. Adding a site then requires proving ownership, through a DNS record, an HTML file to upload, a meta tag, or more simply through a property already verified in Google Analytics or Google Tag Manager."
  - question: "How do you check if a page is indexed with Google Search Console?"
    answer: "The URL inspection tool, available from the search bar at the top of the interface, shows whether a specific page is indexed, the date of Google's last crawl, and, where relevant, the reason for non indexing. It also allows requesting a new crawl after a fix."
---

> **In short:**
> 1. Google Search Console is Google's free service that shows how a site is crawled, indexed and displayed in search results.
> 2. The performance report reveals the queries that actually trigger a page's display, along with their average position and click through rate.
> 3. Setup requires verifying site ownership, a step worth rechecking after any technical migration.

**Google Search Console** is the free service Google provides to site owners so they can understand how their pages are crawled, indexed and displayed in search results. Long known as Webmaster Tools, it remains the only direct communication channel with the search engine.

## What is Google Search Console

Google Search Console centralizes the data Google collects about a site while crawling it: discovered pages, errors encountered, queries that trigger its display, average position and click through rate. No other tool, even a paid one, has access to this information, since it comes directly from Google's own infrastructure.

The tool is meant for anyone responsible for a site, whether a personal blog, a showcase site or an ecommerce platform. It does not replace a standard traffic analytics tool, but it sheds light on what happens before the click, at the moment Google decides whether to display a page at all.

Access can be shared among several people on the same site, with three distinct permission levels: **owner**, who can add or remove other users and change settings, **full access**, which allows viewing and acting on most reports, and **restricted access**, limited to reading. This fine grained access suits teams where several people work on the same site's search visibility without all needing the same rights.

## Setting up and verifying site ownership

Access to Google Search Console requires creating a property, then proving ownership of the site in question. Two property types exist: **domain**, which covers every variant (subdomains, http, https), and **URL prefix**, simpler to set up but limited to a single exact address.

Verification can be done through several methods: adding a DNS record with the host, uploading an HTML file to the site root, inserting a meta tag into the homepage code, or automatically inheriting a property already verified in another Google tool. This step is worth rechecking after any technical migration, a moment when sites often lose their verification without noticing, as detailed in our [SEO checklist for a site redesign](/en/blog/seo-website-redesign-checklist/).

Once the property is verified, it is recommended to submit the site's XML sitemap from the corresponding menu: this speeds up discovery of new pages, without guaranteeing their indexing.

## The main reports in Google Search Console

The interface is organized around a handful of reports that cover most of a site's needs.

| Report | What it shows | Main use |
|---|---|---|
| Performance | Queries, clicks, impressions, average position | Track organic traffic by page and by keyword |
| Page indexing | Indexed, excluded and errored pages | Detect indexing issues |
| Sitemaps | Submitted files and their processing status | Check that the sitemap was picked up |
| Page experience | Signals tied to loading and visual stability | Spot pages that hurt user experience |
| Links | Domains and pages linking to the site | Track the inbound link profile |

The performance report is the most consulted one day to day: it lets you compare queries that generate the most impressions against those that generate the most clicks, a gap that often reveals an unappealing **title tag** or **meta description**, a point covered in detail in our guide on [title tags and meta descriptions](/en/blog/title-tag-meta-description/).

The page experience report relies on the same signals tracked in our analysis of Core Web Vitals, with the advantage of presenting them by URL group rather than page by page.

Alongside these reports sit sections dedicated to structured data: each type of markup detected (reviews, FAQ, breadcrumb, recipe) gets its own validity report, with the detail of errors and warnings per page. This is where you verify that Schema.org markup added to the code is correctly read by Google, independently of how it renders visually on the site.

## Is Google Search Console a free tool

Google Search Console is entirely free, with no paid tier and no cap on traffic or number of tracked sites. A simple Google account is enough to create as many properties as needed. This is a choice consistent with Google's own interest in having webmasters well informed about the technical state of their sites.

This free access makes it a mandatory first stop before even considering paid third party rank tracking or technical audit tools. Many of the [most common SEO mistakes](/en/blog/seo-mistakes-to-avoid/) show up first in the tool's native reports, well before a full audit is ever launched.

## Google Search Console versus Google Analytics: the real differences

Google Search Console and Google Analytics answer two different questions. The former documents the relationship between a site and the search engine: which queries trigger it, at what position, with what click through rate, and which pages are indexed or not. The latter measures visitor behavior once they land on the site, regardless of the acquisition channel, organic or otherwise.

The two tools are best read together: a page that gets many impressions in Search Console but few clicks deserves work on its title tag, while a page that gets clicks but shows a high bounce rate in Analytics points instead to its content or its experience. Neither tool replaces the other.

A common example illustrates this complementarity: a technical page ranking well for a precise query can show an excellent click through rate in Search Console while generating little time on page in Analytics, simply because it answers the question in a few lines. The conclusion to draw differs depending on whether each tool is read alone or the two are cross referenced.

## Tracking indexing for generative engines with Google Search Console

Coverage and crawl reports remain relevant in the age of generative engines: content that Googlebot fails to crawl properly also cannot feed Google's AI answers, which largely draw on the same index. Watching crawl frequency and quickly fixing 404 errors or redirect chains therefore remains a prerequisite, a topic covered in depth in our article on crawl budget and the signals to watch.

Google Search Console does not yet offer a report dedicated to citations in AI Overviews, but a healthy indexing base, measurable in the tool, remains the starting condition for hoping to appear there.

## Frequently asked questions

<details>
<summary>What is the point of using Google Search Console for a site?</summary>

Google Search Console gives access to the queries that actually bring traffic from Google, flags poorly indexed pages, and surfaces technical errors before they cost traffic. It is the only direct source of data sent by Google about how it crawls and displays a site.

</details>

<details>
<summary>How do you use Google Search Console on a daily basis?</summary>

Common practice is to watch the performance report for queries that are rising or falling, check the coverage report after each publication, and act on email alerts as soon as they arrive rather than letting them pile up.

</details>

<details>
<summary>Is Google Search Console a paid tool or a free one?</summary>

Google Search Console is entirely free, with no traffic cap and no feature reserved for a paid tier. A Google account is enough to activate it on an unlimited number of sites.

</details>

<details>
<summary>How does Google Search Console differ from Google Analytics?</summary>

Google Search Console documents the relationship between a site and the Google search engine before the click: queries, positions, click through rate, indexing. Google Analytics measures what happens after the click, on the site itself, regardless of the visitor's channel of origin. The two tools are complementary and are best read together.

</details>

<details>
<summary>How do you sign in to Google Search Console and add a site?</summary>

Signing in only requires a regular Google account at search.google.com/search-console. Adding a site then requires proving ownership, through a DNS record, an HTML file to upload, a meta tag, or more simply through a property already verified in Google Analytics or Google Tag Manager.

</details>

<details>
<summary>How do you check if a page is indexed with Google Search Console?</summary>

The URL inspection tool, available from the search bar at the top of the interface, shows whether a specific page is indexed, the date of Google's last crawl, and, where relevant, the reason for non indexing. It also allows requesting a new crawl after a fix.

</details>
