---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Json Serialization"
date: "2009-02-04"
tags:
  - "net"
  - "json"
---

I've been having fun trying to implement an idea I have. Part of the idea involves caching objects to [memcached](http://www.danga.com/memcached/) in [Json](http://json.org/) format. The idea being that the object saved to memcached wouldn't be bound to .Net specific methodology.

## What's out There

At first I looked into creating a [Custom Formatter](http://msdn.microsoft.com/en-us/magazine/cc188950.aspx) that would serialize my object for me. That seemed like an overkill so I searched for a faster and prepackaged library. After poking around to see what Json serializers were on the market, I found [Json.NET](http://www.codeplex.com/Json).

At first this looked like a possible solution. Then I ran the Test Scripts on the Project and found a PerformanceTests test. This test script had timings for three different types of serializers. So my options were:

- Roll my own with a [Custom formatter](http://msdn.microsoft.com/en-us/magazine/cc188950.aspx)
- [Json.NET](http://www.codeplex.com/Json).
- [JavaScriptSerializer](http://msdn.microsoft.com/en-us/library/system.web.script.serialization.javascriptserializer.aspx)
- [DataContractJsonSerializer](http://msdn.microsoft.com/en-us/library/system.runtime.serialization.json.datacontractjsonserializer.aspx)

## Performance

I changed the Json.Net Performance tests to serialize and deserialize 1000 times. The JavaScriptSerializer was the fastest during the tests.

<table cellspacing="0" cellpadding="2" width="400" border="0"><tbody><tr><td valign="top" width="200"><strong>Serializer</strong></td><td valign="top" width="200"><strong>Time</strong></td></tr><tr><td valign="top" width="200">JsonNet</td><td valign="top" width="200">203 ms</td></tr><tr><td valign="top" width="200">JavaScriptSerializer</td><td valign="top" width="200">95 ms</td></tr><tr><td valign="top" width="200">DataContractJsonSerializer</td><td valign="top" width="200">842 ms</td></tr></tbody></table>

## Strangeness

One of the bad things I saw happen is how the DataContractJsonSerializer tried to serialize the private methods of the class. So I though I would try to force it to use the properties of the class by not defining a backing variable.

```public string Name { get; set; }```

What to my surprise when I saw the following in the Json output:

`"<Name>k__BackingField":"Rick"`

Weird.
