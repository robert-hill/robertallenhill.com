---
title: Do I really need a high-end laptop?
description: My company issued me a high-end laptop and I wish they hadn't.
slug: laptop-blues
author: Robert Hill
date: 2022-01-16T22:22:44-08:00
draft: false
tags:
  - philosophy
  - development
  - technology
lastmod: 2022-04-02T06:13:26.649Z
---

### Why do I keep getting top spec machines?

*This* bugs me, and I feel bad for complaining about it. In my career, I have generally been issued laptops that I *flat out will not use to their maximum capabilities.* I work on highly automated SaaS apps. I have worked on this type of an application for years. There are lots of dependencies and running a full stack locally just doesn't make sense. I specifically leverage CI/CD tests to report on defects as I develop. It's relatively inexpensive to have GitHub or CircleCI fail my build for the vast majority of my work, especially when I introduce a regression or there is a security vulnerability.

This post is drawn from a recent gripe that I have. I volunteered to be on our internal team for feedback and assistance in migrating our Intel-based local MacOS engineering teams to the `arm64` "Apple Silicon M1" based platforms, which are what most corporate customers have available through FY2022.

### Doesn't everyone want the best of the best?

My organization has essentially mandated *16" MacBook Pro M1 Pro* laptops to all engineers, regardless of location or work-from-home status. This seems short-sighted.

* **The 16" M1 Pro Macbook Pro is much more powerful than nearly anyone will need for a typical 4 year refresh cycle.**
  
* **End user workflow is much more important than maximum performance in most cases.**
  
* **Work from home policies make the ability to dock when at home, with ultraportability features when commutes are necessary exceedingly valuable.**
  

This is a time period where less is more, in my opinion. I admit, I have asked for top-spec workstations in the past. It was during my tenure where I was in charge of high-performance computing applications where I was expected to test and develop against a real codebase *locally* using tools that could not be distributed and where our workflows were expensive and/or blocking teams based on licenses or compute capacity.

### Why does this matter?

These concerns simply do not exist in the era of cloud computing, modern CI/CD workflows, and the ability to implement segmented and intelligent test frameworks that allow you to block builds at various stages in the software development lifecycle. 

These days, I strongly support the individual considerations when it comes to personal equipment choices. I would have no problem whatsoever using a base model MacBook Air or other ultraportable notebook for my main workstation. Some of my colleagues may not have the same requirements. This is not something an IT organization or other top down management style should mandate or provision from a one-size-fits-all perspective.

Very rarely do I need to run the full application stack that I am supporting or developing against. We already have a number of test and integration stages to iterate on projects or features. Even if I do hit a situation where this would be handy, I can trade performance temporarily for the cost and size benefits when opting for a smaller or less powerful workstation.

### Okay, are you just being ungrateful?

When you are working at a startup, being realistically frugal is an important consideration. We should not default to the most expensive and "performance-oriented" equipment just because it is flashy or expected. Professionals should be enabled and able to determine the best cost benefit for what they need to do day to day. Outliers and edge cases really should not drive a decision where the difference in cost is measured in thousands of dollars.

I just want to be able to choose what works for me without feeling like I am looking a gift horse in the mouth.

*Also... all my favorite bags only fit a maximum of a 13" laptop.*

-- Robert

*Edited for content and style 1/16 23:30 PT*