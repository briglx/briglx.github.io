---
title: "First Impressions of Google App Engine"
date: "2009-02-01"
tags: 
  - "app-engine"
  - "python"
---

So I thought I would try to see what [Google App Engine](http://code.google.com/appengine/) is all about. My main goal is to learn python a little better and also try to get a better understanding of how to build applications that can

- Handle a lot of load
- Be distributed
- Have Standard Data access

## Installing

I'm a .Net developer on a Windows machine and really don't have a lot of Linux/Python experience. I know I'm not alone so I am going to track my experience using GAE to build my car maintenance application know as Motozio.

I'm following the Google Getting started guide which is the following

- Download and install [Python 2.5](http://www.python.org/download/releases/2.5.4/)
- Download and install [GAE](http://code.google.com/appengine/downloads.html)

## Coding

Installation is a breeze. The two python files for the [hello world](http://code.google.com/appengine/docs/gettingstarted/helloworld.html) program are pretty straight forward too.

Trouble hit when I tried to test my application. I really didn't know how to call the script but I figured it out.

My application folder structure looks like this `c:\\dev\\helloworld\\ c:\\dev\\helloworld\\helloworld.py c:\\dev\\helloworld\\app.yaml`

## Running

I had to open a command prompt and type: `C:\\dev>dev\_appserver.py helloworld` Notice that the path to google\_appengine, where the dev\_appserver.py script resides, is already in the system path. The script dev\_appserver wants the path to the application. Which is the helloworld directory.

Once I got that figure out. Bam! My helloworld was up and running at [http://localhost:8080](http://localhost:8080)

I'm always impressed with out of the box examples of hello world. I really liked the ruby on rails example. And I am just as impressed with App Engine so far. Of course it doesn't take much to impress me.
