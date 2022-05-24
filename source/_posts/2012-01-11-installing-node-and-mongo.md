---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Installing Node and Mongo"
date: "2012-01-11"
tags: 
  - "mongodb"
  - "nodejs"
  - "ubuntu"
---

I need to install Node and Mongo an a server. These are my notes.

1. **Create Server**
    
    - Create new Instance (ami-63be790a)
        - Ubuntu 10.04 LTS Lucid
        - EBS boot
        - Canonical
        - ubuntu@
        - 64 bit machine because that is what [mongo recommends](http://blog.mongodb.org/post/137788967/32-bit-limitations)
        - us-east-1
        - m1.Large
        
    - Linux 2.6.36 kernel
    
2. **Create Security Group**
    - Mongo Ports:
        - Standalone mongod : 27017
        - mongos : 27017
        - shard server (mongod --shardsvr) : 27018
        - config server (mongod --configsvr) : 27019
        - web stats page for mongod : add 1000 to port number (28017, by default)
    
    - Standard Ports:
        - 20 (ssh)
        - 80 (Http)
        - 443 (Https)
    
3. **Configure SSH**
    
    - Add new user
    `sudo adduser bbdiddle`- Add user to sudoers
    `sudo vi /etc/sudoers
    
    # Add this line to the sodoers file bbdiddle ALL=(ALL) NOPASSWD:ALL`- Enable ssh
    `sudo vi /etc/ssh/sshd_config
    
    # Change to yes to allow ssh PasswordAuthentication yes`- Restart ssh
    `sudo /etc/init.d/ssh restart`
    
4. **Install Mongo**
    - Download and install
    ```bash
    curl http://downloads.mongodb.org/linux/mongodb-linux-x86_64-2.0.2.tgz > mongo.tgz 
    tar -xzvf mongo.tgz 
    mv mongodb-linux-x86_64-2.0.2 /opt/mongo 
    sudo mkdir -p /mnt/db 
    sudo chown id -u /mnt/db
    ```
    - Test start server
    ```bash
    sudo ./mongodb-xxxxxxx/bin/mongod
    ```
    - Running as a Daemon
    ```bash
    ./mongod --fork --logpath /var/log/mongodb.log --logappend --dbpath /mnt/db
    ```
5. Install Node
    ```bash
    # Install dependencies
    sudo apt-get install g++ curl libssl-dev apache2-utils 
    sudo apt-get install git-core

    # Get latest code
    git clone https://github.com/joyent/node.git 
    cd node

    # Make the project 
    ./configure --prefix=/opt/node 
    make 
    sudo make install

    # Edit path variables 
    sudo vi /etc/bash.bashrc
    // Add to bottom of file export PATH=$PATH:/opt/node/bin:.

    # Verify Installation
    node --version 
    npm --version
    ```

## Notes

- [Configuring a Machine for Mongo](http://www.mongodb.org/display/DOCS/Production+Notes)
- [Installing Node](https://github.com/joyent/node/wiki/Installation)
