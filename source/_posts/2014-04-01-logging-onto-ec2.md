---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Logging onto EC2"
date: "2014-04-01"
tags:
  - "software"
  - "aws"
  - "ec2"
  - "linux"
  - "ubuntu"
---

I tend to forget how to log onto EC2. This morning I spun up a few servers with an Ubuntu image on EC2. As soon as I tried to log on, I received a

`Permission denied (publickey).`

After doing a [quick search](http://stackoverflow.com/questions/4826706/amazon-ec2-permission-denied-publickey) I remembered I needed to add the username on the instance

`ssh -i /path/to/keypair.pem ubuntu@ec2-instancename.compute-1.amazonaws.com`

So simple.
