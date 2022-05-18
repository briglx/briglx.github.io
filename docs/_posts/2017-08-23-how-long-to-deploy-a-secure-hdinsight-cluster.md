---
title: "How Long to Deploy a Secure HDInsight Cluster"
date: "2017-08-23"
tags: 
  - "hadoop"
  - "hdinsight"
---

It takes a while to build a secure HDInsight cluster. In my case it was about an hour from start to finish.

![SecureClusterDeployment](/assets/images/secureclusterdeployment.jpg)

About half of the work was setting up the VNet and configuring the Domain Controllers. The HDInsight cluster took about 30 mins which his about normal.

Some steps were dependent on other steps and also some steps were running asynchronously. I didn't record when I started the process, so I'm using the time of the first time as my zero. Add a few seconds on for the first step to run.

| Deployment step | Time from Start (min) |
| --- | --- |
| Availability Set | 00.00 |
| Public IP | 00.08 |
| Load Balancer | 00.11 |
| VNet | 00.26 |
| BDC Nic | 00.29 |
| PDC Nic | 00.31 |
| Storage Account | 00.31 |
| AD BDC VM | 05.30 |
| AD PDC VM | 05.70 |
| Prepare BDC Script | 12.80 |
| Create AD Forest Script | 23.90 |
| Update Vnet DNS1 Script | 24.10 |
| Update BDC Nic Script | 24.90 |
| Configure BDC Script | 29.70 |
| Update Vnet DNS2 Script | 29.90 |
| Create Cluster | 56.00 |
