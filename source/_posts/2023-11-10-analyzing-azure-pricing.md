---
layout: post
current: post
navigation: True
title: Analyzing Azure Pricing
date: 2023-11-10
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

Customer often ask me about how to analyze their Azure costs.  This is a very broad question and there are many ways to answer it.  This post will focus on the different types of prices, discounts, and offers that are available.  I will also provide some examples of how to use the Azure APIs to analyze your costs.

## Azure Pricing

Azure has a number of different pricing models. The broadest categories are:

- [Pay-as-you-go](https://azure.microsoft.com/en-us/pricing/purchase-options/pay-as-you-go/)
- [Azure Enterprise Agreement (EA)](https://azure.microsoft.com/en-us/pricing/enterprise-agreement/)
- [Microsoft Customer Agreement (MCA)](https://azure.microsoft.com/en-us/pricing/microsoft-customer-agreement/)
- [Microsoft Partner Agreement (MPA)](https://azure.microsoft.com/en-us/pricing/microsoft-partner-agreement/)

Then you can get discounts on the prices based on:

- [Azure Reservations](https://azure.microsoft.com/en-us/pricing/reservations/)
- [Reserved Instances](https://azure.microsoft.com/en-us/pricing/reserved-vm-instances/)
- [Azure Hybrid Benefit](https://azure.microsoft.com/en-us/pricing/hybrid-benefit/)
- [Azure Spot Instances](https://azure.microsoft.com/en-us/pricing/spot/)
- [Azure Dev/Test Pricing](https://azure.microsoft.com/en-us/pricing/dev-test/)
- [Azure Free Account](https://azure.microsoft.com/en-us/free/)
- and more...

The question I get asked most often is how do I analyize my costs. I like to use a few specific Azure apis.

## Azure APIs

These are the primary APIs I use to analyze Azure costs. 

| API | URL | Description |
| --- | --- | --- |
| [Retail Price Sheet API](https://learn.microsoft.com/en-us/rest/api/cost-management/retail-prices/azure-retail-prices?view=rest-cost-management-2023-08-01)  |https://prices.azure.com/api/retail/prices?api-version=2023-01-01-preview&meterRegion='primary' | Get the retail prices for Azure services.  |
| [Negotiated Price Sheet API](https://learn.microsoft.com/en-us/rest/api/cost-management/price-sheet?view=rest-cost-management-2023-08-01) | GET https://management.azure.com/subscriptions/{subscriptionId}/providers/Microsoft.Consumption/pricesheets/default?api-version=2023-05-01 | Get the negotiated discounted price sheet for EA agreements. |
| [Exported Billing Data](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/ingest-azure-usage-at-scale) | https://management.azure.com/{scope}/providers/Microsoft.CostManagement/exports/{exportName}?api-version=2020-06-01 | Shows what was actually paid for Azure services. |

I use the Retail Price Sheet as the baseline for service costs. However, this is not typically the price that you will pay.  The Negotiated Price Sheet will show you the discounted price that you will pay.  The Exported Billing Data will show you what you actually paid.  The difference between the Retail Price Sheet and the Negotiated Price Sheet/Exported Billing Data is the discount that you received.

Exported Billing Data have two datasets:
* ActualCost - Shows when you pay for an RI
* AmortizedCost - Shows when you use an RI. Best used for chargeback.

The key columns are from the AmortizedCost dataset:

| Column | Description |
| --- | --- |
| `EffectivePrice` | Cost after Discounts and RIs |
| `Pay-as-you-goPrice` | Retail Price. |
| `UnitPrice` | Price with Discounts. No RI applied |

## Azure Pricing Analyzing Example

**As an Organization I want to have 90% of candidate VMs to be covered by an RI**

![Compute - RI Covered]({{ site.url }}{{ site.baseurl }}/assets/images/20231110-recipe-compute-ri-covered.png)

This an example Recipe, which I've talked about in [Cost Optimization Strategic Thinking](https://www.brigl.com/blog/2021/06/16/cost-optimization-strategic-thinking/), where the goal is to have 90% of candidate VMs covered by an RI.  

The next step is to define the scheme and the source for the data.

**Schema**

Parameters may include:
* `optimal_percentage` As the target to compare cost

| Field | Type | Notes |
|-------|------|-------|
| date  |      |       |
| subscription_name |  | Filter  |
| subscription_id | nvarchar(100) | Filter |
| resource_group | nvarchar(100) | Filter |
| ri_candidate_vm_count | int | Count of vms that match a specific requirement. |
| ri_covered_vm_count   | int | Count of vms that used ri pricing. Compare `UnitPrice` to `EffectivePrice` from the `AmortizedCost` to see when an RI is used.|
| ri_uncovered_vm_count | int |  Calculated ri_candidate_vm_count - ri_covered_vm_count |
| cost | decimal | Total cost for all VMs |
| optimal_cost | decimal | Calculated cost targeting `optimal_percentage` coverage goal. |
| is_forecast | bool | Forecasted data |

The key pieces of data are around calculated the forecasted cost and the optimal cost.  The forecasted cost is the cost that you will pay if you do nothing.  The optimal cost is the cost that you will pay if you meet your goal.  The difference between the two is the savings.

So we need to figure out where to source the data for each of these fields.

**Source Data**

* cost
    * Found in the `EffectivePrice` column of the `Exported Billing Data` AmortizedCost dataset.
    * This shows what we end up paying including all discounts.
* cost (forecasted)
    * Found in the `Quantity`, `EffectivePrice` and `UnitPrice` columns of the `Exported Billing Data` AmortizedCost dataset.
    * Use these fields during the previous time period and predict what the next time period quantity will be.
    * Use the `UnitPrice` from the `Negotiated Price Sheet API` for any servcices not found in the historic billing data.
    * The Price Sheet data includes discounted prices but not reservations.
* optimal_cost 
    * Find the ri price for each of the vm types in `ri_candidate_vm_count`
    * Use `EffectivePrice` from  `Exported Billing Data` AmortizedCost or calculate the percetange discount from the `UnitPrice` from the Retail Price Sheet API


## References
* [Understand Cost Management data](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/understand-cost-mgt-data) 
[Azure Retail Prices overview](https://learn.microsoft.com/en-us/rest/api/cost-management/retail-prices/azure-retail-prices?view=rest-cost-management-2023-08-01)
* [Cost Management APIs overview](https://learn.microsoft.com/en-us/azure/cost-management-billing/automate/migrate-ea-reporting-arm-apis-overview)
* [Reporting APIs for Enterprise customers - Price Sheet](https://learn.microsoft.com/en-us/rest/api/billing/enterprise/billing-enterprise-api-pricesheet)
* [Retrieve large cost datasets recurringly with exports from Cost Management](https://docs.microsoft.com/en-us/azure/cost-management-billing/costs/ingest-azure-usage-at-scale)
* [Create and Manage Exported Data](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/tutorial-export-acm-data?tabs=azure-portal) 
* [Understand cost details fields](https://learn.microsoft.com/en-us/azure/cost-management-billing/automate/understand-usage-details-fields?source=recommendations)
* [Azure Cost Management REST API](https://docs.microsoft.com/en-us/rest/api/cost-management/)
* [Azure Cost Management REST API - Retail Prices](https://docs.microsoft.com/en-us/rest/api/cost-management/retail-prices/azure-retail-prices?view=rest-cost-management-2023-08-01)
* [Azure Cost Management REST API - Price Sheet](https://docs.microsoft.com/en-us/rest/api/cost-management/price-sheet?view=rest-cost-management-2023-08-01)
* [Azure Cost Management REST API - Usage Details](https://learn.microsoft.com/en-us/rest/api/cost-management/generate-cost-details-report?view=rest-cost-management-2023-08-01)
* [Azure Cost Management REST API - Exports](https://learn.microsoft.com/en-us/rest/api/cost-management/exports/create-or-update?view=rest-cost-management-2023-08-01&tabs=HTTP)
