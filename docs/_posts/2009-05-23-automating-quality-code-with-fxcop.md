---
title: "Automating Quality Code with FXCop"
date: "2009-05-23"
tags: 
  - "code-analysis"
---

[FXCop](http://www.gotdotnet.com/Team/FxCop/) is a tool that can analyze .NET manage code for conformance to design guidelines and your own custom rules. I recently found a great document that explicitly outlines how to create you own custom rules from [Jason Kresowaty](http://www.binarycoder.net/fxcop/). Some possible custom rules I am considering include:

### Security Rules

- SQL Injection
- Session Hijacking
- Cross Site Scripting
- Sensitive Data in Query String
- Sensitive Data in Form Fields
- Sensitive Data in ViewState

### Performance Checks

- YSlow Suggestions
- Company Specific Rules
- Using Common Logging

And More
