---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "How to Implement logging"
date: "2007-07-18"
tags:
  - "net"
  - "logging"
---

We are getting ready to send our first child off to kindergarten and I wish I could be a fly on the wall to see how he enjoys his first day of school. Secretly I want to make sure he remembers the one-two punch I taught him in case someone tries to bully him around. Fortunately at work I have much more control over keeping track of my applications once I send them into production. The secret is Logging.

Our team has used three major logging implementations. Log4Net, Enterprise Library, and a homegrown solution. What we have discovered is the importance of making the implementation transparent to our application.

## The Logging Wrapper

The wrapper class minimizes the impact to your application when you switch out a logging implementation say from `Log4Net` to Enterprise Library Logging. I have found the following interface to completely accommodate our needs.

```cs
public interface ILogger
{
    void LogInformational(string message);
    void LogWarning(string message);
    void LogWarning(Exception ex);
    void LogError(Exception ex);
}
```

I use three categories for the messages specifically so I can turn on and off logging by setting a threshold level.

**Informational**

These messages will be used liberally throughout the code to provide process detailed information similar to debug traces.

**Warning**

Warnings are events the application can recover from. These include messages that provide more detail when the application responds to the user "Unable to save record". Warnings also include all exceptions that are handled in a try catch block.

**Errors**

Errors are exceptions that are logged from the global error handler.These are errors that the application did not expect.

## The Implementation

We use Enterprise Library for .NET Framework 1.1, June 2005 in our projects. We are still evaluating Enterprise Library 3.0 – April 2007 (for .NET Framework 2.0 and 3.0). In the meanwhile this is how I configured EntLib.

First I include the following dlls

- Microsoft.Practices.EnterpriseLibrary.Common
- Microsoft.Practices.EnterpriseLibrary.Configuration
- Microsoft.Practices.EnterpriseLibrary.ExceptionHandling
- Microsoft.Practices.EnterpriseLibrary.ExceptionHandling.Logging
- Microsoft.Practices.EnterpriseLibrary.Logging

Then I create a class that implements `ILogger` and use `EntLib` to get the job done.

```cs
using System;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;
public class EntLib11Logger : ILogger
{
    public void LogInformation(string message)
    {
        Logger.Write(message, "Information", 1);
    }
    public void LogWarning(string message)
    {
        Logger.Write(message, "Warning", 5, 1, Severity.Warning);
    }
    public void LogWarning(Exception ex)
    {
        ExceptionPolicy.HandleException(ex, "Warning");
    }
    public void LogError(Exception ex)
    {
        ExceptionPolicy.HandleException(ex, "Error");
    }
}
```

Notice how both the Enterprise Library Logging and Exception Handling is used to provide functionality for our `ILogger`. With the Logging Block, I have to specify in the code the Priority level and Severity level. The Exception Handling Block allows those values to be set in the configuration file, which is what needs to be configure now.

## Configuration

Configuration of Enterprise Library can be a little confusing but lets just go one section at a time.

The first thing we'll want to setup is the logging aspect. This makes the Exception Handling configuration a lot easier. Start up the EntLibConfig.exe tool and select File - Open Application and select the `app.config` file for the project.

**Logging Configuration**

Select your app node and choose to add the Logging and Instrumentation Application Block.

![AddBlock]({{ site.url }}{{ site.baseurl }}/assets/images/addblock.png)

The tool allows you to define categories, formatters, and sinks. Sinks are the final resting place for our messages. Sinks can be a flat file or an event log. Formatter are used to turn our message object into a plain text message. The category is where you define what happens to our message object when it is caught.

I modify the Sinks section to have one sink for the Application Event Log.

![SinkSetup]({{ site.url }}{{ site.baseurl }}/assets/images/sinksetup.png)

Modify the categories section to have the three categories defined during the implementation step

- Information
- Warning
- Error

Notice how each category has a single destination. The destination tells Enterprise library to use the default Text Formatter and send it to the Application Event Log Sink.

![LoggingCategory]({{ site.url }}{{ site.baseurl }}/assets/images/loggingcategory.png)

One last step in logging is to set up a default category. I like to set mine to default to Error.

![DefaultCategory]({{ site.url }}{{ site.baseurl }}/assets/images/defaultcategory.png)

At this point your application should be able to use LogInformational(string message) and LogWarning(string message)with no problems. Setting up the exception handling will take care of the rest.

**Exception Handling Configuration**

Select your app node and choose to add the Exception Handling Application Block. Select the application block and add a new Exception Policy with the name Error. Add a new Exception Type to the policy that catches all Exceptions. Finally add a new Logging Handler.

![ErrorExceptionPolicy]({{ site.url }}{{ site.baseurl }}/assets/images/errorexceptionpolicy.png)

The configuration I use for the Logging Handler of the Error Exception Policy is:

<table width="355" border="1" cellspacing="0" cellpadding="2"><tbody><tr><td valign="top" width="198">LogCategory</td><td valign="top" width="155">Error</td></tr><tr><td valign="top" width="198">Priority</td><td valign="top" width="155">10</td></tr><tr><td valign="top" width="198">Severity</td><td valign="top" width="158">Error</td></tr></tbody></table>

The Warning exception policy is exactly like the Error but with the following values for the Logging Handler:

<table width="400" border="1" cellspacing="0" cellpadding="2"><tbody><tr><td valign="top" width="200">LogCategory</td><td valign="top" width="198">Warning</td></tr><tr><td valign="top" width="200">Priority</td><td valign="top" width="198">5</td></tr><tr><td valign="top" width="200">Severity</td><td valign="top" width="198">Warning</td></tr></tbody></table>

![WarningExceptionPolicy]({{ site.url }}{{ site.baseurl }}/assets/images/warningexceptionpolicy.png)

With both exception policies setup and using the logging our ILogging class is fully functional. Now it is a simple configuration setting to turn on and off the different logging levels.

Any value larger than the MinimumPriority will be logged. Anything less will not be logged, simple. The values of the categories are: Error-10, Warning-5, and Information-1. I like to set the MinimumPriority to 10 in production.

![MinimumPriority]({{ site.url }}{{ site.baseurl }}/assets/images/minimumpriority.png)

## Wrap Up

So far this method of logging has been very useful. There is a lot more you can do from here such as sending emails when a warning happens. I've only laid the foundation of a logging methodology.

In the future I plan to evaluate how the Enterprise Library 3.0 – April 2007 version handles logging and create an implementation for ILogger. Other things I've thought about is to create some sort of LoggingFactory or ServiceProvider to really disconnect my application from the implementation. Ideally I don't want to have any referenced dlls in my apps.

Tell me what your experience has been with logging. What works well for you, what doesn't. Do you see yourself using the ILogger interface. Please let me know because I would love to improve on what I have.
