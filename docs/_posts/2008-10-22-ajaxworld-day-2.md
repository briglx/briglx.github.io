---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "AjaxWorld - Day 2"
date: "2008-10-22"
tags: 
  - "web-design"
---

Another day and a little more information. This day had a couple of outstanding presentations. The first was by Kevin Lynch the CTO of Adobe. What a great presenter. The other was Douglas Crawford's survey of JavaScript.

## General Tips and Tricks

[JsLink](http://www.jslint.com/) to validate JavaScript

[Yui Compressor](http://developer.yahoo.com/yui/compressor/) for css/JavaScript minification

[OpenAjax](http://www.openajax.org/index.php) gives ajax guidelines

Use the # to maintain state within your app.

## Push Data to the Cloud

Because users are starting to access the web through multiple devices, there is a need to modify your application to run in the different contexts. Kevin Lynch showed a music library application that accessed his person music through the computer, phone, and Wii.

## Manage Large Data

Charles Kendrick had a lot of good ideas on how to sort and filter high volume dataset. The idea is similar to chunking data. When a sort needs to happen, push the sort back to the DB if the record count is larger than the client page limit.

## Complete Server side Solutions

This section comprised three different sessions. These included Java Server Face, Google's GWT, and finally jMaki. The general idea is developers will use tools to create pages that can call back to the server. [Karthik Shyamsunder](http://www.nofluffjuststuff.com/conference/speaker/karthik_shyamsunder.html) showed how GWT will actually compile down the Java into JavaScript and also merge all images into a single image. The script created is specific for the browser and version.

One technique to do partial rendering of pages is to keep track of the DOM tree and perform a Diff between the two DOMs. Then send down the Diff file to have the client update the parts that need to be updated. Very clever.

Use a publish subscribe bus on the client for inter-component communication.

## JavaScript the Good Parts

This was by far the most informational session. Douglas Crawford presented the ideas found in his book [JavaScript: The Good Parts.](http://oreilly.com/catalog/9780596517748/) In it, he showed how different he === and == operators are and how important it is to use the === all the time. He recommended using [JsLint](http://www.jslint.com/) to verify your JavaScript to ensure you are following the best practices he found.

## Variable User Experience

[Mark Meeker](http://markmeeker.com/events/ajaxworld2008) from Obitz showed how they created their application to down grade gracefully. They first develop the page to work with [POSH](http://en.wikipedia.org/wiki/Plain_Old_Semantic_HTML). Then depending on the user's browser, you can enhance the user experience by hiding detail with JavaScript and CSS. They also use build test to enforce their development standards. They make use of a composite view design. This is where you create many small controls that show specific data and have specific behavior. These controls are then assembled together onto a single page.

## Next Steps

I think I would like to try writing an application in both GWT and Silverlight. I like the idea of being able to publish a single application have have it live on the network edge through a CDN. For now though, my apps will be widgets and JavaScript based.
