---
title: "Enable Pretty Links in Word Press"
date: "2011-03-28"
tags: 
  - "wordpress"
---

I wanted to enabled "Pretty" permalinks for my blog and found it wasn't just a click of the button. Well, it was just [a click of a button](http://codex.wordpress.org/Using_Permalinks#Using_.22Pretty.22_permalinks) but when I clicked on the button, Wordpress told me: _If your .htaccess file were writable, we could do this automatically, but it isn’t so these are the mod\_rewrite rules you should have in your .htaccess file._ `<IfModule mod_rewrite.c> RewriteEngine On RewriteBase /wordpress/ RewriteRule ^index.php$ - [L] RewriteCond %{REQUEST_FILENAME} !-f RewriteCond %{REQUEST_FILENAME} !-d RewriteRule . /wordpress/index.php [L] </IfModule>`

Honestly I don't know too much about mod\_rewite but apparently it used the .htaccess file found in the Wordpress directory. The only problem is when I check out the directory for my blog, /var/www/wordpress/, I don't see an .htaccess file. Pocking around the web taught me I should first [configure .htaccess](http://www.joeldare.com/wiki/linux:using_.htaccess_on_ubuntu) for pages under /var/www/. Next I just created the file and added the content and restarted apache. I doubled checked [Wordpress documentation](http://codex.wordpress.org/Using_Permalinks#Using_.22Pretty.22_permalinks) and verified I did things correctly. Not too bad.
