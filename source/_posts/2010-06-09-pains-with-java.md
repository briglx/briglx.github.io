---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Pains with Java"
date: "2010-06-09"
tags: 
  - "intellij"
  - "java"
---

So I've spent the last hour trying to solve an elusive error in my project:

`"Fatal Error: Unable to find package java.lang in classpath or bootclasspath"`

I use IntelliJ 9. At one time I could build the project with no problem. Then one day it just stopped. I finally found [the solution](http://ebay.custhelp.com/cgi-bin/ebay.cfg/php/enduser/std_adp.php?p_faqid=872&p_created=1168556121&p_topview=1 "Code Fix").

Here is what I did

- Open Project Structure from file menu
- Under Platform Settings select SDKs
- For the Classpath tab, I clicked add and included
    
    %JAVA_HOME/jre/lib/rt.jar
    

Hope this helps.
