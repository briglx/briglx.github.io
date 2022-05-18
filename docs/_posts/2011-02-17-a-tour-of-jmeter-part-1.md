---
title: "A Tour of JMeter - Part 1"
date: "2011-02-17"
tags: 
  - "jmeter"
---

I recently had a task to test the performance between two different solutions. After looking around at several tools, I settled on [Apache JMeter](http://jakarta.apache.org/jmeter/). It took a while learning the tool. However, I found it to be extremely useful once I got the idea of how it worked.

This tour is broken into several sections

- [Installing and Recording](/wordpress/?p=317) (This post)
- [First Test Run](/wordpress/?p=363)
- Improving the Test Run
- Advance Techniques

### Install

You can quickly start recording web interactions in less than 10 min with the tool. Run these commands in your console.

\[code language="bash"\] $ wget http://apache.opensourceresources.org//jakarta/jmeter/binaries/jakarta-jmeter-2.4.tgz $ tar zxvf jakarta-jmeter-2.4.tgz $ cd jakarta-jmeter-2.4 $ bin/jmeter`

Bam! That fast.

### Record

When JMeter starts, there are two nodes for you to play with.

<table><tbody><tr><td><strong>Test Plan</strong></td><td>This is what is saved as your test and where all the meat goes.</td></tr><tr><td><strong>Work Bench</strong></td><td>I used this area to record browser actions</td></tr></tbody></table>

Recording is just configuring JMeter to listen to the browser and configuring the browser to send info to JMeter.

1. Add A Proxy in JMeter

- Right Click on the Workbench and select **Non-Test Element**
- Select **HTTP Proxy Server**

You can configure the Proxy Server different ways. Just stick to the defaults for now.

4. Add a Place to capture the recording

- Right Click on the Workbench and select **Logic Controller**
- Select **Recording Controller**

You should now have two elements. [![](/assets/images/Record1.png "Record1")](http://127.0.0.1:4000/imgs/uploads/2011/02/Record1.png)

7. Configure the Browser to Record

In FireFox this is done with Edit -> Preferences -> Advance -> Network -> Settings -> Manual Proxy Configuration.

9. Record Something

- Navigate to [JMeter User Manual](http://jakarta.apache.org/jmeter/usermanual/index.html)

JMeter now has your actions recorded [![](/assets/images/Record2.png "Record2")](http://127.0.0.1:4000/imgs/uploads/2011/02/Record2.png)

That's it. You have install, configured and used JMeter to record some browser actions. Next we'll go into running what was recorded.
