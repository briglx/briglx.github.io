---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Generate CRUD"
date: "2007-08-17"
tags: 
  - "net"
  - "code-generation"
---

Seeing how I'm working on a project that deals with a SQL database and several tables, I decided I didn't want to mess around with writing all the code for my data CRUD functionality (Create Read Update Delete). Which, indecently, I feel no developer should ever waste their time with CRUD.  

Now I know that I'm not alone in these feelings and many bright and talented developers have created some very slick tools to do what I have done, CodeSmith being the best I've ever used. But I'm curious and I enjoy solving problems with code. So my little app, when provided an Entity name like Student, will do the following:  

- Creates a SQL Insert statement
- Create a SQL Get statement
- Create a SQL Update statement
- Create a SQL Delete statement
- Create a Test Insert Script
- Create a Test Get Script
- Create a Test Update Script
- Create a Test Delete Script
- Create C# Code for DataInsert
- Create C# Code for DataFetch
- Display Syntax Highlighting
  
Starting up the application displays a stunning UI where the user can provide an entity name and click Render.  
![Entity Form]({{ site.url }}{{ site.baseurl }}/assets/images/CropperCapture%5B12%5D.png)

The application will inspect the SQL table and create the SQL scripts needed to create the CRUD stored procedures. One of the tricky things I had to do was check the field type to see if a size is required, like varchar(50).  
![Crud Form]({{ site.url }}{{ site.baseurl }}/assets/images/CropperCapture%5B13%5D.png)

Since I am really lazy, I decided to have the application generate test data and a script so I could run through and make sure the stored procedures worked all right. Based on the field type, the generated test data is created to match.  
![Test Script]({{ site.url }}{{ site.baseurl }}/assets/images/CropperCapture%5B14%5D.png)

My favorite part of all of this is getting the code written for me. I really like Rocky Lhotka's CSLA business objects. Especially the way he has all of the data access routines on the objects themselves.  
![CSLA Input]({{ site.url }}{{ site.baseurl }}/assets/images/CropperCapture%5B15%5D.png)

Even thought this application does a lot for me already, you can probably see some areas for improvement. Most notably is the "Form1" in the title bar. I would also like to revamp the syntax highlighting engine. Right now it just looks for specific words to highlight. I think adding a parser would really add some value.  
One other major improvement would be to add a template system similar to CodeSmith. Right now it doesn't use templates to generate the code. This makes updates difficult. But it play-around code so I'm not too upset by that. One final big part would be to select a generic database. Once again I have it hard coded to point to my project's database. Once I get all of these updates in, I think I will have a pretty neat little tool.
