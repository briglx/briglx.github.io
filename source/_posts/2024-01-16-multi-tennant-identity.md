---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Multi-tennant Identity"
date: "2024-01-16"
tags:
  - "cloud"
  - "identity"
---

I've been working on a problem with identity for a multi-tennant application offered by a provider. There are a few specific requirements:

* The Provider has multiple multi-tennant SaaS offerings
* The provider needs to invite a primortial user into an offering
* The primortial user can invite other users
* The primortial user can setup federation with an external identity provider
* Users should be able to log into this application and any other SaaS application offered by the provider.

I struggle with all things Identity so I need a working example to ground myself as I try to solve the problem. So here is the Example:

## Use Case for Company Contoso

* The primordial user `admin@contoso.com` initiates the `create a new account` process for one of the multi-tenant SaaS offerings offerd by the provider `litware.com`.
* If the user doesn't have a way to log into the provider's setup process they can create a new account.
* This new account will be stored in `live.com` as a Microsoft Account with a a record like `admin_contoso_com#EXT#@live.com`.
* The user then creates a New Tenant called `constoso` and this will map to the multi-tenant naming of the provider to `contoso.onlitware.com`
* The user creates a new local user. There are now two users that have access in the `contoso.onlitware.com` directory
    * `admin_contoso_com#EXT#@live.com` 
    * `admin@contoso.onlitware.com`
* The user Configure the Domain `contoso.com` to point to `contoso.onlitware.com`
* The user creates new user in tenant for the domain `contoso.com` called `admin@contoso.com`
* There are now three users in the `contoso.onlitware.com` tenant
  * `admin_contoso_com#EXT#@live.com` 
  * `admin@contoso.onlitware.com`
  * `admin@contoso.com`

One of the key things to understand is that the user `admin@contoso.com` potentially has two differenty ways to log into the tenant:
* One through the `live.com` account
* One through the `contoso.com` domain

If the `admin@contoso.com` were deleted from the `contoso.onlitware.com` tenant then the user would still be able to log in through the `live.com` account.  This is because the `live.com` account is a Microsoft Account and not a local account in the `contoso.onlitware.com` tenant.

So be sure to configure auditing of what accounts have access to the tenant.  This is a good security practice.

## Potential Architecture

I have a project where I created a POC for a similar problem here [https://github.com/briglx/python-b2c-app](Multi-tenant SaaS).

![Multtenant SaaS]({{ site.url }}{{ site.baseurl }}/assets/images/220240116-multitenant-identity-architecture.png)

This application is hosted in the provider's tenant, but he identities are stored in an Azure AD B2C directory. This directory is then setup to federate with the customer's Azure AD tenant.  This allows the customer to manage the identities in their own tenant.

A provider could use this model to allow customers to onboard easily, setup federation, and manage their own identities.  

A second Multi-tenant SaaS application could use the same Azure AD B2C directory.  This would allow the customer to use the same identities in both applications.