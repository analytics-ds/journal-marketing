---
title: "What Is Google Tag Manager? Definition and How It Works"
translationKey: "google-tag-manager-definition"
date: "2026-09-01"
lastmod: "2026-09-01"
description: "What is Google Tag Manager: definition, how it works, tags and triggers, and how it differs from Google Analytics 4."
categories: ["Data and measurement"]
tags: ["google", "ga4", "tracking", "gtm", "guide"]
author: "julien-roy"
auteurs: ["julien-roy"]
image: "/images/blog/google-tag-manager-definition.webp"
imageCredit: "Photo by Pixabay via Pexels"
imageAlt: "Close-up of colorful CSS code lines on a computer screen for web development."
faq:
  - question: "How do you install Google Tag Manager on a website?"
    answer: "Installation starts with creating an account and a container on the Google Tag Manager platform, which generates a unique identifier and two code snippets. The first snippet goes in the head section of every page on the site, the second right after the opening of the body tag. Once these two snippets are in place, the tool can receive tags without any further modification to the source code. Most site builders (WordPress, Shopify, PrestaShop) offer a dedicated plugin that simplifies this step."
  - question: "How do you configure a tag in Google Tag Manager?"
    answer: "Configuring a tag involves three choices in the interface: the type of tag to create, such as a Google Analytics tag or an advertising pixel, the trigger that defines when it should fire, and the variables that pass it additional information. A preview mode then lets you check that the tag fires correctly before publishing the container to production."
  - question: "How do you remove Google Tag Manager from a website?"
    answer: "Fully removing it involves taking out both code snippets from the site (the head one and the body one), then deactivating or deleting the active tags in the interface if the tool remains in use elsewhere. Removing only the code without addressing active tags can leave orphaned tracking scripts referenced by other tools, which is why it is worth checking dependencies before cutting off access."
  - question: "What is the purpose of tags in Google Tag Manager?"
    answer: "A tag is the code executed for a specific action, for example sending an event to Google Analytics or firing an advertising conversion pixel. Its purpose is to centralize all these small tracking scripts in a single interface rather than scattering them across the site's source code, which makes them easier to update, monitor and remove when needed."
  - question: "Is Google Tag Manager free?"
    answer: "Google Tag Manager is a free tool, with no stated limit on the number of tags, triggers or containers created. A Tag Manager 360 version, part of the Google Marketing Platform suite, exists for organizations that need enterprise level governance and approval workflows, but it only applies to a minority of organizations."
---

**What is Google Tag Manager**, exactly? It is a free tag management system published by Google that lets you add and edit website tracking codes without touching the source code for every change. Marketing and analytics teams use it to install and manage their own measurement tools, without depending on a developer for each adjustment. This guide covers how it works, its components, and how it differs from other Google tools.

## What Google Tag Manager actually is

Google Tag Manager, often shortened to **GTM**, is a tag management system that centralizes all the tracking codes of a website or mobile app in a single interface. One code snippet is installed once on the site, and every subsequent tag (Google Analytics, an advertising pixel, a chat widget) is then managed from the web interface, with no further changes to the source code. This centralization avoids the buildup of stacked scripts that slow down page load and clutter the codebase.

The tool is aimed primarily at teams that manage several measurement tools at once and want more independence from technical teams. An agency, an in house marketing team or a freelance developer can add a new tracking setup in a few minutes, test it in preview mode, and publish it without going through a full development cycle.

Common use cases include tracking advertising conversions, sending custom events to an analytics tool, or installing a retargeting pixel without touching the site's theme or application code. Google Tag Manager does not replace these measurement or advertising tools: it simply makes them easier to install and maintain over time.

## How Google Tag Manager works: tags, triggers and variables

Google Tag Manager's logic rests on three elements that work together in every configuration. The **tag** is the code to be executed, for example sending an event to Google Analytics. The **trigger** defines the precise action that fires that tag, such as a button click or a page load. The **variable** supplies additional information used by the tag or the trigger, such as a purchase amount or the URL of the page visited.

| Element | Role | Example |
|---|---|---|
| Tag | The code that runs | Sending an event to Google Analytics |
| Trigger | When the tag fires | A click on an add to cart button |
| Variable | The information passed | Cart amount, page URL |

These three building blocks come together in a **container**, the unit that groups all the tags for a site or app. Every change to the container can be previewed before publishing thanks to a built in debug mode, which shows in real time which tags fire on a given page. Once validated, changes are published as a version, which also makes it possible to roll back to an earlier configuration if something goes wrong.

## Why use Google Tag Manager instead of hard coded tracking

