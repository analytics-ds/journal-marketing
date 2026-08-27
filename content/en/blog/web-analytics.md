---
title: "Web Analytics: Definition, Metrics and Tools"
translationKey: "web-analytics"
date: "2026-08-25"
lastmod: "2026-08-25"
description: "Web analytics measures and analyzes a site's traffic to understand visitor behavior and guide marketing decisions."
categories: ["Tools and comparisons"]
tags: ["web analytics", "google analytics", "ga4", "kpi", "guide"]
author: "julien-roy"
auteurs: ["julien-roy"]
image: "/images/blog/web-analytics.webp"
imageAlt: "Web analytics dashboard showing visitors in real time"
imageCredit: "Photo par psd via Flickr (CC BY 2.0)"
faq:
  - question: "What is the difference between web analytics and Google Analytics?"
    answer: "Web analytics is a discipline, the measurement and analysis of a site's audience. Google Analytics, and its current version GA4, is one of the tools used to practice it, alongside Matomo or Hotjar. Confusing the two is like confusing accounting with one particular accounting piece of software."
  - question: "What are the essential web analytics KPIs?"
    answer: "The most tracked metrics are the number of sessions, pages per session, average time on page, exit rate and traffic acquisition sources. Which KPIs to prioritize still depends on the site's goal, since an e-commerce site and an editorial blog do not prioritize the same metrics."
  - question: "Is web analytics compatible with GDPR?"
    answer: "Yes, provided the framework set by data protection authorities is respected: consent collected before audience measurement cookies are set, clear information for visitors, and a limited retention period for the data. Some tools offer a consent exempt measurement mode when they meet strict anonymization criteria."
  - question: "Which tools should be used to get started with web analytics?"
    answer: "GA4 remains the default choice for its free access and its integration with the Google Ads and Search Console ecosystem. Matomo appeals to organizations that want to host their own data. Hotjar and similar tools usefully complement raw numbers with session recordings and heatmaps."
  - question: "Are web analytics and data analytics the same thing?"
    answer: "No. Web analytics is limited to measuring audience and behavior on a site or app. Data analytics is a broader field, covering all of an organization's data, including data that does not come from the web: in store sales, customer support or production."
---

**Web analytics** refers to the measurement, collection and analysis of a site's traffic data to understand the behavior of its visitors. This discipline underpins most of the marketing decisions made on a site, from choosing what content to publish to allocating an advertising budget. This guide covers what web analytics actually means, the metrics that really matter and the tools used to track them.

## What is web analytics

Web analytics brings together the methods used to collect, measure and analyze data related to a website and its visitors, with the goal of improving its performance. It combines passive measurement, what visitors actually did on the site, with active interpretation, what that data means and what should be done about it.

In practice, a web analytics setup tracks a visitor's journey from arrival, through a search engine, a social network or a direct link, to their exit, including the pages viewed and the actions taken along the way. This overview makes it possible to spot the pages that hold attention, the ones that lose it, and the paths that most often lead to a conversion.

Web analytics is not limited to counting visitors. It covers traffic acquisition, on site behavior analysis, conversion tracking and, for more advanced organizations, visitor retention over time.

## Why measure a site's audience

Without measurement, a marketing decision rests purely on intuition. Web analytics replaces that intuition with observed data: which pages drive the most traffic, which acquisition sources are the most profitable, at what point in the journey visitors drop off.

This measurement serves three main purposes. Day to day monitoring, first, to check that a campaign or a publication produces the expected effect. Diagnosis, next, to understand why a page underperforms or why a conversion rate suddenly drops. Budget arbitration, finally, to direct marketing investment toward channels that prove their effectiveness rather than those that simply appear active.

A site that steers its online presence without web analytics operates blind: it can publish content, launch campaigns or redesign pages without ever knowing whether those actions bring it closer to, or further from, its actual goals.

## The key metrics to track

The number of metrics available inside a web analytics tool far exceeds the ones worth tracking day to day. A handful of them capture most of the value.

| Metric | What it measures |
|---|---|
| Sessions | Number of visits, since one visitor can generate several sessions |
| Pages per session | Average number of pages viewed during a visit |
| Average time on page | Attention span given to a specific piece of content |
| Exit rate | Share of visitors who leave the site from a given page |
| Acquisition sources | Traffic origin: organic, paid, direct, social |

Sessions and traffic volume give an overall view of the site's reach. Pages per session and time on page indicate engagement, with a high figure suggesting content that holds attention. Exit rate helps spot pages that lose visitors, a signal often tied to a degraded reading experience or content that fails to match expectations. Acquisition sources, finally, make it possible to measure the relative effectiveness of each marketing channel rather than judging overall traffic without distinction.

