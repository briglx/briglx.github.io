---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Backup Wordpress"
date: "2012-02-10"
tags:
  - "software"
  - "mysql"
  - "wordpress"
---

I had a little scare the other day. For some reason my db for the blog stopped. I thought it would be a good idea to make a backup just in case.

I have MySQL Workbench on my machine and though it would be trivial. When I tried to connect to my db, I received an error saying I didn't have access. [Looking around](http://dev.mysql.com/doc/refman/5.5/en/access-denied.html) showed I needed to add a new user to the DB with the host I was connecting from. Here is what worked for me.

1. **Add Remote User**.
    - From the remote host, connect to local db `$ ./mysql -u root mysql -p`
    - Insert a new value `mysql> insert into user VALUES('HOSTNAME','root',PASSWORD('my_password'), 'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y', 'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y', '','','','',0,0,0,0);`
    - Restart the service `$ cd /opt/bitnami $ sudo ./ctlscript.sh restart mysql`
    Test connection `localhost$ mysql -h REMOTE_HOST -u root -p`
2. **Start the backup**
    
    This part was easy. I just had to follow the [backup instructions](http://forum.hostek.com/showthread.php?297-How-to-use-MySQL-Workbench-to-backup-your-MySQL-database).
    

I now have a complete backup of my blog data in a nice little file BlogBackup20120210.sql.

My scenario is using a wordpress stack provided by bitnami. That is why the command to restart is a little different.
