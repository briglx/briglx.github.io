---
title: "What Graphs and Ontologies mean to you"
date: "2012-10-26"
tags: 
  - "graph"
  - "ontology"
  - "rdf"
  - "semantic"
  - "skos"
coverImage: "ontologiesbasics.png"
---

New projects often introduce new terms which can sometimes be used in different ways between team members. Especial when there are multiple teams. This article will clarify the meaning for the following terms and help explain how they are related to one another.

- Graphs
- RDF
- Ontology
- SKOS

Most importantly I hope this will help you use the correct term at the right time and help correct someone who may be abusing a term. We need to start off with a  fundamental concept.

### Basic Concept

[![Simple Graph](http://briglamoreaux.files.wordpress.com/2012/10/ontologiesbasics.png?w=351 "Simple Graph")](http://briglamoreaux.files.wordpress.com/2012/10/ontologiesbasics.png)

A Simple Graph

At the most basic level, a graph is a connection of two things. This graph has something connected to something else. [RDF](http://www.w3.org/RDF/) is a way we can create these graphs. I won't go too much into how RDF describes data except it can store the graph as a [triple](http://www.w3.org/TR/rdf-concepts/#section-triples) in the form (subject, predict, object).

At this point we don't know what each node is or what the meaning of the connection between the nodes are. The graph could be:

(person, married to, person)
(concept, related to, concept)
(course, teaches about, concept)

Notice how I use the [triple notation](http://www.w3.org/TR/rdf-concepts/#section-triples) to explain the graph. RDF gives us a general way to define the parts of a graph, but is there a way we could describe what the nodes and the connection mean in a graph. In other words, is there a way we could define the [semantics](http://en.wikipedia.org/wiki/Semantics) of the graph.

### What is an Ontology

An ontology defines what and how things are connected together.

(classes, are connected by properties to other, classes)

Returning to our earlier list of things, we can see that the subject and objects are classes and the predicates are the properties.

(person, married, person)
(concept, related, concept)
(course, teaches, concept)

### Examples

The best way to see how ontologies work is with a few examples.

#### Social Example

A Social Ontology could define the following classes and properties. A graph of this ontology would only have those elements.

| Class | Properties |
| --- | --- |
| People | Married To |
|  | Knows |

#### [![Social Ontology Graph](http://briglamoreaux.files.wordpress.com/2012/10/socialgraph1.png?w=300 "SocialGraph")](http://briglamoreaux.files.wordpress.com/2012/10/socialgraph1.png)

#### Education Example

An education institution could define different meanings to the nodes and connections in the graph.

| Class | Properties |
| --- | --- |
| Course | Teaches |
| Concept | Attends |
| Person | Knows |
|  | Friend With |

This graph could look like

[![Education Ontology Graph](http://briglamoreaux.files.wordpress.com/2012/10/educationgraph2.png?w=300 "EducationGraph")](http://briglamoreaux.files.wordpress.com/2012/10/educationgraph2.png)

#### SKOS Example

[Skos](http://www.w3.org/2004/02/skos/) is a popular ontology. This ontology has concepts that can be related to each other in broader and narrower terms. There a more classes and properties than I show, the important thing is this one ontology can be used to create hierarchies and a lot of other things.

| Class | Properties |
| --- | --- |
| Concept | Broader |
|  | Narrower |

[![SKOS Ontology Graph](http://briglamoreaux.files.wordpress.com/2012/10/skosgraph.png?w=274 "SKOSGraph")](http://briglamoreaux.files.wordpress.com/2012/10/skosgraph.png)

### Take Aways

The project I'm on has a lot of new terms. Hopefully now we know the difference between an ontology and a SKOS:Concept. There is a lot more to talk about and this should lay the foundation of a common vocabular of terms.
