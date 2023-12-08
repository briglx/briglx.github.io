---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "ASP.NET Authorization - Out of the Loop"
date: "2007-11-14"
tags:
  - "asp-net"
---

Asp.net configuration makes is really easy to apply authorization to different pages.

## The Problem

I have often created projects that have different areas restricted based on user roles. For instance, there might be a section only for administrator and another for power users then another for the general public. I needed a way to ensure users were restricted from accessing pages based on their roles. My solution worked and I thought it was pretty good, but I just realized there is a another way to do it.

## My Way

I wanted to ensure that each page would perform a check to see if the current user was authorized to use the page. I created a base page which had an **ApplyAuthorizationRules** method which was kicked off during **OnInit**. By default I didn't do anything in the method so everyone was authorized to access the page by default.

```csharp
public class BasePage : Page
{
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        ApplyAuthorizationRules();
    }

    protected virtual void ApplyAuthorizationRules()
    {
      // By default do nothing. Essentially allow access to everyone.
    }
}
```

Each page that needed authorization would derive from the base class and override the **ApplyAuthorizationRules** () method. Notice in the Class Diagram how the AdminPage is overriding the method while the other two pages, SummaryPage and DetailPage, use the default implementation.

![UrlAuthzUml]({{ site.url }}{{ site.baseurl }}/assets/images/UrlAuthzUml.Png)

The code in the AdminPage looks something like this:

```csharp
public class AdminPage : BasePage
{
    protected override void ApplyAuthorizationRules()
    {
      if (this.User.IsInRole(Roles.Admin))
      {
          // Allow
      }
      else
      {
          Response.Redirect("~/Unauthorized.aspx");
      }
    }
}
```

This method worked great and could handle all of our use cases when we needed to apply authorization. It worked so well I didn't dig any deeper into other solutions. To be honest I knew that ASP offered some tools for managing users and roles but I thought it was mostly tied to authentication. What to my surprise today when I put two and two together and realized there is an ASP way to handle authorization.

## The ASP.NET Way

Ever since my first ASP.NET application I have generally used the web.config file to configure authentication. I have generally used something like this:

```xml
<system.web>
  <compilation debug="true" />
  <authentication mode="Forms">
    <forms name="myAppAtuh" loginUrl="/login.aspx" />
  </authentication>
  <authorization>
    <deny users="?"/>
  </authorization>
</system.web>
```

I never really took a close look at the [authorization tag](http://msdn2.microsoft.com/en-us/library/wce3kxhd.aspx). I can accomplish everything I was doing programmatically through configuration. With the following example, I'm able to create an Admin section on my app where only those users with an Admin role have access. There is a [special case](http://msdn2.microsoft.com/en-us/library/b6x6shw7(VS.71).aspx) that allows users with a Role of 'Power' to see the `/Admin/View.aspx` page. You do have to be careful in creating the rules because they do execute in a top down manner.

```xml
<system.web>
  <compilation debug="true" />
  <authentication mode="Forms">
    <forms name="myAppAtuh" loginUrl="/login.aspx" />
  </authentication>
  <authorization>
    <deny users="?"/>
  </authorization>
</system.web>

<location allowOverride="false" path="/Admin/View.aspx">
  <system.web>
    <authorization lockItem="">
      <allow roles="Power"/>
    </authorization>
  </system.web>
</location>
<location allowOverride="false" path="/Admin/">
  <system.web>
    <authorization lockItem="">
      <allow roles="Admin"/>
      <deny users="*"
    </authorization>
  </system.web>
</location>
```

## Conclusion

My way isn't too bad. I do feel bad for not noticing that other people have talked about this before. Doing a [simple search](http://www.google.com/search?q=+Url+Authorization&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a) returns a lot of results showing everyone else already knew about the configuration method. Oh well, now I know, and you do too.
