---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Symfony denied Access"
date: "2014-07-14"
tags:
  - "software"
  - "linux"
  - "nginx"
  - "php"
  - "symfony"
cover: assets/images/sf-logo.png
---

Moving my Symfony app to a QA server showed me how rude the server is.

I could see the home page right after I copied the project to the new machine with not problem (except for modifying `app.config.php` and various file permission ownership issues). Nevertheless, the real problem came when I tried navigating to any other route besides the index. Each time I would get a 403 Access denied error.

Apparently the server "understood the request, but is refusing to fulfill it". Thanks. I especially like how the [guideline for 403 errors](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html) says

> ...if the server wishes to make public why the request has not been fulfilled, it SHOULD describe the reason for the refusal in the entity.

That sounds good because I really don't know why I'm not seeing my page and I would really like to know why the server is _refusing_ to fulfill it. In my case I am given the clear description of "**Access denied**." Thanks again. After much searching and testing I found [the solution](http://askubuntu.com/questions/164627/nginx-php-fpm-access-denied-error). The fix was to modify my `php.ini` and restart the service

```bash
vi /etc/php5/fpm/php.ini

# Edit line
cgi.fix_pathinfo=1
```

I'm sure there is a better way to restart this service.

```bash
ps -eaf | grep php 
root 1269 1 0 16:39 ? 00:00:00 php-fpm: master process (/etc/php5/fpm/php-fpm.conf)  

sudo kill 1269 
ps -eaf | grep php 
root 1436 1 6 17:49 ? 00:00:00 php-fpm: master process (/etc/php5/fpm/php-fpm.conf)
```

And I'm sure there are more ways for a server to be helpful.
