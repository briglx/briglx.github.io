---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Building an Inferencing Engine"
date: "2013-03-29"
tags:
  - "software"
  - "inferencing"
  - "mongodb"
  - "rdf"
cover: /assets/images/induction.png
---

I'm playing around with the idea of building an [inference engine](http://en.wikipedia.org/wiki/Inference_engine) for [MongoDB](http://www.mongodb.org/). The idea is to load up some [RDF data](http://www.w3.org/RDF/) and attempt to run queries that use the [ontologies]({% post_url 2012-10-26-what-graphs-and-ontologies-mean-to-you %} "What Graphs and Ontologies mean to you") in the RDF for inferencing. For instance, if I have an ontology that defines an `isParentOf` relationship with an inverse relationship of `isChildOf`, the inferencing engine would know those two relationships are inverse. When the data store only has one record that defines

```xml
<AugustCoppola> <isParentOf> <NicolasCage>
```

I can get a result from the following query even though this record doesn't exist.
```xml
? <isChildOf> <AugustCoppola>
```

Looking briefly into how I could do this, I found the following:

- [Jena](http://jena.apache.org/documentation/inference/index.html)
- [Pellet](http://clarkparsia.com/pellet/)
- [Strategies](http://notes.3kbo.com/)

The trick is to make it happen.
