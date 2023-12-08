---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Setup Password-less SSH Login"
date: "2010-12-10"
---

I hate having to login to remote machines. Since SSH can be configured with public/private keys, I think it makes sense to use them. Here is a very simple way to get my public key onto the remote server

1. Create remote user.
    - If you are going to log in with a different user, then you'll need to create a local account.
    - This command will prompt you for details about the new user. Just follow the prompts.
    - Replace `remote-user` with the name of the user you will use to connect to the remote machine.
    ```bash
    user@local:~$ sudo adduser remote-user
    ```
2. Generate an SSH key for the new remote user.
    - This setups a passwordless key.
    ```bash
    user@local:~$ su - remoteuser remoteuser@local:~$ ssh-keygen -t rsa -P ""
    ```
3. Copy public key to remote machine.
    ```bash
    remoteuser@local:~$ ssh-copy-id -i $HOME/.ssh/id_rsa.pub remoteuser@remotemachine
    ```