Hard coding every tag directly into the site has several limits that Google Tag Manager addresses. The first is independence: marketing or analytics teams can create, edit or remove a tracking setup without depending on a developer for every change, which shortens the time between a need and its implementation. The second is a cleaner source code, which stays lightweight since it only holds a single code snippet instead of multiple scripts stacked over time.

The tool also saves time on testing: a tag can be previewed and fixed before publishing, which limits the risk of breaking a tracking setup in production. An article on [conversion rate calculation](/en/blog/conversion-rate-calculation/) illustrates this well: a conversion tag that fires incorrectly directly skews the measured rate, and therefore the budget decisions built on top of it.

Version management adds another layer of safety. Every container publication creates a new dated version, which makes it possible to roll back in one click to a previous configuration if an issue is found after going live. This traceability is often missing from hard coded tags, whose history gets lost across successive versions of the site.

## Google Tag Manager and Google Analytics 4: what is the difference

Google Tag Manager and Google Analytics 4 are two complementary tools, often confused because they are used together. **Google Analytics 4** is the measurement tool that collects and analyzes traffic and visitor behavior data. **Google Tag Manager** is the system that installs and manages the Google Analytics 4 tag, among other tags, without being a measurement or reporting tool itself.

In practice, a common setup involves creating a tag in Google Tag Manager that points to a Google Analytics 4 measurement ID, then defining the events to send (page view, add to cart, form submitted). The collected data can then be reviewed in the Google Analytics 4 interface, or in a [Looker Studio](/en/blog/looker-studio/) dashboard connected to the same property.

## How to install and configure Google Tag Manager

Setup starts with creating an account and a container, tied to a site or app. This step generates a unique identifier and two code snippets to add to the site: one in the page head, the other right after the opening of the body tag. Once these snippets are in place, every tag is managed from the web interface, with no further changes to the source code.

Configuring a tag always follows the same pattern: choose the tag type, define the trigger that activates it, then add the variables it needs. Preview mode makes it possible to check this behavior before publishing. For sites that already track their organic performance through [Google Search Console](/en/blog/google-search-console/), adding a complementary conversion tracking setup through Google Tag Manager helps connect organic traffic to the concrete actions taken on the site.

A good practice is to document every tag created (purpose, trigger, date added) directly in the container, using Google Tag Manager's built in notes feature. This discipline prevents the buildup of orphaned tags whose purpose nobody remembers after a few months. Teams managing several sites with similar measurement needs also benefit from comparing the options listed in this [web analytics agency comparison](/en/blog/best-web-analytics-agencies/), especially when the setup goes beyond available in house skills.

Access management also deserves attention once the container is in place. Google Tag Manager distinguishes several permission levels, from simple read access up to container publishing, which makes it possible to open the tool to several contributors (agency, freelancer, in house team) without giving each of them full production access. Removing access that is no longer needed once a mission ends is one of the regular checks worth keeping up, along with periodically auditing active tags.

## Frequently asked questions

<details>
<summary>How do you install Google Tag Manager on a website?</summary>

Installation starts with creating an account and a container on the Google Tag Manager platform, which generates a unique identifier and two code snippets. The first snippet goes in the head section of every page on the site, the second right after the opening of the body tag. Once these two snippets are in place, the tool can receive tags without any further modification to the source code. Most site builders (WordPress, Shopify, PrestaShop) offer a dedicated plugin that simplifies this step.
</details>

<details>
<summary>How do you configure a tag in Google Tag Manager?</summary>

Configuring a tag involves three choices in the interface: the type of tag to create, such as a Google Analytics tag or an advertising pixel, the trigger that defines when it should fire, and the variables that pass it additional information. A preview mode then lets you check that the tag fires correctly before publishing the container to production.
</details>

<details>
<summary>How do you remove Google Tag Manager from a website?</summary>

Fully removing it involves taking out both code snippets from the site (the head one and the body one), then deactivating or deleting the active tags in the interface if the tool remains in use elsewhere. Removing only the code without addressing active tags can leave orphaned tracking scripts referenced by other tools, which is why it is worth checking dependencies before cutting off access.
</details>

<details>
<summary>What is the purpose of tags in Google Tag Manager?</summary>

A tag is the code executed for a specific action, for example sending an event to Google Analytics or firing an advertising conversion pixel. Its purpose is to centralize all these small tracking scripts in a single interface rather than scattering them across the site's source code, which makes them easier to update, monitor and remove when needed.
</details>

<details>
<summary>Is Google Tag Manager free?</summary>

Google Tag Manager is a free tool, with no stated limit on the number of tags, triggers or containers created. A Tag Manager 360 version, part of the Google Marketing Platform suite, exists for organizations that need enterprise level governance and approval workflows, but it only applies to a minority of organizations.
</details>
