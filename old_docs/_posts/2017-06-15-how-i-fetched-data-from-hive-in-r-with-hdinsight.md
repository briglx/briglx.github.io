---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "How I fetched data from Hive in R with HDInsight"
date: "2017-06-15"
---

I have an HDInsight Spark cluster and wanted to fetch some data out of a Hive table and play around with it in R. I'm using Microsoft R. Here is how I did it.

```r
mySparkCC <- RxSpark(
    executorMem="1g", 
    driverMem="1g", 
    executorOverheadMem="1g", 
    numExecutors=2, 
    idleTimeout = 600, #3600 is the default
    persistentRun = TRUE, 
    consoleOutput=TRUE) 
rxSetComputeContext(mySparkCC) rxGetComputeContext()

sdf2 <- RxHiveData(query = "select * from hivesampletable LIMIT 100")

rxGetInfo(sdf2, getVarInfo = TRUE)
```
