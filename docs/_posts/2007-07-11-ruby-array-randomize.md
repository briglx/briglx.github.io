---
title: "Ruby Array Randomize"
date: "2007-07-11"
tags: 
  - "ruby"
---

I needed the ability to randomize the order of an array. This is useful when you have a set collection of questions in a survey that you want to shuffle before you present them to the user. After looking around a bit, I didn't find anything that worked. Here is what I pieced together with my limited knowledge of Ruby.

`# Created by Brig R. Lamoreaux # Date: 11 July 2007 # Time: 10:38 am # Randomize the contents of an Array class Array def randomize a=self.dup result = \[\] self.length.times do result << a.slice!(rand(a.length)) end return result end def randomize! a=self.dup result = \[\] self.length.times do result << a.slice!(rand(a.length)) end self.replace result end end`

Here are some test that make sure it really works. `puts “Randomize Tests” x = \[1, 2, 3, 4, 5\] print “x: “ x.each do |i| print “#{i}” end y = x.randomize print “\\ny: “ y.each do |i| print “#{i}” end x.randomize! # x is now \[3, 5, 4, 1, 2\] print “\\nx: “ x.each do |i| print “#{i}” end x.randomize! # x is now \[3, 5, 4, 1, 2\] print “\\nx: “ x.each do |i| print “#{i}” end` Special thanks to [syntaxhighlighter](http://code.google.com/p/syntaxhighlighter/) on providing styles for ruby syntax highlighting.
