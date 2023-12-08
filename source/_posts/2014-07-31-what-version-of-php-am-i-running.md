---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "What Version of PHP am I Running"
date: "2014-07-31"
tags:
  - "software"
  - "apache"
  - "php"
cover: /assets/images/phpapache.jpg
---

I was trying to install a debugger for PHP and had trouble mostly because it turned out I had two different versions of PHP running on my machine. One I installed using homebrew and the other ... well I don't know how it got there.

Nevertheless, this is how I found out which one I was using.

- **From the command line**

    ```bash
    php -v
    PHP 5.5.12 (cli) (built: May 27 2014 19:40:54)
    ```

- **From the browser** Navigate to a php page with php.info()

    ```bash
    php.info()
    5.4
    ```

- **Point apache to the right location** Edit apache config

    ```bash
    vi /etc/apache2/httpd.conf

    # Edit the line
    LoadModule php5_module /usr/local/opt/php55/libexec/apache2/libphp5.so
    ```


## Which Php Config

As an added bonus, I'll show how to find which `php.ini` file is loaded.
From the command line you can check which `php.ini` the `php_cli` is running with:

```bash
php -i | grep "Loaded Configuration File"
```

## Resources

- [http://serverfault.com/questions/428800/how-do-i-tell-apache-which-php-to-use](http://serverfault.com/questions/428800/how-do-i-tell-apache-which-php-to-use)
- [http://stackoverflow.com/questions/13613313/osx-apache-using-wrong-version-of-php](http://stackoverflow.com/questions/13613313/osx-apache-using-wrong-version-of-php)
- [http://smartwebdeveloper.com/mac/httpd-conf-location-mac](http://smartwebdeveloper.com/mac/httpd-conf-location-mac)
