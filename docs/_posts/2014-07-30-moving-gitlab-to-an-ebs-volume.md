---
title: "Moving GitLab to an EBS Volume"
date: "2014-07-30"
categories: 
  - "software"
tags: 
  - "bash"
  - "ec2"
  - "linux"
  - "ubuntu"
coverImage: "gitlab_logo.png"
---

 

[![gitlab-logo](http://briglamoreaux.files.wordpress.com/2014/07/gitlab-logo.png?w=300)](http://briglamoreaux.files.wordpress.com/2014/07/gitlab-logo.png)

I've really enjoyed using [GitLab](https://about.gitlab.com/) to manage my git repositories. It was really easy to get started because I used a [Bitnami GitLab image](https://bitnami.com/stack/gitlab/cloud/amazon) for Amazon. The problem is when I created the instance I chose an Instance store over EBS. I don't have a really good reason why I did but now I need to move my data to its own volume so I can restart my instance with no fear of loosing data.

1. **Check how much space you have**
    
    `$ df -h /dev/xvda1 9.9G 4.5G 4.9G 48% /`
    
    /dev/xvda1 is the root device volume. 10 GB is the default for ephemeral
    
    I'm at 50% and would like to have more room to grow. However, the real reason is I don't want to lose my data.
2. **Create and Attach an EBS Volume**
    
    You need to create the volume in the same available zone as the host computer in order to attach it.Also, take note of the device name when you attach it. We'll need this name when we mount the volume
3. **Format the Volume**
    
    First find which volume is the new one with the list block devices command
    
    `$ lsblk
    
    xvda1 202:1 0 10G 0 disk / xvdb 202:16 0 4G 0 disk /mnt xvdf 202:80 0 100G 0 disk`
    
    xvdf is the new one because it doesn't have a mount point associated with it. Format the drive:
    
    `$ sudo mkfs -t ext4 /dev/xvdf`
    
4. **Create full backup of GitLab**
    
    First stop the application using thebitnamictrl script and move to a safe location:
    
    `$ sudo /opt/bitnami/ctlscript.sh stop $ sudo mv /opt /opt2`
    
5. **Mount the volume**
    
    Although the volume has been attached, it hasn't been mounted yet. You can see this by running df again:
    
    `$ df -h. /dev/xvda1 9.9G 4.5G 4.9G 48% /`
    
    However the list block devices command can see the volume.
    
    `$ lsblk
    
    xvda1 202:1 0 10G 0 disk / xvdb 202:16 0 4G 0 disk /mnt xvdf 202:80 0 100G 0 disk`
    
    - xvda1 is mounted as the root file system.
    - xbdb is 4 GB mounted as /mnt
    
    `$ sudo mkdir /opt $ sudo mount /dev/xvdf /opt`
    
6. **Restart Gitlab**
    
    Move data over to new /opt drive and restart:
    
    `$ cp -R /opt2/bitnami /opt $ sudo /opt/bitnami/ctlscript.sh start`
    
7. **Verify the volume and data**
    
    `$df -h
    
    /dev/xvda1 9.9G 1.2G 8.3G 12% / /dev/xvdf 99G 3.6G 90G 4% /opt`
    
    I now have 3.6 GB moved from / to /opt and /opt is mounted to the /dev/xvdf volume

### References

- [Add a Volume to Your Instance](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-add-volume-to-instance.html)
- [Attaching a Amazon EBS Volume to an Instance](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-attaching-volume.html)
- [Block Device Mapping](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html)
- [BitNami GitLab](http://wiki.bitnami.com/Applications/BitNami_GitLab#How_to_start.2fstop_the_servers.3f)
