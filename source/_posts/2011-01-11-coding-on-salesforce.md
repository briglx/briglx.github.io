---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Coding on SalesForce"
date: "2011-01-11"
---

Tutorial #6 introduces the concept of Unit Test and has me creating a unit test for a trigger I wrote.

First I want to mention that the eclipse plugin for SalesForce is very mature. It integrates with the SalesForce account I have. When I update code in the IDE, the server is updated. I can even Refresh from the server.

The language is similar to Java/C# but some concepts are new:

- Initializing Object is Simplified. I can just call `new MyObject(foo="bar", baa="asfd");`
- Certain governor limits. 2 million chars
- SOQL Query Language
- Custom Test Framework
- Custom Code Coverage Tool
