---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Anonymous Delegates"
date: "2007-08-21"
tags: 
  - "net"
  - "closure"
---

I never thought I would use anonymous delegates mostly because I didn't fully understand what benefit they could give me. 

If I can't get something out of a new tool or methodology, why use it. With anonymous delegates I can get a lot of great things. Specifically simple solutions to my problems

## Problem

What is the best way to add filtering capability on a specilized collection? After looking at related problem sets, I found the `public T Find(System.Predicate<T> match)` method which is implemented on `System.Collections.Generic.List`. A Predicateis a special delegate that takes in an object, and returns true. Suppose I have a collection of names and I would like to check if a name is long. I could do the following

```cs
class Program
   {
        static void Main(string[] args)
        {
            List<string> names = new List<string>();
            names.Add("Mary");
            names.Add("George");
            names.Add("Hank");
            names.Add("Billy");
            names.Add("Susan");
            names.Add("Ed");
            Console.WriteLine(IsLongName(names[4]));  
        }
        static bool IsLongName(string name)
        {
            return name.Length > 4;
        }
   }
```
  
I define a method that checks if the length of the name is greater than 4. Well my method `IsLongName` is in fact a `System.Predicate`. Since the `Find()` method takes a Predicate as the match pattern. I can pass this method to the `Find()` method and get a collection of just long names. Let's use `Find()` to get a list of names that are long names. First I'll need to wrap the `IsLongNamefunction` inside of a delegate. Then I can pass that delegate into the `Find()` method.  
  
```cs
class Program
   {
        static void Main(string[] args)
        {
            List<string> names = new List<string>();
            names.Add("Mary");
            names.Add("George");
            names.Add("Hank");
            names.Add("Billy");
            names.Add("Susan");
            names.Add("Ed");
            // WrapIsLongName up insided of Predicate delegate.
            Predicate<string> longNameMethod = new Predicate<string>(IsLongName);
            List<string> longNames = names.FindAll(longNameMethod);
            Console.WriteLine("There are {0} long names", longNames.Count);
            Console.ReadLine();
        }
        static bool IsLongName(string name)
        {
            return name.Length > 4;
        }
   }
```

The output is: `There are 3 long names.` What if I need to get a list of just names that start with the letters M Gand B? No problem, create a new method that matches the signature of a Predicate and you are in business.

```cs
class Program
   {
        static void Main(string[] args)
        {
            List<string> names = new List<string>();
            names.Add("Mary");
            names.Add("George");
            names.Add("Hank");
            names.Add("Billy");
            names.Add("Susan");
            names.Add("Ed");
            // WrapIsLongName up insided of Predicate delegate.
            Predicate<string> longNameMethod = new Predicate<string>(IsLongName);
            Predicate<string> mgbName = new Predicate<string>(IsMGBName);
            List<string> longNames = names.FindAll(longNameMethod);
            List<string> mgbNames = names.FindAll(mgbName);
            Console.WriteLine("There are {0} long names.", longNames.Count);
            Console.WriteLine("There are {0} MGB names.", mgbNames.Count);
            Console.ReadLine();
        }
        static bool IsLongName(string name)
        {
            returnname.Length > 4;
        }
        static bool IsMGBName(string name)
        {
            if(name.StartsWith("M") || name.StartsWith("G") || name.StartsWith("B"))
            {
               return true;
            }
            returnfalse;
        }
   }
```
  
The console shows: `There are 3 long names.There are 3 MGB names.`

## Clean it up

Now I see how powerful and convenient it is to be able to pass in a method that contains the logic to find an item in a list. But let's see how anonymous delegates can help out. All that an anonymous delegate gives us is the ability to create our methods on the fly; no need to have random methods sitting around that won't be used.  
  
```cs
class Program
   {
        static void Main(string[] args)
        {
            List<string> names = new List<string>();
            names.Add("Mary");
            names.Add("George");
            names.Add("Hank");
            names.Add("Billy");
            names.Add("Susan");
            names.Add("Ed");
            // WrapIsLongName up insided of Predicate delegate.
            Predicate<string> longNameMethod = newPredicate<string>(IsLongName);
            Predicate<string> mgbName = newPredicate<string>(IsMGBName);
            List<string> longNames = names.FindAll(delegate(string name) { return name.Length > 4; });
            List<string> mgbNames = names.FindAll(
               delegate(string name)
               {
                   if (name.StartsWith("M")|| name.StartsWith("G") || name.StartsWith("B"))
                   {
                       return true;
                   }
                   return false;
               });
            Console.WriteLine("There are {0} long names.", longNames.Count);
            Console.WriteLine("There are {0} MGB names.", mgbNames.Count);
            Console.ReadLine();
        }
```
  
The console shows: `There are 3 long names.There are 3 MGB names.`

## Adding Parameters

What if my special search needs an additional parameter? Just create a wrapper class  

```cs
class Program
   {
        static void Main(string[] args)
        {
            List<string> names = new List<string>();
            names.Add("Mary");
            names.Add("George");
            names.Add("Hank");
            names.Add("Billy");
            names.Add("Susan");
            names.Add("Ed");
            Predicate<string> isNameBilly = IsName("Billy");
            List<string> billyNames = names.FindAll(isNameBilly);
            Console.WriteLine("There are {0} Billy names.", billyNames.Count);
            Console.ReadLine();
        }
        static Predicate<string> IsName(string name)
        {
            return delegate(string item)
            {
               return item.Equals(name);
            };
        }
   }
```

I can create a method that returns a method. What is amazing about this is the ability to pass extra parameter into the dynamic method.
