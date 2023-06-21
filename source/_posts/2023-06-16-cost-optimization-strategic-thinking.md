---
layout: post
current: post
navigation: True
title: Cost Optimization Strategic Thinking
date: 2023-06-16
tags: 
  - cloud
  - cost
  - optimization
  - finops
  - azure
class: post-template
subclass: 'post'
author: brig
---

I previously talked about the maturity path organizations go through adopting Cloud Cost Optimization. Sense then, I've created a session and workshop guiding executive teams how to have a strategic mindset for Cost Optimization. This session is great to deliver any time in the maturity path and is most relevant to organizations struggling to understand and control cost despite deploying a data pipeline to standardize cost data. I like to tell people it will help the organization move away from reactively chasing fires and towards measuring best practices.

The session objectives are:

* Recognizing the organization mindset
* Understand how to develop strategic based reporting using primary cost drivers
* Establish a framework to capture and prioritize requirements.

## Move away from the Fire

I'm often pulled into calls where customers are overwhelmed and frustrated and say something along the lines of "Help! Our storage cost is too high." I completely understand how large and complex cloud cost optimization is and how difficult it can be to know where to start. 
I coach teams to recognize when they are in a seek and destroy mindset chasing fires and encourage them to adopt the strategic three phased approach:

* Define Best Practices
* Measure or Monitor compliance to the best practice
* Define and Implement Remediation methods

This approach changes traditional reporting by turning it into measuring the compliance of best practices. In addition, it creates a place for organizations to define how to remediate in the event they are not in compliance.
Leadership teams love this approach because it is nothing more than defining a plan, measuring progress, and creating playbooks to stay on target. It's data driven, able to hold team accountable, and outcome based.

Defining best practices can be difficult and is sometimes more art than science. One technique I like to use is to look at the primary cost drivers of a service.

## Primary Cost Drivers Lead the Way
Most services have several different drivers that go into the final cost. These can be found in the documentation or using the Azure Pricing Calculator. 

![Storage Primary Cost Driver Sources]({{ site.url }}{{ site.baseurl }}/assets/images/20230616-storage-primary-cost-drivers-source.png)

For Azure Blob Storage these include:

**Azure Blob Storage Pricing**: File Structure, Redundancy, Region, Access Tier, Capacity, Reservation, and Operations

**Pricing Calculator**: Region, Type, Performance, Storage Type, Access Tier, Redundancy, Capacity, Reservation, and Operations 

