---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "The Cloud is Cool"
date: "2011-05-12"
tags:
  - "ec2"
  - "wordpress"
---

I've known about Amazon EC2 service for a while. I've really been interested in trying something out when I heard about AWS's Free Usage Tier. I could get a server in the cloud free for an entire year. Wow. How can I resist? So today I thought I would try to do something.

I thought I would move my blog to amazon. I found a [great guide](http://cykod.com/blog/post/2010-09-blogging-in-the-cloud-scaling-wordpress3) that I more or less followed. The only places where I deviated were due to me using a single micro instance and the bitnami AMI. But wait, what is a micro instance and an AMI. These were some of the many terms I learned today.

## Basic Concepts

- VM hosted remotely on Amazon servers
- Access to more storage like S3
- Ability to pick server profile (Small, medium, large)
- ect.

## New Concepts

AMI Amazon Machine Image.

Preconfigured images that not only include what one the machine but also the size, location, and a lot more. From Amazon: An Amazon Machine Image (AMI) is a special type of pre-configured operating system and virtual application software which is used to create a virtual machine within the Amazon Elastic Compute Cloud (EC2). It serves as the basic unit of deployment for services delivered using EC2.

AMI Market Place

The [Cloud Market](http://thecloudmarket.com/) parses all the AMI that have been [published at Amazon](http://aws.amazon.com/amis). There is an entire market place where you can find preconfigured AMI ready to go. [Alestic](http://alestic.com/) is another good place to fine AMIs.

Configure Firewall

It makes sense, you have to open ports when you configure a vm. The walk through made this pretty easy.

EBS instance

Amazon Elastic Block Store. Volume that is off-instance storage that persists independently from the life of an instance. When you stop your instance, the basic storage is deleted. But if you use EBS storage, it will stick around until you start your instance again.

Dynamic IP

Each time I restart my instance, I get a new ip and new dns. I could setup an Elastic IP that would be static for me and assign it to my image. That way whenever I restart my instance I'll have the same ip

Very cool. In about an hour I was able to get an instance up, create a mysql database, and install wordpress in the cloud. Now I'll look into how to migrate data from one wordpress to another.
