---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Updating Wordpress"
date: "2010-11-03"
tags:
  - "wordpress"
---

Well, since I've been playing around with wordpress, I thought I would update it to the latest version. Mostly because I wanted to get rid of the annoying upgrade banner. So First things first

1. Backup Files
  ```bash
  mkdir wpbackup
  cp -r /var/www/wordpress /var/www/wpbackup
  ```
2. Backup Database
  ```bash
  mysqldump --add-drop-table -h localhost -u root -p wordpress | bzip2 -c > blog.bak.sql.bz2
  ```
3. Disable Plugins. Check!
4. Follow instructions on [http://codex.wordpress.org/Upgrading_WordPress](http://codex.wordpress.org/Upgrading_WordPress)
