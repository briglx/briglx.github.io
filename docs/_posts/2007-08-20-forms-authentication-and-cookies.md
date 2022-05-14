---
title: "Forms Authentication and Cookies"
date: "2007-08-20"
tags: 
  - "net"
  - "asp-net"
---

I encountered a strange problem this morning when I tried to turn on Authentication to the ASP.NET 2.0 Website. I opened my handy dandy Wrox Professional ASP.NET 2.0 book to chapter 18, Security, and started the simple process of implementing forms authentication. Simple, hah! What happen was my cookies were not being saved. Walking step by step, I first made sure I denied access to any anonymous users.

<authorization\>

  <denyusers\="?" />

</authorization\>

Piece of Cake! I then added my code to redirect to a logon page. (Note: It shouldn't make a difference using "Mock.aspx" instead of "Logon.aspx")

<authenticationmode\="Forms"\>

  <formsloginUrl\="Mock.aspx"path\="\\" />

</authentication\>

Inside of Mock.aspx is the code to always authenticate everyone as the same user.

   10 protected void Submit\_Click(object sender, EventArgs e)

   11    {

   12         // Always use the same user

   13         string userName = "Charle";

   14         FormsAuthentication.RedirectFromLoginPage(userName, true);

   15    }

What happened next was unexpected. I tried to hit my default page and was redirected to the logon page. Good. I clicked the Submit button and poof! I'm back at the logon form. That's weird I was expecting to go to my default page.

Using fiddler, I found that my cookie wasn't being persisted between called. The logon page was setting one but it was lost on the other side.

After trying several things, I changed my web.config file to the following:

<authenticationmode\="Forms"\>

  <formsname\=".ASPXAUTH"

         loginUrl\="Mock.aspx"

         protection\="All"

         timeout\="30"

         path\="/"

         requireSSL\="false"

         slidingExpiration\="true"

         defaultUrl\="default.aspx"

         cookieless\="UseCookies" />

</authentication\>

Making this change made my cookies stick. I'll have to dig in deeper to see why the first way didn't work.
