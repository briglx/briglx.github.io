---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Organizing Technical Information"
date: "2011-05-09"
---

I like to organize information. Mostly because I tend to forget things. Here is a template of what I find useful.

This checklist includes items that an Architect should be responsible for when creating a service.

Items include:

## General

- Team Contact List
- Calendar
- Business need

## Architecture

Captures the architecture and decision process of the service

- Overview. High level overview of the service. What is the business reason for the service
- Background
    - Expected Usage
    - SLA
    - Decision Logs
- High Level Architecture Drawings
    - Logical
    - Physical
    - Data Flow Diagrams
- Detail Architecture Drawings (Specific implementation details that are important or not obvious)
    - Authentication
    - Dependency Diagrams
- Guiding Principles

- High Availability Architecture
- Monitoring
    - Analytics
    - Site Scope
    - Cacti
    - Logs
    - Profiling

## Developer Documents

- Project Source Control
- Project Backlog
- Project Bug list

Testing

- Changelog
- Test Data
- Load Testing Results

## Service API

- Description
- Wsdl Location (version X)
- Requests (Itemize all request this service handles)
- service Name (version X)
    - Description
    - Parameters
    - Response
    - Errors
    - Sample Request
    - Sample Response
