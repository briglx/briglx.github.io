---
layout: post
current: post
navigation: True
title: Minecraft Server
date: 2022-07-31
tags: 
  - cloud
  - azure
  - minecraft
class: post-template
subclass: 'post'
author: brig
---

Setting up minecraft on azure for fun.

Setup Server

```bash

# Create linux server
# tbd script
# ssh server ip

# Install Java
sudo apt update && sudo apt upgrade -y
sudo apt-get install openjdk-16-jre-headless

# Setup User and dir
sudo adduser --system --home /srv/minecraft-server minecraft
sudo addgroup --system minecraft
sudo adduser minecraft minecraft # this adds user "minecraft" to the group "minecraft"
sudo chown -R minecraft.minecraft /srv/minecraft-server

# Switch to user
sudo -H -u minecraft bash
cd /srv/minecraft-server

# Download 1.19 jar from https://www.minecraft.net/en-us/download/server
#  wget https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar
# mv server.jar minecraft_server.1.19.jar


# Create startup script
sudo vi /etc/systemd/system/minecraft.service
sudo chmod 664 /etc/systemd/system/minecraft.service

[Unit] 
Description=start and stop the minecraft-server 

[Service]
WorkingDirectory=/srv/minecraft-server
User=minecraft
Group=minecraft

ExecStart=/usr/bin/java -Xms10G -Xmx10G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar server.jar nogui

Restart=on-failure
RestartSec=20 5

StandardInput=null

[Install]
WantedBy=multi-user.target

# ...
# Enable service
sudo systemctl enable minecraft.service

# Start service
sudo systemctl start minecraft.service

# Get status
systemctl status minecraft.service 


```


# References
- https://minecraft.fandom.com/wiki/Tutorials/Setting_up_a_server
- Startup scripts https://gist.github.com/dotStart/ea0455714a0942474635