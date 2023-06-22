---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Singleton Pattern for .NET"
date: "2011-06-13"
---

I really like design patterns and also enjoy learning the why behind some implementations. Although the singleton pattern is one of the most widely used patterns around, it is also one that can be really hard to get write. After searching around to understand how to implement the Singleton in C# and the .net runtime, I found three great artcles that gave me what I needed:

Jon Skeet's [singleton article](http://csharpindepth.com/Articles/General/Singleton.aspx) gives a handful of implementations of the singleton and explains the difference between them. He talks about how .Net, Java, and C++ all manage memory, threading and instantiation models differently which affect the correctness of the pattern.

Microsoft has a [great article](http://msdn.microsoft.com/en-us/library/ff650316.aspx) that goes a little deeper in some areas but doesn't talk too much about Lazy loading.

Finally the folks at dofactory give a [direct implementation](http://www.dofactory.com/Patterns/PatternSingleton.aspx#_self1) from the "Design Patterns" book which each other article references. The dofactory article gives a real world example of a singleton in use and also tries to show how .net can be used to simplify the pattern.

Out of all three articles, I think [Jon Skeet's](http://csharpindepth.com/Articles/General/Singleton.aspx) does the best job of explaining the why behind the pattern for the language.
