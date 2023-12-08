---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Python and Screen Scraping"
date: "2011-01-14"
tags:
  - "python"
---

I wanted to do a quick test on a website using Python. I knew about [beautifulsoup](http://www.crummy.com/software/BeautifulSoup) but I wanted the power of JQuery. So I found [pyquery](http://pypi.python.org/pypi/pyquery).

I found some [instructions](http://blog.jeffbalogh.org/post/89619207/pyquery-a-jquery-like-library-for-python) to get started and noticed some people complaining about how difficult it is to get installed. Hmm I wonder why?

It only needs a dependency to `lxml` which has a [dependency](http://codespeak.net/lxml/installation.html) to [easy_install](http://peak.telecommunity.com/DevCenter/EasyInstall#installing-easy-install) which needs [setuptools](http://pypi.python.org/pypi/setuptools#downloads). Oh, that's why people complain. Oh well let's try.

- I downloaded Download the [setuptools-0.6c11-py2.6.egg](http://pypi.python.org/pypi/setuptools#downloads) because my version of Python is 2.6
- Run setuptools as if it were a shell script. Apparently this installs easy_install
- Now I can install lxml with easy_install `$ sudo easy_install lxml`

This failed for me. So I'm going to make sure I have `libxml2` and libxslt. First I install `libxml2`-dev `$ sudo apt-get install libxml2-dev`

First I need to [build libxml2](http://www.techsww.com/tutorials/libraries/libxml/installation/installing_libxml_on_ubuntu_linux.php)
```bash
wget ftp://xmlsoft.org/libxml2/libxml2-sources-2.7.6.tar.gz
tar -xvsf libxml2-sources-2.7.6.tar.gz
cd libxml2-2.7.6/
./configure --prefix=/usr/local/libxml2
make
sudo make install
```

Next [build libxslt](http://www.techsww.com/tutorials/libraries/libxslt/installation/installing_libxslt_on_ubuntu_linux.php)

```bash
wget ftp://xmlsoft.org/libxslt/libxslt-1.1.26.tar.gz
tar -xvzf libxslt-1.1.26.tar.gz
cd libxslt-1.1.26
./configure --prefix=/usr/local/libxslt --with-libxml-prefix=/usr/local/libxml2/
make
sudo make install
```

Still errors... I'm stopping
