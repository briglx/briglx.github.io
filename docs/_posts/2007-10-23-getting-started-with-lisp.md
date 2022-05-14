---
title: "Getting Started with Lisp"
date: "2007-10-23"
tags: 
  - "lisp"
---

Lisp is an old and powerful language that influences modern languages like C#. Lisp is also difficult to jump into. I'll outline where to go to download a compiler and the steps needed to start using Lisp today.

Lisp is known as the [programmable programming language](http://www.paulgraham.com/quotes.html). I became interested in Lisp when I learned how many of the sexy features in C#, like anonymous delegates, were implemented in Lisp 20 years ago. I wanted to find out more about Lisp but I didn't know where to start. The first step I found is to setup a Lisp environment.

#### Download a Compiler

Lisp has many different dialects. Common Lisp is one dialect. There are several different implementations of Common Lisp similar to the different implementations of C++. The first step is to choose and download a specific Lisp compiler. I decided on Steel Bank Common Lisp (SBCL) for no rhyme or reason. One hurdle to overcome is understanding the unorthodox grid of available downloads.

[![](images/SBCLOptions.Png)](http://bp3.blogger.com/_io6q_2NOAVQ/Rx4szFx75NI/AAAAAAAAAIE/SacwRHZEXbg/s1600-h/SBCLOptions.Png)

The secret to the grid is to look for your OS in left column and your processor in the top column. I was directed to the yellow square labeled 1.0.9. This links to a installation file called sbcl-1.0.9-x86-windows-binary.msi. Executing the installer will install some files to the in C:\\Program Files\\Steel Bank Common Lisp\\1.0.9\\ folder. The most important file is the sbcl.exe. I actually created a shortcut to this file and placed it in my C:\\Documents and Settings\\All Users\\Start Menu\\Programs\\Lisp\\ folder

[![](images/LispShortcut.Png)](http://bp0.blogger.com/_io6q_2NOAVQ/Rx4szVx75OI/AAAAAAAAAIM/6uuP8MHAuSk/s1600-h/LispShortcut.Png)

#### Stand your Ground

Running the sbcl.exe executable and firing up Lisp for the first time is a little daunting. You'll get a sappy message about a Kitten of Death and then just a \* prompt, almost mocking you saying 'Here's your Lisp environment...now what are you going to do?"

Just shoot back with this and press enter:

`(+ 2 3)`

Lisp will reply with:

`5`

Lisp is conquered. I now feel confident in taking the next step and actually studying the language to see what it can do. For this I highly recommend [Practical Common Lisp](http://www.gigamonkeys.com/book/).

#### Future Plans

I like the idea of being able to pass around functions and redefine them on the fly. I feel similar to [Lawrence](http://www.google.com/search?hl=en&q=Lawrence+of+Arabia+It%27s+clean&btnG=Search) and appreciate how clean the language is. It is void of a lot of keywords. I don't have any plans of writing an entire application in Lisp, but if I run into needing a small utility app, I will definitely consider using Lisp.
