---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Beware Dynamic User Controls in a Web Farm"
date: "2007-11-02"
tags: 
  - "net"
  - "asp-net"
---

Many large sites utilize a web farm with a load balancer. The load balancer will cycle through each server in the farm for each request. Today I assumed our load balancer had [persistence](http://en.wikipedia.org/wiki/Load_balancing_%28computing%29). 

I think the text from Wikipedia sums my experience today: "But reliance on persistence can cause problems if the persistence fails." Come to find out, the rules on the load balancer were not setup uniformly and I found a special case where persistence failed.

My application was creating custom user controls dynamically on a form. The Page class offers two two ways to load a control dynamically:

`public Control LoadControl(string virtualPath); public Control LoadControl(Type t, object[] parameters);`

My code was using the second method. It stuffed the control's GetType().AssemblyQualifiedName property into the view state. Then on the PostBack, this information was retrieved from the ViewState to create a Type object and Load the control again.

One thing I didn't realize was the AssemblyQualifiedName used the [Shadow copy](http://msdn2.microsoft.com/en-us/library/ms404279.aspx) assembly name, which is something like App_Web_XXXXXXXX where X can be any letter or number.

This would have been fine if persistence didn't fail on the load balancer. What happened however was the view state saved the type assembly name as App_Web_ob44m7cy.dll, which it was on Server1, but because the load balancer directed the request to Server2, no such file existed. And that was the error I was getting.

`Type : System.IO.FileNotFoundException, mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089   Message : Could not load file or assembly 'App_Web_ob44m7cy, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null' or one of its dependencies. The system cannot find the file specified.   Source : mscorlib`

The fix was two fold, tell the network team they didn't have uniform rules in place, shame shame shame. Second, don't rely on persistence being setup on the load balancer. I changed my code to load the control via the path. A pretty simple solution for a strange situation.
