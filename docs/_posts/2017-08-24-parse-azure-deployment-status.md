---
title: "Parse Azure Deployment Status"
date: "2017-08-24"
categories: 
  - "software"
tags: 
  - "azure"
  - "python"
---

I've been making a lot of deployments that take a while to finish. There is an api call to fetch the status of the operations.

`azure group deployment operation list --name deploymentname --resource-group rgname`

The next step was to parse the json response.

`azure group deployment operation list --name deploymentname --resource-group rgname | python parse.py`

Here is the code [Parse Azure Deployment Response](https://gist.github.com/briglx/d2ff66737195dd810d4a3b959358ed4f)
