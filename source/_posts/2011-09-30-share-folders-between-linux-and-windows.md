---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Share Folders Between Linux and Windows"
date: "2011-09-30"
tags: 
  - "linux"
  - "smb"
---

I needed to share a folder between a linux machine and windows. The seceret is using Samba. Fortunately there are several guides out there that show how to do it. These are my notes:

1. Install Samba
    - Install `sudo apt-get install samba smbfs`
    - Edit Config `sudo vi /etc/samba/smb.conf
        
        # Uncomment and add new line security = user username map = /etc/samba/smbusers`
    - Add Samba user `sudo smbpasswd -a <username> sudo vi /etc/samba/smbusers
        
        # Add this line <ubuntuusername> = "<username>"`
2. Configure Shares
    
    - Edit File `sudo vi /etc/samba/smb.conf
        
        #======================= Share Definitions =======================
        
        # Un-comment the following (and tweak the other settings below to suit) # to enable the default home directory shares. This will share each # user's home directory as \serverusername [homes] comment = Home Directories browsable = yes
        
        # By default, the home directories are exported read-only. Change the # next parameter to 'no' if you want to be able to write to them. read only = no
        
        # File creation mask is set to 0700 for security reasons. If you want to # create files with group=rw permissions, set next parameter to 0775. ; create mask = 0700
        
        # Directory creation mask is set to 0700 for security reasons. If you want to # create dirs. with group=rw permissions, set next parameter to 0775. ; directory mask = 0700
        
        # By default, \serverusername shares can be connected to by anyone # with access to the samba server. Un-comment the following parameter # to make sure that only "username" can connect to \serverusername # This might need tweaking when using external authentication schemes valid users = %S
        
       `
    
3. Configure Ports
    
    - Open the following ports `netbios-ns - 137/tcp # NETBIOS Name Service netbios-dgm - 138/tcp # NETBIOS Datagram Service netbios-ssn - 139/tcp # NETBIOS session service microsoft-ds - 445/tcp # if you are using Active Directory Other ports
        
        Port 389 (TCP) - for LDAP (Active Directory Mode) Port 445 (TCP) - NetBIOS was moved to 445 after 2000 and beyond, (CIFS) Port 901 (TCP) - for SWAT service (not related to client communication)`
    

## references

1. [Nice Guide](https://help.ubuntu.com/10.04/serverguide/C/samba-fileserver.html)
2. [Install Samba](http://www.howtogeek.com/howto/ubuntu/install-samba-server-on-ubuntu/)
3. [Create Shared](http://www.howtogeek.com/howto/ubuntu/share-ubuntu-home-directories-using-samba/)
