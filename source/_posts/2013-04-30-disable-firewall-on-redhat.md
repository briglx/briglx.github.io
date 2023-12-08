---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Disable firewall on Redhat"
date: "2013-04-30"
tags:
  - "software"
  - "ec2"
  - "linux"
  - "redhat"
cover: /assets/images/firewall-e1367345805612.png
---
I just tried to deploy and test an application on EC2 running red hat but couldn't telnet it.

I configured the security group to allow port 8080, I could see the port was running with netstat

```bash
sudo netstat -lntp

tcp 0 0 :::80 :::* LISTEN 29031/httpd
tcp 0 0 :::8080 :::* LISTEN 28923/java
```

However, try as I might I could not telnet. I didn't have any issues with ssh. Finally I found the problem. Redhat instances have a firewall enabled by default. A quick way around the firewall is to disable it with a simple command:

```bash
system-config-firewall-tui
```

I'm sure there is a better way to solve this issue that doesn't expose the server to attacks. I'd love to know.
