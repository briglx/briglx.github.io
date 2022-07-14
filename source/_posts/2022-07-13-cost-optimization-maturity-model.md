---
layout: post
current: post
navigation: True
title: Cost Optimization Maturity Model
date: 2022-06-10
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

Several times a month I'm asked to join customer calls around cost optimization because I have helped really large Azure customers get a better handle on their cloud spend. I'd like to share my experience and help you to:

- Describe the Cost Optimization Maturity path cloud adopters take
- Identify the various Cost Optimization Tools and Solutions available to cloud adoptors and common Gaps and Limitations
- Deliver Cloud Financial Management Conversations
- Name Cost Optimization Recipes and Discuss how to share Recipes

## Phase 1 - Freaking Out

![Phase 1 - Awareness]({{ site.url }}{{ site.baseurl }}/assets/images/20220713-cloud-maturity-phase1.png)

The first phase is watching the bill grow overtime without any understanding around why. This is really scary because it feels like you are sitting in a raft without a paddle moving through wild water careening towards a giant cliff. 

There's not much to do in this phase other than completely ignore the slowly growing problem, or ask from some help.

## Phase 2 - Finding Tools

![Phase 2 - Tools]({{ site.url }}{{ site.baseurl }}/assets/images/20220713-cloud-maturity-phase2.png)

Learning about tools that will help you manage cost is what distinquishes Phase 2 from Phase 1. Now we have a few things to help manage the costs. On Azure, there are tools like:

- Documentation
- Azure Advisor
- Azure Cost Management and Billing Portal
- Azure Cost Management (Power BI App)
- Power BI Cost Management Connector (Power BI Desktop)
- Well Architected Framework Cost Optimization Workbook
- Additional Tools


### Documentation

Two great sources around best practices can be found in the CAF and WAF. Search for terms like Cost or billing.

