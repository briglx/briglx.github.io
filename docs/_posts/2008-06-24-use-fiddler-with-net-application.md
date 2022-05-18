---
title: "Use Fiddler with .Net Application"
date: "2008-06-24"
tags: 
  - "net"
  - "proxy"
---

I often need to watch communication between a web service and my application. The best way I've found is to configure my app to use Fiddler as a proxy between my application and the web service. Once configured, I can watch the traffic. The simple step that I keep forgetting is the entry in the Web.Config file.

### Get Fiddler Settings

Open Fiddler and click on Tools -> Fiddler Options. The Fiddler Options window will pop up and take note of Listen Port number under Proxy Settings. In this case the value is 8888.

[![](/assets/images/CropperCapture%5B71%5D.jpg)](http://picasaweb.google.com/blamoreaux/BloggerPictures/photo?authkey=xF0ivtt8GuU#5215503748989006434)

### Update Web.Config

Open your Web.Config file and add the entry. Make sure the port on the address matches the one defined in Fiddler.

`<system.net> <defaultProxy> <proxy  proxyaddress="http://127.0.0.1:8888" /> </defaultProxy> </system.net>`

Other web refrenced talk about setting other attributes on the proxy element, but don't These seem to make it fail. Just the simple solution from [Rick Strahl](http://www.west-wind.com/WebLog/posts/277966.aspx) will make it work.
