---
layout: post
current: post
navigation: True
title: Finding Public IP Details
date: 2022-06-10
tags: 
  - cloud
  - kusto
  - azure
class: post-template
subclass: 'post'
author: brig
---

I was recently asked how to query Azure Resource Graph to find details about what a public ip is associated to.

The goal is to see the different types of resources public ips are assocaited like:

- VMs
- Scalesets
- Bastion hosts
- gateways
- etc
- not associated.

After playing around with the query languange and discovering that it doesn't implement the entire language, no `let` keyword, I came up with the following:

```kusto
resources 
| where type =~ 'Microsoft.Network/publicIPAddresses'
| project  
    id, 
    joinId = iff(isempty(properties.ipConfiguration.id), '', tolower(strcat('/', strcat_array(array_slice(split(properties.ipConfiguration.id,'/'), 1, -3), '/')))),
    orphaned = iff(isempty(properties.ipConfiguration.id), true, false),
    pubipname = name, 
    resourceGroup,
    ipAddress = properties.ipAddress
| extend _provider = iff(orphaned, dynamic([{}]), split(split(joinId, 'providers')[1], '/'))
| extend associated_to_provider = iif(orphaned, '', strcat_delim('/',_provider[1], _provider[2]))
| join kind=leftouter(
    resources
    | project id = tolower(id), name 
    ) on $left.joinId == $right.id
| project 
    id, name = pubipname, ipAddress, orphaned,  associated_to_name = name, associated_to_provider, associated_to_id = joinId
```

This creates a result of:

