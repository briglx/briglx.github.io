---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Configure SSH"
date: "2011-09-30"
tags: 
  - "linux"
  - "ssh"
---

I recently set up a few new servers and needed to allow other developers access. Here is how I did it:

- Add new user
    
    `sudo adduser bbdiddle`
    
- Add user to sudoers
    
    `sudo vi /etc/sudoers
    
    # Add this line to the sodoers file bbdiddle ALL=(ALL) NOPASSWD:ALL`
    
- Enable ssh
    
    `sudo vi /etc/ssh/sshd_config
    
    # Change to yes to allow ssh PasswordAuthentication yes`
    
- Restart ssh
    
    `sudo /etc/init.d/ssh restart
    
    # Redhat sudo service sshd restart`
