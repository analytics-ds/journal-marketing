---
title: "Server Side Tracking: A Complete Guide"
translationKey: "tracking-server-side"
date: "2026-09-24"
lastmod: "2026-09-24"
description: "What is server side tracking: definition, advantages, limits and key steps to set it up in compliance with GDPR."
categories: ["Data and measurement"]
tags: ["tracking", "gdpr", "google", "guide", "consent"]
author: "julien-roy"
auteurs: ["julien-roy"]
image: "/images/blog/tracking-server-side.jpg"
imageCredit: "Photo by Brett Sayles via Pexels"
imageAlt: "Row of server racks in a data center, network cabling visible"
faq:
  - question: "Does server side tracking completely replace client-side tracking?"
    answer: "No, the two approaches most often coexist. Server side tracking handles the collection and forwarding of data to measurement tools, but some events tied to in-browser behavior, such as page scrolling or time spent on a screen, remain simpler to capture on the client side. Most organizations combine both rather than switching entirely from one model to the other."
  - question: "Does server side tracking remove the need to collect consent?"
    answer: "No. Moving collection to a server changes nothing about the obligation to collect a user's consent before setting a cookie or processing personal data in France. GDPR compliance depends on the purpose of the processing and on collecting consent, not on the technical channel through which the data travels."
  - question: "What tools allow setting up server side tracking?"
    answer: "Google offers a server side version of Google Tag Manager, which remains the most documented option for teams already familiar with the tool. Third party tag management platforms and dedicated consent management solutions also exist, with varying levels of integration depending on the measurement tools already in place."
  - question: "Does server side tracking really improve site performance?"
    answer: "It reduces the number of third party scripts executed directly in the visitor's browser, which lightens the page on the client side. The real gain depends on how many tools are migrated to the server side and on the existing architecture: a site with few third party tags will see a more limited effect than a site that stacks up dozens of them."
  - question: "Do you need technical skills to deploy server side tracking?"
    answer: "Yes, more than for a classic client-side deployment. Setting it up requires configuring a server or a cloud container, managing a dedicated subdomain and verifying that data is correctly routed to each measurement tool. A technical team or a specialized provider generally supports this type of project, at least for the initial phase."
---

**Server side tracking** refers to a data collection method that routes measurement data through an intermediary server, rather than sending information directly from the visitor's browser to each third party tool. Data and marketing teams have grown more interested in it as browsers restrict third party cookies and as the reliability of client-side measurement degrades. This guide covers how it works, its real advantages, its limits and the steps to deploy it.

## What is server side tracking?

Server side tracking consists of routing measurement data (visits, conversions, events) through a server before sending it on to analytics or advertising tools, instead of having the browser send information directly to each of them. In practice, the site triggers an event sent to a server, generally hosted on a subdomain of the site itself, which then redistributes that data to Google Analytics, an advertising platform or a CRM.

This architecture shifts the collection point, but does not change the nature of the data collected. A click on an add to cart button remains a click on an add to cart button: what changes is the technical path that information follows before reaching the tool that uses it.

### Server side tracking versus client-side tracking

Client-side tracking, historically the most common approach, runs measurement code directly in the visitor's browser. Each tool (Google Analytics, an advertising pixel, a chat tool) loads its own script, which then sends data straight from the browser.

| Criterion | Client-side tracking | Server side tracking |
|---|---|---|
| Execution location | Visitor's browser | Intermediary server |
| Exposure to ad blockers | High | Reduced |
| Number of scripts loaded in the browser | One per tool | A single entry point |
| Control over transmitted data | Limited | Reinforced, filtering possible before sending |
| Setup complexity | Low to moderate | Moderate to high |

Server side tracking does not necessarily replace client-side tracking entirely: the two approaches are frequently combined, with the shift to the server side concentrating first on the tools most exposed to blocking or most critical for measuring conversions.

## Why server side tracking is gaining ground

Several technical developments are pushing data teams toward server side tracking. The gradual restriction of third party cookies by browsers shortens the lifespan of identifiers used to follow a visitor from one session to the next. Privacy protection features built into some browsers also limit how long a cookie set in JavaScript stays readable, which artificially shortens the attribution windows measured on the client side.

Ad blockers and privacy extensions, increasingly installed by default or by choice, intercept a share of measurement scripts loaded from the browser before they even run. An event blocked on the client side is an event lost for the measurement tool, which distorts traffic and conversion reports without any alert flagging it. Server side tracking does not bypass these protections: it simply moves part of the collection to a channel less directly targeted by such blocking.

## The advantages of server side tracking

The main appeal of server side tracking lies in the robustness of collection in the face of browser changes and blocking tools. An intermediary server escapes some of the filters applied to known third party domains, which limits the loss of events compared to collection carried out purely on the browser side.

### More reliable data and better data collection

Routing data collection through a server also makes it possible to add a control step before sending to each tool: bot filtering, cleaning of URL parameters, enriching an event with data already known on the server side. This intermediary step improves the quality of the data transmitted, rather than settling for a raw send straight from the browser. This is also the kind of reliability sought by teams building their reports in [Looker Studio](/en/blog/looker-studio/): a report is only as good as the data feeding it upstream.

### An improvement in page loading performance

