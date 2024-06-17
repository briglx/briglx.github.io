---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Multi-tenant SaaS Deployment Models"
date: "2024-02-29"
tags:
  - "cloud"
  - "saas"
---

A key foundational decision for a multi-tenant SaaS solution is the deployment model. I've been in serveral workshops with teams who are trying to build multi-tenant SaaS solutions and this is the model I've used to walk through the various options, capabilities, responsibilities, and trade-offs.

![Multi-tenant SaaS Deployment Models](/images/20240229-multi-tenant-saas-deployment-options.png)

## Deployment Models

| Option | Title     | Environment | Tenancy   | Data            | Managed By | Description |
| ------ | --------- | -------- | ------------ | --------------- | -------- | ----------- |
| A      | Shared    | Provider | Multi-tenant | Segregated data | Provider | Typical shared service deployment. The customer can only access their own data. The system scales as demand grows. | 
| B      | Isolated  | Provider | Multi-Tenant | Isolated        | Provider | Shared application compute with data that is separated in a dedicated data store. | 
| C      | Dedicated | Provider | Single       | Isolated        | Provider | Separate instance of the application and data deployed for a single customer | 
| D      | Private   | Customer | Single       | Isolated        | Provider | Separate instance of the application and data deployed in the customer's environment. The customer can provide access to the provider for managed services, support, etc. Consider the required prerequisites (Network, IAM, etc). Be transparent of all data, telemetry and log data, captured by the provider. | 
| E      | Remote    | Customer | Single       | Isolated        | Customer | Customers can export data into their own environment. | This may include the ability for the customer to use the application in the provider's environment but have the data live in the customer's environment | 
