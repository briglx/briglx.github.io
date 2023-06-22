---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Search nodejs with regex and case insensitive"
date: "2012-04-10"
tags:
  - "software"
  - "javascript"
  - "mongodb"
  - "mongoose"
  - "nodejs"
  - "regex"
---

I recently needed to search for documents in mongo using mongoose. I knew I needed a regex but couldn't figure out how to pass the case insensitive flag. We'll here is how you do it.

`var term = 'Apple'; Ideas.find({'title' : new RegExp(term, "i")}, function(err, ideas){...});`

## Resources

[RegEx documentation](https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/RegExp)