- Microsoft Cloud Adoption Framework (CAF) for Azure [https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/)
- Microsoft Azure Well-Architected Framework (WAF) [https://aka.ms/architecture/framework](https://aka.ms/architecture/framework)

### Azure Advisor

Azure Advisor is an amazing product. It monitors predefined best practices, alerts you when there are exceptions, and allows you to take action to mitigate the issue.

It will provide cost recommendations based on your usage and configurations, such as:
- Shut down unused VMs
- Rightsize underused VMs
- Buy Reserved Instances for consistent resources
- Delete idle network gateways

Many alerts have step-by-step guidance to easily remediate recommendations.

![Azure Advisor]({{ site.url }}{{ site.baseurl }}/assets/images/20220713-cloud-maturity-advisor.png)

You can review Advisor recommendations in the Azure portal: [aka.ms/azureadvisor](https://aka.ms/azureadvisor)

### Azure Cost Management and Billing Portal

Azure Cost Managment (ACM) and Billing Portal is gaining so many new features I can't keep up. Use it to:

- Explore Cost
- Manage Reservations
- Set spending thresholds and more

![Azure Advisor]({{ site.url }}{{ site.baseurl }}/assets/images/20220713-cloud-maturity-cost_management_billing.png)


### Azure Cost Management + Billing Power BI App

An azure enterprise aggreement administrator can run the [Azure Cost Management (ACM) Power BI template application](https://docs.microsoft.com/en-us/azure/cost-management-billing/costs/analyze-cost-data-azure-cost-management-power-bi-template-app) by logging into the Power BI Service at https://powerbi.com

The solution connects into the Azure Billing API has pre-configured reports:
- Account overview
- Consumed Usage by Subscriptions and Resource Groups
- Top 5 Usage drivers
- Consumed Usage by Services
- Windows Server Hybrid License Usage
- VM RI Coverage (shared and single recommendation)
- RI Savings, Chargeback, purchases
- Pricesheet

You can also create ad hoc reports using the underlying data. This is generally my go to solution to show off how to slice and dice billing data for those who are looking for specialized reports.

![ACM Power BI Template App]({{ site.url }}{{ site.baseurl }}/assets/images/20220713-cloud-maturity-amc_pbi_app.png)

### Azure Cost Management Connector for Power BI

When I can't slice and dice the way I want with the ACM Power BI Template App, I turn to use the full-blown PowerBI desktop app and connect into the Billing Data directly using the [Cost Management Connector for Power BI](https://docs.microsoft.com/en-us/power-bi/connect-data/desktop-connect-azure-cost-management). This let's me split or join columns, aggregate data, and do any data clensing or preparation I can think of. I can also join it with other data sources.

When a really difficult request comes in, like a `point in time comparison` report, I fire up Power BI Desktop and use this tool. 

### WAF Cost Optimzation Workbook

Microsoft has a service where engineers can sit with a customer and analyze the environment. One tool the team uses is the Well Architected Framework Cost Optimization Workbook. It is a deployable Workbook to Azure Monitor and queries Azure logs and the Azure Graph API to inspect the current environment. Some of the reports include:

- Idle/unattached items
- Orphaned resources
- Unattached Public IPs
- Hybrid benefits and more

![ACM Power BI Template App]({{ site.url }}{{ site.baseurl }}/assets/images/20220713-cloud-maturity-amc_pbi_app.png)

### Additional Tools

Other goto tools to help better understand costs include

- [Azure Pricing Calculator](https://azure.microsoft.com/en-us/pricing/calculator/)
- [Azure Migrate](https://docs.microsoft.com/en-us/azure/migrate/)
- [Azure Hybrid Benefits](https://docs.microsoft.com/en-us/hybrid/)
- And more

## Phase 3 - Outgrowing the Tools

![Phase 3 - Outgrowing tools]({{ site.url }}{{ site.baseurl }}/assets/images/20220713-cloud-maturity-phase3.png)

At some point the tools either don't provide the information we need or the data is too large to use the tools. 
My experience has been when an organization reaches the $2M / month in consumption the file size for billing data approaches 2-3GB. Excell and PowerBI start to slow down. 

Organization will sometimes sit in this spot for various reasons before moving onto the next phase. At this point the organization really has to mature and commit to treating cost management as more than just a one-off activity and instead integrate it as part of the strategy and culture of cloud adoption.

## Phase 4 - Create a New Tool

![Phase 4 - New Tool]({{ site.url }}{{ site.baseurl }}/assets/images/20220713-cloud-maturity-phase4.png)

When I faced this phase several years ago, I was toying around with [a solution](https://github.com/briglx/AzureBillingReports) from my background in big data and interviewed my coleagues with other large organization asking how they solved the problem. The responses were consistent with my solution. 

![Big Data Enterprise Solution]({{ site.url }}{{ site.baseurl }}/assets/images/20220713-cloud-maturity-big-data-arch.png)

The architecture is a modern datawarehouse pipeline which is scalable and can:

- Ingest data from multiple data sources
- Process and enrich the data
- Save in a long-term database

Deploying the pipeline solves so many chalenges and creates more overhead as well. But the cost is well worth the benefit.

No longer do we need to worry about the size of the billing data, or the number of sources we combign and aggregate. No longer do we wait for reports to return results because the database is hyper-tuned for the final reports. 


## Phase 5 - Wrong Audience

![Phase 5 - Wong Audience]({{ site.url }}{{ site.baseurl }}/assets/images/20220713-cloud-maturity-phase5.png)

Phase 5 is a cycle of cost cutting and organic growth. The behavior shows up anytime during the maturity growth phases because it's more of an issue around how to think about cost management. I put it here because implementing a big data pipeline is a lot easier than changing the hearts and minds of an entire organization.

The main ideas here are:

- Effective Leaders execute against a Strategy
- Teams should focus on delivering value
- Spending money is not the issue, Trust is
- Different audiences require different reports

A good leader does not want to arbitrarily cut cost not only because it's a poor way of managing a business but because it lacks a strategy. The effort is defined as a financial metric instead of impact to core Business value unique to the organization.

Accross the board cost cutting also hurts the teams who rally to meet the commitment. The unpredictable cost cutting exercise impacts the teams ability the work on value creation.  In addition, some teams may already be efficient in their space and forced to sacrifice reliability, functionality, or security in order to meet the cost cutting goals.

Generally leadership teams don't have a problem spending money in an investment they believe in. The cycle of cost cutting and organic growth is an indicator that the leadership lacks confidence in the cloud and the team managing it. 

Executives need to see measure the health of the investment. This includes monitoring KPIs around Business Outcomes which align to overal strategy. As part of the FinOps organization, I see more and more organizations moving towards measuring business outcomes instead of cost cutting. 

Operation teams ask for reports that can monitor the health of the environment and enforce corporate standards and policies. They want tools to help them with Charge Back models of Cloud Costs.

Development Teams can use reports that will help them comply with standards and implement improvement recommendations and best practices. Teams can integrate small positive changes each sprint without impact to feature development.

Analysts need the tools to explore the data and find edge cases that will inform future strategies.

### Define a Strategy

Moving from seeking and destroying cost to strategic thinking requires a three phased approach:

- Define Best Practices
- Measure and Monitor
- Remediate

![Three phased Approach]({{ site.url }}{{ site.baseurl }}/assets/images/20220713-cloud-maturity-strategy.png)

I like to think I'm extending the capability of Azure Advisor with this method. 

**Best Practices**

These are technology agnostic and should be defined in a way that everyone can aggree on:

- Turn off Development Machines on the Weekend
- Resize VMs to have high utilization
- Apply reservations recomendations

See https://aka.ms/architecture/framework for more.

**Measure and Monitor**

![Measure and Monitor]({{ site.url }}{{ site.baseurl }}/assets/images/20220713-cloud-maturity-measure-monitor.png)

With the right visulization, leaders can trus teams are moving in the right direction. They see the stratgy of best practices being implement in real time. They have the information needed in order to make decisions.

## Phase 6 - Recipies

![Phase 6 - Recipies]({{ site.url }}{{ site.baseurl }}/assets/images/20220713-cloud-maturity-phase6.png)

The last phase is an organization developing reports that measure best practices. The organization has a common data schema from the pipeline to quickly create new reports. The reports Measure new Best Practices and teams can Discover and Share recipies between organizations.
