---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Unit Cost on Shared infrastructure"
date: "2024-11-12"
tags:
  - "FinOps"
---

Calculating unit cost on shared resources is difficult.

I first ran into this ask when I was working with customers who were building IoT solutions. Most IoT solutions use shared resources like IoTHub, Event Hubs, storage etc. However, the business builds a business proposals based on the unit cost of manufacturing and operating individual devices. Ideally, the business would like to know the cost of the shared resources as a function of unit cost.

## General IoT Architecture

![IoT Architecture]({{ site.url }}{{ site.baseurl }}/assets/images/20241112-unit-cost-iot-architecture.png)

**Devices & Ingestion**
Individual devices connect to ingestion point like IoTHub

**Process and Storage**
Event data is stored and manipulated through various processes. These include Event Hubs, Functions, Notebooks, Apps, Databases, Machine Learning Model, etc.

**Applications**
Present the final data in a business offering.

## Device Type Effect on Cost

![Device Type Effect on Cost]({{ site.url }}{{ site.baseurl }}/assets/images/20241112-device-type-effect-on-cost.png)

This is a framework I use to illustrate that not all devices have the same impact on shared resources.

Device Types:
* Chatty Device (in blue): sends many frequent, small messages.
* Bulk Upload Device (in orange): uploads data in large, infrequent batches.
* Complex Device (in yellow): high processing needs or complex data.

| Device Type        | Message Count | Message Size | Message Complexity | Storage Impact | Compute Impact |
|--------------------|---------------|--------------|--------------------|---------|---------|
| Chatty Device      | High          | Small        | Low                | High    | Low     |
| Bulk Upload Device | Low           | Large        | Low                | High    | Low     |
| Complex Device     | Low           | Small        | High               | Low     | High    |

This breakdown can help in distributing cloud costs more accurately among different device types in an IoT setup, guiding cost optimization strategies for each type.

## Cost Types

![Cost Typs]({{ site.url }}{{ site.baseurl }}/assets/images/20241112-unit-cost-types.png)

**Fixed**
The cost of a specific device should be shared between all devices that used the resources during a specified time period. The cost should be proportional to the device’s usage during the time period

**Variable**
Device cost should be 1:1 between resource consumption costs.

## Tracking Unit Cost

![Cost Typs]({{ site.url }}{{ site.baseurl }}/assets/images/20241112-tracking-unit-cost.png)

**Networking**
Must use a proxy to capture Bytes per hr.

**Storage**
Measure GB/hr through folder Naming convention, sampling data, or proxy

**Server**
There is not a way to track unit costs at the server layer. Must be connected to Middleware or application.

**Middleware and Applications**
Logging unit activity, message count, size, and time to use a proxy for Server and Storage.

## Risks and Assumptions

* Solution must show cost per connected device and/or Transaction
* Solution must include all resources costs
  * Consider separating pure fixed costs independent of device/unit costs
  * Consider different accounting models for fixed/independent costs
* Cost per device should go down due to economies of scale
* Consider Standardizing measuring units as Cost Per Unit
  * Unit may be different for different companies (Seat per kilometer, device, sensor per vehicle, etc)
  * Unit can be a transaction (ticket sale, etc)
* Device are heterogeneous in message size, frequency and complexity
* Device will have different impact on Storage, Compute, etc
* Applications may use subset of entire IoT pipeline
* Shared Resources have Fixed and Variable Costs
