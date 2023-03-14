---
layout: post
current: post
navigation: True
title: Update Minecraft Server
date: 2023-03-13
tags: 
  - cloud
  - azure
  - minecraft
class: post-template
subclass: 'post'
author: brig
---

It's that time of year again when I need to update the minecraft server but I forgot how.

Looks like the installed version is `minecraft_server.1.19.2.jar` and the latest is `minecraft_server.1.19.3.jar`

```bash

# Let's update the basics
sudo apt-get update

# Stop current Server
sudo systemctl stop minecraft.service

# Backup server
DATE_FORMAT="%F_%H-%M-%S"
TIMESTAMP=$(date +$DATE_FORMAT)
SERVER_WORLDS=/srv/minecraft-server/world
BACKUP_DIRECTORY=/home/brlamore/minecraft/backups
ARCHIVE_FILE_NAME="$TIMESTAMP.tar.gz"
ARCHIVE_PATH="$BACKUP_DIRECTORY/$ARCHIVE_FILE_NAME"

# Create Backup folder
mkdir -p "$(dirname "$ARCHIVE_PATH")"

# Backup world
tar -cf - "${SERVER_WORLDS[@]}" | gzip -cv -"3" - > "$ARCHIVE_PATH" 2>> /dev/null

# Check status
EXIT_CODES=("${PIPESTATUS[@]}")

# Download 1.19 jar from https://www.minecraft.net/en-us/download/server
wget https://piston-data.mojang.com/v1/objects/c9df48efed58511cdd0213c56b9013a7b5c9ac1f/server.jar

sudo mv server.jar /srv/minecraft-server/minecraft_server.1.19.3.jar
sudo mv /srv/minecraft-server/server.jar "/srv/minecraft-server/server.old.$TIMESTAMP.jar"
cp /srv/minecraft-server/minecraft_server.1.19.3.jar /srv/minecraft-server/server.jar
sudo chown -R minecraft.minecraft /srv/minecraft-server

# Restart service
sudo systemctl start minecraft.service

# Get status
systemctl status minecraft.service 

```
