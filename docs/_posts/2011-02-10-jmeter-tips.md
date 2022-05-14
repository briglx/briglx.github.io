---
title: "JMeter Tips"
date: "2011-02-10"
tags: 
  - "jmeter"
---

Extracting Text from Responses Use the Regular Expression Extractor and have it as a child on the request you want to get data from. Set the template value to $1$ to populate your variable name with the matched item in the group (). Otherwise your variable will be called

refName - the value of the template refName\_gn, where n=0,1,2 - the groups for the match refName\_g - the number of groups in the Regex (excluding 0)

Use Global variable for hostname Be sure to check the Servername on all Http Requet to make sure they are not overriding the global one.
