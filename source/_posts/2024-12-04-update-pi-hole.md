---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Update Pi-hole"
date: "2024-12-04"
tags:
  - "networking"
---

I just noticed that my Pi-hole was out of date. I had to update it. Here's how I did it.

```bash
ssh $PIHOLE

SSH is enabled and the default password for the 'pi' user has not been changed.
This is a security risk - please login as the 'pi' user and type 'passwd' to set a new password.
```

I logged in as the `pi` user and changed the password.

```bash
ssh pi@$PIHOLE
passwd
```

## Update Pi-hole

```bash
# back up the current configuration
pihole -a -c

# update the Pi-hole
pihole -up
Error: Unable to update package cache. Please try "sudo apt update"

sudo apt update
pihole -up
Unsupported OS detected: Raspbian 10

cat /etc/os-release
PRETTY_NAME="Raspbian GNU/Linux 10 (buster)"
NAME="Raspbian GNU/Linux"
VERSION_ID="10"
VERSION="10 (buster)"
VERSION_CODENAME=buster
ID=raspbian
ID_LIKE=debian
HOME_URL="http://www.raspbian.org/"
SUPPORT_URL="http://www.raspbian.org/RaspbianForums"
BUG_REPORT_URL="http://www.raspbian.org/RaspbianBugs"

sudo PIHOLE_SKIP_OS_CHECK=true pihole -r

# Select Repair installation
```
