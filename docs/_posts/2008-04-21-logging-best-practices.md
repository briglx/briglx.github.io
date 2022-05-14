---
title: "Logging Best Practices"
date: "2008-04-21"
tags: 
  - "logging"
---

I just read a presentation from [Network Intelligence](http://www.certconf.org/presentations/2005/files/WC4.pdf) on putting together a [SIEM](http://www.acronymfinder.com/af-query.asp?Acronym=siem) solution. I really don't know that much about SIEM, but what I do know is when my application breaks, I want to know what happened and have access to the logs as quickly and easily as possible.

I've talked about [how to implement Logging](http://blog.framework-it.net/2007/07/how-to-implement-logging.html) in an application before, but this presentation sparked a few thoughts.

## Don't Filter Logs at the Source

Log all events to a single place, then use a different tool to pull down the data to sort and filter.

## Have a Reporting Time Period

Create a report that will run once a Day, once a week or whenever that shows all the events you are interested in seeing. After the report has ran, you can get rid of the data -or- you can archive it.

## Standardized Time

Use a centralized, standard Time for every log. Synchronizing time between application logs will help correlate issues between applications.

## Protect Sensitive Data

Be cautious of Sensitive information captured in the logs. Often username, machine names, and other sensitive data is captured in the event log. Provide access to the log to only those who need it.

## Analyze Data

Every application should know what events will be logged during day to day usage. Create a baseline report and look for exceptions to the expected baseline.
