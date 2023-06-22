---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Soap and Fiddler"
date: "2007-08-19"
tags: 
  - "net"
---

A coworker told me about a strange error he was getting when trying to call a webservice with an ASP 2.0 application. My first thought was, use [Fiddler](http://www.fiddlertool.com/fiddler/) and inspect the soap call directly.

Setting up an application to point to Fiddler is a little different between .NET 1.1 and .NET 2.0. In 1.1 apps you'll need to configure the app.config or web.config to use Fiddler as a proxy. Add the following to the config file.

  
```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <system.net>
   <defaultProxy>
      <proxy proxyaddress="http://localhost:8888" bypassonlocal="false"/>
   </defaultProxy>
  </system.net>
</configuration>
```

Apparently for .NET 2.0 this isn't needed anymore. My guess is somehow application in 2.0 use the WinINET API. If an application implements this API then when Fiddler has the "Act as System Proxy" checked, all http traffic will use fiddler as the proxy. Pretty neat!

So now fiddler is capturing all of the http traffic for our app and that includes the SOAP calls to the webservice. The error, "Underlying connection was closed", is being thrown after one call to the web service is made and a second call is attempted. Doing some digging found Fiddler has a rule built in just for this error. Go to Fiddler and un-comment the connection closure rule in Rules -> Customize Rules ->| OnBeforeResponse.

```js
static function OnBeforeResponse(oSession:Fiddler.Session)
{
  if (m_Hide200s && oSession.responseCode == 200){
    oSession["ui-hide"] = "true";
  }
  // Uncomment to reduce incidence of "unexpected socket closure" exceptions in .NET code. 
  // Note that you really should also fix your .NET code to gracefully handle connection closes.
  //
  // if ((oSession.responseCode != 401) && (oSession.responseCode != 407){
  //   oSession.oResponse["Connection"] = "close";
  // }
}
```

I don't really know what is meant by "you should fix your code to gracefully handle connection closes" in our case of calling a web service. Right now the guess is the wsdl file being used isn't correct.