None of these metrics carries meaning on its own. A high average time on page can reflect content that captures attention just as easily as a confusing interface that slows navigation down: context and comparison over time matter as much as the number itself.

## The main web analytics tools

**GA4**, the current version of Google Analytics, has established itself as the default tool for a large share of sites, free and natively connected to the Google Ads and Search Console ecosystem. Its measurement model is built around events rather than fixed sessions, which changes how reports get built compared with the older Universal Analytics version.

Matomo occupies a different place: open source and self hostable, it appeals to organizations that want full control over their measurement data, a criterion that weighs increasingly heavily in decisions tied to data protection rules.

Tools such as Hotjar complement raw numbers with a qualitative reading: session recordings, heatmaps and on site surveys make it possible to understand the why behind a number, where GA4 or Matomo only cover the what. To visualize and cross reference this data once collected, a reporting tool like [Looker Studio](/en/blog/looker-studio/) remains the most widely used free option.

Choosing between these tools depends less on an absolute hierarchy than on the actual need: comprehensive, free measurement for most sites, sovereign hosting for organizations sensitive about data, qualitative reading on top to sharpen a diagnosis.

## Web analytics and GDPR: what changes

Audience measurement most often involves setting cookies or trackers on the visitor's device, an operation governed by GDPR and data protection authority guidance. The baseline principle remains prior consent: a visitor must be able to accept or refuse measurement before it runs, through a clear and non misleading cookie management banner.

An exception exists for audience measurement tools that meet strict anonymization criteria set by data protection authorities: no data shared with third parties, a limited retention period and no cross referencing with other processing. These consent exempt tools make it possible to keep a baseline measurement even when a visitor refuses non essential cookies, at the cost of reduced granularity compared with a tool subject to consent.

This regulatory constraint is not specific to web analytics, it applies to the whole range of digital measurement setups, including those tied to [Google Ads campaigns](/en/blog/what-is-google-ads/). It partly explains the growing interest in self hosted solutions, which make it simpler to demonstrate compliance to a visitor or a supervisory authority.

## Structuring an effective measurement approach

A useful web analytics setup starts with objectives defined before data collection, not after. Tracking dozens of metrics without knowing which one drives a decision produces dashboards that are packed but rarely consulted.

The soundest approach starts from a precise business question, such as identifying the most profitable acquisition channel or spotting the pages that hold back a conversion, then works back to the metrics that answer it. This reverses the logic of starting from everything a tool can measure and only then looking for a use for it.

Consistency across tools matters just as much. A [conversion rate calculation](/en/blog/conversion-rate-calculation/) done differently from one team to another, or session definitions that diverge between two dashboards, undermine trust in the numbers before any decision even gets made from them. Documenting the definition of each tracked metric, in the same place as the reports themselves, avoids these silent disagreements.

For organizations short on internal resources to structure this approach, turning to [agencies specialized in web analytics](/en/blog/best-web-analytics-agencies/) saves a setup time that few marketing teams can spare on their own.

## Frequently asked questions

<details>
<summary>What is the difference between web analytics and Google Analytics?</summary>

Web analytics is a discipline, the measurement and analysis of a site's audience. Google Analytics, and its current version GA4, is one of the tools used to practice it, alongside Matomo or Hotjar. Confusing the two is like confusing accounting with one particular accounting piece of software.

</details>

<details>
<summary>What are the essential web analytics KPIs?</summary>

The most tracked metrics are the number of sessions, pages per session, average time on page, exit rate and traffic acquisition sources. Which KPIs to prioritize still depends on the site's goal, since an e-commerce site and an editorial blog do not prioritize the same metrics.

</details>

<details>
<summary>Is web analytics compatible with GDPR?</summary>

Yes, provided the framework set by data protection authorities is respected: consent collected before audience measurement cookies are set, clear information for visitors, and a limited retention period for the data. Some tools offer a consent exempt measurement mode when they meet strict anonymization criteria.

</details>

<details>
<summary>Which tools should be used to get started with web analytics?</summary>

GA4 remains the default choice for its free access and its integration with the Google Ads and Search Console ecosystem. Matomo appeals to organizations that want to host their own data. Hotjar and similar tools usefully complement raw numbers with session recordings and heatmaps.

</details>

<details>
<summary>Are web analytics and data analytics the same thing?</summary>

No. Web analytics is limited to measuring audience and behavior on a site or app. Data analytics is a broader field, covering all of an organization's data, including data that does not come from the web: in store sales, customer support or production.

</details>
