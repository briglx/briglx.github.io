---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "How to Convert Integers to Strings in C#"
date: "2007-08-31"
tags: 
  - "net"
  - "c"
---

I've been working with converting strings to integers and have a few options at my disposal. 

In the past I've bounce between using Convert.Int32(string) and Int.Parse(string). I've decided to look into what really goes on under the covers between these different options.

There are three different ways to convert one item to another:

- Implicit Conversion Operator
- Explicit Conversion Operator
- Use a Format Provider

## Conversion Operator

In order for the implicit and explicit conversions to work, the class/structure must define a [Conversion Operator](http://msdn2.microsoft.com/en-us/library/09479473(VS.80).aspx). The example below will allow an explicit conversion from int to SampleClass. Notice how the method takes an int and returns the SampleClass type:

`class SampleClass { public static explicit operator SampleClass(int i) { SampleClass temp = new SampleClass(); // code to convert from int to SampleClass...

return temp; } }`

Using the conversion in real code would then be: `int i = 45; SampleClass sc = new SampleClass(); sc = (SampleClass)i; // Explicit conversion` If I had defined the method as implicit instead, then I wouldn't need the cast like operation. I could have just written: `sc = i; // Implicit conversion` What I really wanted to know is how strings are converted into integers. The String class doesn't implement either an implicit or explicit conversion to int. This leaves me the option of having to use a Format Provider object. `public class String { static public explicit operator int(String string) // Doesn't exist. static public implicit operator int(String string) // Doesn't exist. }`

## Format Provider

The framework offers two Format Provider methods:

- Convert.ToInt32(string)
- Int.parse(string)

The two are actually connected because Convert.ToInt32 calls Int.parse after it does a check for a null string.

Int.parse() is the real worker because it dives deep into several methods and finally does all the work to convert text into different numbers.

- Int.parse(string)
    - calls Number.ParseInt32(s, NumberStyles.Integer, NumberFormatInfo.CurrentInfo)
        - calls Number.StringToNumber(s, style, ref buffer1, info, false)
            - Calls Number.ParseNumber(ref chPtr2, options, ref number, info, parseDecimal)
                - Does all the work here

## Summary

There are no implicit or explicit conversions from a string to an integer, you must use a format provider method. The two options available with the library are really one option.

<table width="519" border="1" cellspacing="0" cellpadding="2"><tbody><tr><td valign="top" width="204"></td><td valign="top" width="137">Is Null</td><td valign="top" width="175">Is Not Number</td></tr><tr><td valign="top" width="204">Convert.ToInt32(string)</td><td valign="top" width="137">Return 0</td><td valign="top" width="174">FormatException</td></tr><tr><td valign="top" width="204">Int.Parse(string)</td><td valign="top" width="137">ArgumentNullException</td><td valign="top" width="174">FormatException</td></tr><tr><td valign="top" width="204">Int.TryParse(string, out int)</td><td valign="top" width="137">Return false</td><td valign="top" width="174">Return false</td></tr></tbody></table>