Reducing the number of third party scripts executed directly in the browser lightens the weight of pages and the number of requests triggered on load. Each third party script removed from the browser represents one fewer network request and one less execution time for the visitor's device, which works in favor of the perceived speed of the page, a criterion closely watched by SEO teams as much as by technical teams.

## The limits to know before getting started

Server side tracking does not solve everything and introduces its own constraints. Setting it up requires additional infrastructure (a server or a cloud container, a dedicated subdomain) to maintain over time, with a hosting and technical follow up cost that purely client-side tracking does not require. Not every measurement tool or advertising platform has a server side integration as mature as its client-side equivalent, which can force teams to keep some scripts on the browser side in parallel.

Diagnostic complexity also increases: an event that fails to reach a measurement tool can now originate from a problem on the site, on the intermediary server, or in the configuration specific to the final tool, which lengthens resolution time compared to a chain running purely on the browser side.

## GDPR compliance and consent management

Moving collection to a server removes none of the obligations tied to protecting personal data. GDPR applies to the purpose of the processing and to the information given to the user, not to the technical channel through which the data travels. A cookie set via an intermediary server remains subject to the same consent rules as a cookie set directly in JavaScript from the browser.

The CNIL's recommendations on cookies and trackers in France therefore continue to apply in full: consent must be collected before any non essential deposit, refusing must be as simple as accepting, and retention periods must remain limited. A consent management platform (CMP) remains necessary to orchestrate these choices, whether it then forwards the consent status to a tracking server or directly to third party tools. Server side tracking must factor in the user's consent status before sending any data, exactly as a well configured client-side script would.

## How to set up server side tracking

Deploying server side tracking follows a logic close to that of a classic technical project, with an audit phase, a configuration phase and a verification phase.

### The technical building blocks

Google offers a server side version of [Google Tag Manager](/en/blog/what-is-google-tag-manager/), which reuses the tag, trigger and variable logic of its classic version, but hosts the container on a separate server rather than in the browser. Other tag management platforms and solutions dedicated to server side collection exist, with varying levels of compatibility depending on the analytics tools and advertising platforms already in use. A consent management platform remains essential upstream, to pass each visitor's consent status to the server side container.

### The key steps of deployment

An audit of the existing setup comes before any implementation: an inventory of active tags, connected measurement tools and the data actually used by marketing teams, a task close to what [web analytics agencies](/en/blog/best-web-analytics-agencies/) carry out before making any technical recommendation. This audit helps identify which tags to migrate first, generally those measuring conversions or most exposed to blockers. Next comes configuring the server side container on a subdomain of the site, followed by setting up each tag so it routes through this new channel instead of directly from the browser. A testing phase in a preview environment checks that every event correctly reaches the expected measurement tool before switching to production, and close monitoring during the first weeks helps spot any unexpected gap in volume between the old and the new collection method.

## What server side tracking changes for marketing teams

For teams running marketing campaigns, the promise of server side tracking mainly lies in restoring the reliability of attribution data. A conversion correctly measured, even when the visitor's browser blocks part of the third party scripts, avoids underestimating the real performance of an acquisition channel and making a budget decision on an incomplete basis. This gain benefits advertising campaigns first and foremost, where every missed conversion directly distorts the calculation of return on investment.

Server side tracking does not, however, remove the need to regularly check the consistency of collected data against other sources, such as the [marketing dashboards](/en/blog/marketing-dashboard/) that centralize the indicators a team tracks. A shift to a server side architecture deserves to be accompanied by a comparison of volumes measured before and after the change, to confirm that the expected reliability gain actually holds true on the organization's own data.

## Frequently asked questions

<details>
<summary>Does server side tracking completely replace client-side tracking?</summary>

No, the two approaches most often coexist. Server side tracking handles the collection and forwarding of data to measurement tools, but some events tied to in-browser behavior, such as page scrolling or time spent on a screen, remain simpler to capture on the client side. Most organizations combine both rather than switching entirely from one model to the other.
</details>

<details>
<summary>Does server side tracking remove the need to collect consent?</summary>

No. Moving collection to a server changes nothing about the obligation to collect a user's consent before setting a cookie or processing personal data in France. GDPR compliance depends on the purpose of the processing and on collecting consent, not on the technical channel through which the data travels.
</details>

<details>
<summary>What tools allow setting up server side tracking?</summary>

Google offers a server side version of Google Tag Manager, which remains the most documented option for teams already familiar with the tool. Third party tag management platforms and dedicated consent management solutions also exist, with varying levels of integration depending on the measurement tools already in place.
</details>

<details>
<summary>Does server side tracking really improve site performance?</summary>

It reduces the number of third party scripts executed directly in the visitor's browser, which lightens the page on the client side. The real gain depends on how many tools are migrated to the server side and on the existing architecture: a site with few third party tags will see a more limited effect than a site that stacks up dozens of them.
</details>

<details>
<summary>Do you need technical skills to deploy server side tracking?</summary>

Yes, more than for a classic client-side deployment. Setting it up requires configuring a server or a cloud container, managing a dedicated subdomain and verifying that data is correctly routed to each measurement tool. A technical team or a specialized provider generally supports this type of project, at least for the initial phase.
</details>
