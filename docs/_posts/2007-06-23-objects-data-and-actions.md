---
title: "Objects, Data, and Actions"
date: "2007-06-23"
tags: 
  - "coding"
  - "objects"
---

I was recently asked what objects are in programming and how a database is related to them. Thinking long and hard about it, I came up with the following example:

Objects are containers that stores data and code. In fact objects are just like real life objects. Imagine an Animal object. Pick any animal you like, it will have Data and Actions. The data would be things like Height, Length, Age, Name, Color. And Actions could be Speak, Walk, Jump, Eat.

So a Lion could be:

MyLion.Height = 4

MyLion.Length = 7

MyLion.Age = 4

MyLion.Name = Mufasa

MyLion.Color = Yellow and Brown

Notice how these values can easily be stored in a database. But what about the actions? When MyLion performs an action, something gets done.

MyLion.Speak -> from my speakers I hear a  "ROAR!!!!"

MyLion.Eat ->  Now MyLion.Length = 7.5

See how actions can't really be stored as a value because they do something. A relational database can store all of my Properties but can't store what will happen when my object performs an action. But an OODB database can store objects. So I could save MyLion right to the database. I could also save MyChicken and MyHippo. Each object would do something a little different when I ask it to Speak or Eat.

Hope this helps.
