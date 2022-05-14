---
title: "Freemarker not Displaying"
date: "2011-07-20"
tags: 
  - "freemarker"
---

I'm putting together a simple web page and trying to learn more about Freemarker. I've setup my views for the project like this:

- views
    - global
        - base.ftl
        - footer.ftl
        - header.ftl
        - navigation.ftl
    - user
        - new-user.ftl
        - view-user.ftl
    - index.ftl

The base.ftl file is the skeleton page layout which includes the header, content, navigation, and footer.

`<#macro myLayout> <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"> <html> <body> <#include "header.ftl"/> <#nested/> <#include "navigation.ftl"/> <#include "footer.ftl"/></div> </body> </html> </#macro>`

The problem was the navigation wasn't showing on my new-user.ftl page. It showed with no problems on the index page. The logfile said:

`freemarker.core.InvalidReferenceException: Expression username is undefined on line 18, column 87 in user/new-user.ftl.`

Sure enough, I was calling for a model attribute that I hadn't defined. The navigation wasn't showing because the base.ftl file calls the details before the navigation. The fix is to use the [attempt](http://freemarker.org/docs/ref_directive_attempt.html) keyword and provide default content. Here is the fix:

`<#macro myLayout> <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"> <html> <body> <#include "header.ftl"/> <#attempt> <#nested/> <#recover> Failed to load content </#attempt> <#include "navigation.ftl"/> <#include "footer.ftl"/></div> </body> </html> </#macro>`