I wrote a small tool to help me identify the primary cost drivers for storage using a technique called [feature reduction.](https://en.wikipedia.org/wiki/Dimensionality_reduction)

Turns out the primary cost drivers for storage are:
* Capacity
* Access Tier
* Redundency
* Region
* ... all others

![Storage Primary Cost Drivers]({{ site.url }}{{ site.baseurl }}/assets/images/20230616-storage-primary-cost-drivers.png)

It makes sense that capacity is the top cost driver because the more data I put into storage the more it's going to cost. I was suprised to see that access tier had a larger influence on cost than redundency.

Identifying the cost drivers is usefull in a few ways:
* Allows me break the problem into smaller pieces
* Use the relative impact of each cost drivers to prioritize efforts and develop a road map
* Provides a starting point to brainstorm best practices

## Defining a Best Practice for Cost Drivers

Now that we have our top cost drivers, we need to define best practices. This is what the organization can implement the powerful leadership principle of ["Do what you say you will do"](https://www.linkedin.com/pulse/leadership-principles-1-do-what-you-say-melissa-hosgood/)

For each cost driver, consider not only how you can influence cost, but how do you want to run your organization.

Example Brainstorm for Storage Cost Drivers:

* Capacity
  * Reduce Capacity
    * Data Compression
    * Deduplication
    * Resize VM Drives
    * Data Retention Policies
  * Reserve Capacity
    * Only Block Blob and Azure Data Lake Storage Gen2
    * Premium not eligible
    * Region, Access Tier, and Redundancy dependent
    * Purchase Units of 100TiB and 1PiB for 1-3yrs
  * ...
* Access Tier
  * Organize data into access tiers
  * Automatically move data between access tiers
  * ...
* ...

Example Best Practices:
* Storage - Capacity: As an organization have 50% of data stored in a compressed format (snappy, gzip, lzo, etc.)
* Storage - Capacity: As an organization have 95% of data active retention age and 5% expired 
* Storage - Capacity: As an organization have 80% Reserved Capacity for all eligible storage
* Storage - Access Tier: As an organization have 90% Aligned Data
* Storage - Access Tier: As an organization have 95% data with lifecycle policies applied

We now have a collection of best practices to follow. Setting a goal means nothing if it isn't tracked.

## Measure Compliance

The management guru Peter Drucker once said, “If you can’t measure it you can’t improve it.” Our task now is to measure our compliance to the best practice standards we have defined.

Include the following capabilities:
* Separate composite metrics into atomic units. Ie. `total_cost` into  `quantity` and `unit_cost`
* Display current `SLI` as a percentage. Ie. 78% Data Aligned of total data in past 24hrs.
* Prefer fewer SLI states. Ideally no more than three. Ie. Aligned, MisAlligned 
* Display Historical Trends. This is key in building trust for leadership.
* Forcast next period's SLI and Cost
* Calculate Organization SLO and Cost
* Display Potential Savings as `Forecast Cost` - `Forecast SLO Cost`.
  
![Access Tier]({{ site.url }}{{ site.baseurl }}/assets/images/20230616-storage-access-tier.png)

This chart shows the organization target `aligned data` SLO of 95%. We can see the current SLI is 78% aligned an 22% misaligned.
It also shows historic values for Quantity, SLI State, and Cost. This breakout is useful because often times teams may spend a lot of time to improve an environemnt but cost remain the same. By breaking out quanity from cost, teams can demonstrate to leadership teams the amount of optimization improvement happening.
For instance, between the second and third months, Cost went down but the total footprint incrased. This happened becasue the team improved the percentance of aligned data effectivly lowering the unit cost theirby lowering total cost.
Finally, the forecast shows the expected growth in the environment for total storage, along with the expected aligned data and the associated costs. It then shows what the cost would be if the organization acheived it's target SLO of 95%.
The diffeence between the forecast and the target is the potential savings of $1,687.

Following these standards in visualising best practices has the following benifits:
* Leadership and Operations teams can priorities efforts to target improvements that have the largest potential savings
* Operations team can demonstrate optimization efforts that oftentimes gets lost when strickly looking at cost
* Reports are Action oriented to improve SLO. Leaders love this approach
* Standard SLI provide a common language to the organization that allows teams to create new Best Practices and SLO

The final steps in democratizing data is establishing a framework to capture requirements

## Recipes for Best Practices

I've been using the term Recipe to describe the various request organizaton have asked me for help with cost optimization.
Some of these are:
* I want to turn of dev machines on the weekend
* I don't want premium storage in dev environments
* Help me save cost by removing orphaned disks

The framework for a recipe is:

* Overview
  * Objective
  * Vizualiztion
* Data Schema
* Data Source and Transformation
* Remediation

A few best practices include:
* Versioning the recipe and the source data
* Using Standard data sources

Example: Orphaned Disks

### Overview
Best Practice: As an organization, have 90% attached disk (<10% orphaned)

**Sketch**
![Orphaned Disks Sketch]({{ site.url }}{{ site.baseurl }}/assets/images/20230616-storage-orphaned-disks-sketch.jpgg)

**PowerBI Example**
![Orphaned Disks PowerBI]({{ site.url }}{{ site.baseurl }}/assets/images/20230616-storage-orphaned-disks-pbi.jpgg)

### Schema

Parameters may include:
* `optimal_percentage` As the target to compare cost

**Single Table**
| Field | Type | Notes |
|-------|------|-------|
| date |   | |
| subscription_name |  | Filter  |
| subscription_id | nvarchar(100) | Filter |
| resource_group | nvarchar(100) | Filter |
| orphaned_disk_count | |
| attached_disk_count | |
| total_disk_count | | Calcuated orphaned + attached 
| attached_disk_percent | | Calculated attached / total | 
| cost | | |
| is_forecast | | Forcasted data |
| is_latest | | Indicates the most recent data |
| is_optimal_forcast | | Indicates optimal forecast |
| forecast_cost | | Calculated cost if record is_forecast=True and is_optimal_forecast=False |
| optimal_cost | | Calculated cost if record is_forecast=True and is_optimal_forecast=True |


### Example Data

|Date|SubscriptionName|SubscriptionId|ResourceGroup|Total Disk Count|Orphan Count|Attached Count|AttachedDiskPercent|Cost|IsForecast|IsLatest|IsOptimalForcast|ForecastCost|OptimalCost|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|1/1/2023|CORP|/subscriptions/00000000-0000-2222-0000-000000000000|rg-dev|10|5|5|50%|200|FALSE|FALSE|FALSE|0|0|
|1/1/2023|CORP|/subscriptions/00000000-0000-2222-0000-000000000000|rg-prod|20|8|12|60%|400|FALSE|FALSE|FALSE|0|0|
|1/1/2023|CORP|/subscriptions/00000000-0000-2222-0000-000000000000|rg-qa|20|7|13|65%|400|FALSE|FALSE|FALSE|0|0|
|1/1/2023|ENG|/subscriptions/00000000-0000-2222-0000-000000000003|rg-dev|7|3|4|57%|140|FALSE|FALSE|FALSE|0|0|

See full dataset `path/to/sample/dataset.csv`

### Source Data

| Source | Version | Details |
|--------|---------|---------|
| Common Data Schema | Lastest | AmortizedCost |
| Azure Graph API Query | v1.0 | resources |

**AmortizedCost SQL Query**
```sql
SELECT 
  [Date]
  , [ResourceId]
  , SUM([CostInBillingCurrency]) as Cost
FROM
  [AmortizedCost]
GROUP BY
  [Date]
  , [ResourceId]
```

**Azure Graph API Query**
```
resources
| where type has "microsoft.compute/disks"
| extend diskState = tostring(properties.diskState)
| project current_date = format_datetime(now(), 'yyy-MM-dd'), subscriptionId, resourceGroup, id, sku_name = sku.name, diskState, managedBy, is_orphaned = (diskState == 'Unattached' or managedBy == "")
``` 

### Transformation

Join AmortizedCost and Azure Graph API Query by ResourceID and Date

```sql
SELECT 
  a.[date]
  , a.[subscription_name]
  , a.[subscription_id]
  , a.[resource_group]
  , b.[is_orphaned]
  , SUM(a.[CostInBillingCurrency]) as cost
FROM
  [AmortizedCost] as a
JOIN
  GRAPH_QUERY as b
ON a.date = b.date and a.resource_id = b.resource_id
GROUP BY
  a.[date]
  , a.[subscription_name]
  , a.[subscription_id]
  , a.[resource_group]
  , b.[is_orphaned]
```

### Remediation

* Delete Disks
```bash
az vm disk delete --id $disk_resource_id
```

## Benefits

This is a long post to really just guide organizations in developing a strategy around cost optimization and move away from a reactionary seek and destroy mindset.

It boils down to:
* Use primary cost drivers to create best practices
* Use the recipe format to define SLOs

If you do this then you enjoy the benifits of:
* Standardize data set
* Data lineage
* Clearly defined SLI and SLO
* Easier to validate and confirm data errors
* FinOps teams can define requirements as recipes and hand off implementation to data analytics team
* Standard schema and recipe format allow to scale new requirements
* Business focuses on acheicing SLO instead of chasing fires
* Roadmap based on Top Spend and Top cost drivers

## Appendex

Terminology
* `Service Level Indicator (SLI)` Clearly Defined Quantitative measurement
* `Service Level Objectives (SLO)` Target value
* `Service Level Agreement (SLA)` Targets and consenquences promised to users