|   ID  |   NAME    |   IPADDRESS   |   ORPHANED    |   ASSOCIATED_TO_NAME  |   ASSOCIATED_TO_PROVIDER  |   ASSOCIATED_TO_ID    |
|---|---|---|---|---|---|---|
|   /subscriptions/<subscription_id>/resourceGroups/ASI-RG/providers/Microsoft.Network/publicIPAddresses/SyslogAgent-ip  |   SyslogAgent-ip  |   null    |   0   |   syslogagent126  |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/asi-rg/providers/microsoft.network/networkinterfaces/syslogagent126  |
|   /subscriptions/<subscription_id>/resourceGroups/ASI-RG/providers/Microsoft.Network/publicIPAddresses/SyslogAgent2-ip |   SyslogAgent2-ip |   null    |   0   |   SyslogAgent2-nic    |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/asi-rg/providers/microsoft.network/networkinterfaces/syslogagent2-nic    |
|   /subscriptions/<subscription_id>/resourceGroups/ASI-RG/providers/Microsoft.Network/publicIPAddresses/sentinelagent1-ip   |   sentinelagent1-ip   |   null    |   0   |   sentinelagent1-nic  |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/asi-rg/providers/microsoft.network/networkinterfaces/sentinelagent1-nic  |
|   /subscriptions/<subscription_id>/resourceGroups/Telegraf-InfluxDB-Grafana/providers/Microsoft.Network/publicIPAddresses/Telegraf-InfluxDB-Grafana-ip |   Telegraf-InfluxDB-Grafana-ip    |   104.210.56.85   |   0   |   telegraf-influxdb-gr68  |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/telegraf-influxdb-grafana/providers/microsoft.network/networkinterfaces/telegraf-influxdb-gr68   |
|   /subscriptions/<subscription_id>/resourceGroups/blxBilling/providers/Microsoft.Network/publicIPAddresses/PowerBIReports-ip   |   PowerBIReports-ip   |   null    |   0   |   powerbireports726   |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/blxbilling/providers/microsoft.network/networkinterfaces/powerbireports726   |
|   /subscriptions/<subscription_id>/resourceGroups/blxBilling/providers/Microsoft.Network/publicIPAddresses/bastionHosts    |   bastionHosts    |   192.168.17.43   |   0   |   blxBillingvnet425-bastion   |   microsoft.network/bastionhosts  |   /subscriptions/<subscription_id>/resourcegroups/blxbilling/providers/microsoft.network/bastionhosts/blxbillingvnet425-bastion    |
|   /subscriptions/<subscription_id>/resourceGroups/confluence/providers/Microsoft.Network/publicIPAddresses/confluence  |   confluence  |   192.168.17.45   |   0   |   confluence768   |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/confluence/providers/microsoft.network/networkinterfaces/confluence768   |
|   /subscriptions/<subscription_id>/resourceGroups/confluence/providers/Microsoft.Network/publicIPAddresses/confluence-app-ip   |   confluence-app-ip   |   192.168.17.4   |   0   |   confluence-app991   |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/confluence/providers/microsoft.network/networkinterfaces/confluence-app991   |
|   /subscriptions/<subscription_id>/resourceGroups/confluence/providers/Microsoft.Network/publicIPAddresses/confluence-database |   confluence-database |   null    |   0   |   confluence-database729  |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/confluence/providers/microsoft.network/networkinterfaces/confluence-database729  |
|   /subscriptions/<subscription_id>/resourceGroups/development/providers/Microsoft.Network/publicIPAddresses/Ubuntu2-ip |   Ubuntu2-ip  |   null    |   0   |   ubuntu2105  |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/development/providers/microsoft.network/networkinterfaces/ubuntu2105 |
|   /subscriptions/<subscription_id>/resourceGroups/development/providers/Microsoft.Network/publicIPAddresses/aerotest-ip    |   aerotest-ip |   null    |   0   |   aerotest635 |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/development/providers/microsoft.network/networkinterfaces/aerotest635    |
|   /subscriptions/<subscription_id>/resourceGroups/development/providers/Microsoft.Network/publicIPAddresses/blxlogtest-ip  |   blxlogtest-ip   |   null    |   0   |   blxlogtest803   |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/development/providers/microsoft.network/networkinterfaces/blxlogtest803  |
|   /subscriptions/<subscription_id>/resourceGroups/development/providers/Microsoft.Network/publicIPAddresses/buildmachine-ip    |   buildmachine-ip |   null    |   0   |   buildmachine966 |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/development/providers/microsoft.network/networkinterfaces/buildmachine966    |
|   /subscriptions/<subscription_id>/resourceGroups/development/providers/Microsoft.Network/publicIPAddresses/development-vnet-ip    |   development-vnet-ip |   192.168.17.5   |   0   |   development-vnet-bastion    |   microsoft.network/bastionhosts  |   /subscriptions/<subscription_id>/resourcegroups/development/providers/microsoft.network/bastionhosts/development-vnet-bastion    |
|   /subscriptions/<subscription_id>/resourceGroups/development/providers/Microsoft.Network/publicIPAddresses/devpubip   |   devpubip    |   192.168.17.100    |   0   |   devgateway  |   microsoft.network/virtualnetworkgateways    |   /subscriptions/<subscription_id>/resourcegroups/development/providers/microsoft.network/virtualnetworkgateways/devgateway    |
|   /subscriptions/<subscription_id>/resourceGroups/development/providers/Microsoft.Network/publicIPAddresses/homeassistant-ip   |   homeassistant-ip    |   null    |   0   |   homeassistant92 |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/development/providers/microsoft.network/networkinterfaces/homeassistant92    |
|   /subscriptions/<subscription_id>/resourceGroups/development/providers/Microsoft.Network/publicIPAddresses/mongodb-ip |   mongodb-ip  |   192.168.17.200   |   1   |       |       |       |
|   /subscriptions/<subscription_id>/resourceGroups/development/providers/Microsoft.Network/publicIPAddresses/mytestpolicyvm-ip  |   mytestpolicyvm-ip   |   null    |   0   |   mytestpolicyvm172   |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/development/providers/microsoft.network/networkinterfaces/mytestpolicyvm172  |
|   /subscriptions/<subscription_id>/resourceGroups/development/providers/Microsoft.Network/publicIPAddresses/myubuntu-ip    |   myubuntu-ip |   null    |   0   |   myubuntu718 |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/development/providers/microsoft.network/networkinterfaces/myubuntu718    |
|   /subscriptions/<subscription_id>/resourceGroups/development/providers/Microsoft.Network/publicIPAddresses/ubuntu-pip |   ubuntu-pip  |   192.168.17.201   |   0   |   ubuntu194   |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/development/providers/microsoft.network/networkinterfaces/ubuntu194  |
|   /subscriptions/<subscription_id>/resourceGroups/development/providers/Microsoft.Network/publicIPAddresses/ubuntu1704-ip  |   ubuntu1704-ip   |   null    |   0   |   ubuntu1704435   |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/development/providers/microsoft.network/networkinterfaces/ubuntu1704435  |
|   /subscriptions/<subscription_id>/resourceGroups/development/providers/Microsoft.Network/publicIPAddresses/ubuntu17102-ip |   ubuntu17102-ip  |   null    |   0   |   ubuntu17102672  |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/development/providers/microsoft.network/networkinterfaces/ubuntu17102672 |
|   /subscriptions/<subscription_id>/resourceGroups/logic_demo/providers/Microsoft.Network/publicIPAddresses/kafka-vm-ip |   kafka-vm-ip |   192.168.17.204  |   1   |       |       |       |
|   /subscriptions/<subscription_id>/resourceGroups/logic_demo/providers/Microsoft.Network/publicIPAddresses/testkafka-ip    |   testkafka-ip    |   null    |   0   |   testkafka258    |   microsoft.network/networkinterfaces |   /subscriptions/<subscription_id>/resourcegroups/logic_demo/providers/microsoft.network/networkinterfaces/testkafka258    |
