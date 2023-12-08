---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Improve Performance of mod_rewrite"
date: "2011-03-30"
---

After [getting Pretty Links enabled]({% post_url 2011-03-28-enable-pretty-links-in-word-press %}/), I wanted to find out more about [.htaccess](http://httpd.apache.org/docs/current/howto/htaccess.html). I was surprised to see the following:

> In general, you should never use .htaccess files unless you don't have access to the main server configuration file.

So I've edited `/etc/apache2/httpd.conf` to be

```xml
<Directory /var/www/wordpress>
    <IfModule mod_rewrite.c>
        RewriteEngine On
        RewriteBase /wordpress/
        RewriteRule ^index.php$ - [L]
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteCond %{REQUEST_FILENAME} !-d
        RewriteRule . /wordpress/index.php [L]
    </IfModule>
</Directory>
```

I also removed the `.htaccess` from `/var/www/wordpress`. I tested the site after an apache restart and had no problems. Here is to better performance.
