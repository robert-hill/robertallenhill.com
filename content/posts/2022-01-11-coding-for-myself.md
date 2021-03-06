---
title: Coding for myself.
slug: coding-for-myself
author: Robert Hill
date: 2022-01-11T20:25:51-08:00
draft: false
tags:
  - development
  - projects
  - automation
lastmod: 2022-04-02T06:13:32.229Z
---

### The Great Reengineering of 2022

I tend to view programming and computers as a professional mechanic views cars; I do as little as possible with them after I am off the clock. Unless it's something fun. There exists a point of inflection between tedious and satisfying that any professional experiences when doing something that, while technically "work," is genuinely enjoyable and fun.

I have been neglecting a lot of my key domain infrastructure for the past few years, and I want to use tools like Terraform, GitHub, and AWS to build a reference design that I am proud of for both the management of resources/configuration and the deployment of web application code. 

I mostly want to wield the tools and code patterns that I use daily for my profession, and build something robust and maintainable compared to my previous strategy that consisted of a git hook that ran an FTP command to sync my static website. What better way to build a zen garden of code than to do it for your own satisfaction?

### The Setup

I built this site entirely using [AWS](https://aws.amazon.com), [Hugo](https://gohugo.io/) (My static site generator of choice), [Terraform](https://www.terraform.io/), [GitHub](https://www.github.com) (and *especially* [GitHub Actions](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions)) with a specific desire to keep things minimal and lean. You can checkout my repository below to investigate the patterns I used for IaC and deployment:

**[Public Repo](https://github.com/robert-hill/robertallenhill.com)**

The basic workflow is:

1. Generate a new post with `hugo new /path/to/post.md` or use a pre-built template.
2. Edit the Markdown for content and formatting.
3. Push to a branch and create a Pull Request.
4. A GitHub Action Workflow will test, stage, and plan production changes (as needed.) It will also build the static site for staging, and ship it to the staging bucket.
5. Merge PR when I am satisfied with the post.
6. The same GitHub Workflow will then prepare production infrastructure and build and ship the production static site.
7. Success.

### So how *well* does it work?

The entire system is surprisingly simple to operate, and allows me to make updates and new posts from nearly every device I own, as long as it can access GitHub. I have a number of templates for posts that make it fairly simple to write on the fly from my tablet or phone. The ability to automatically, in less than a minute, stage changes for proofreading and review is key for this workflow. 

### Next Steps

I think the next priority for my iteration on this new site redesign will be to further streamline the CI/CD process. I would like to only run certain steps and jobs based on committed paths, but GitHub Actions do not support this natively. I have a few more toy projects I'd like to take on, like building out some more interactive features using a NestJS backend and React or something similar, but I am much more interested in making the post creation and propagation flow seamless and easy to use so that I don't let this site languish due to boredom or accessibility concerns. 

-- Robert
