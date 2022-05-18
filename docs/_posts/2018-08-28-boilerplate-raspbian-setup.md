---
title: "Boilerplate Raspbian Setup"
date: "2018-08-28"
categories: 
  - "software"
tags: 
  - "linux"
  - "pi"
  - "raspberry"
  - "raspbian"
---

I tend to flash my raspberry pies a lot. Here are the steps I follow to get to my working state.

- Flash with latest raspbian image https://www.raspberrypi.org/downloads/raspbian/
- Add an empty file named **ssh** to the boot folder
- Add an empty file called **wpa\_supplicant.conf**
- Configure the wireless by creating a file called **wpa\_supplicant.conf**

```conf
country=US
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid="your_real_wifi_ssid"
    scan_ssid=1
    psk="your_real_password"
    key_mgmt=WPA-PSK
}
```

- Ssh onto the pi with pi@hostname raspberry
- Update system and Install vim.
    ```bash
    sudo apt update && sudo apt full-upgrade -y
    sudo apt-get install vim
    ```
- Create my user on the pi
    ```bash
    sudo adduser username
    ```
- Add my user to the sudo's file.
    -  Create a new file named **020_username_nopasswd**  in `/etc/sudoers.d`
    - Edit the file as.
        ```conf
        username ALL=(ALL) NOPASSWD: ALL
        ```
- Add my certificate to `~/.ssh/authorized_keys`
    ```bash
    sudo su username
    cd ~
    mkdir .ssh
    cd .ssh
    vi authorized_keys
    cd ~
    chmod 700 ~/.ssh/
    chmod 600 ~/.ssh/authorized_keys
    ```
- Disable password authentication
    - Edit file `/etc/ssh/sshd_config`
        ```vi
        PasswordAuthentication no
        ```
    - Restart ssh server
        
        ```bash
        sudo /etc/init.d/ssh restart
        ```
- Remove User pi
    
    ```bash
    sudo deluser -remove-home pi
    ```
- Add alias to `~/.bashrc`
    
    ```bash
    alias ll='ls -al'
    ```

## References

- Setup wifi [https://www.raspberrypi.org/forums/viewtopic.php?t=191252](https://www.raspberrypi.org/forums/viewtopic.php?t=191252)
- Create new user [https://raspi.tv/2012/how-to-create-a-new-user-on-raspberry-pi](https://raspi.tv/2012/how-to-create-a-new-user-on-raspberry-pi)
- Setup keys [https://raspi.tv/2012/how-to-set-up-keys-and-disable-password-login-for-ssh-on-your-raspberry-pi](https://raspi.tv/2012/how-to-set-up-keys-and-disable-password-login-for-ssh-on-your-raspberry-pi)
- Update system [https://www.raspberrypi.org/documentation/raspbian/updating.md](https://www.raspberrypi.org/documentation/raspbian/updating.md)
- Pi setup [https://blog.jongallant.com/2017/11/raspberrypi-setup/](https://blog.jongallant.com/2017/11/raspberrypi-setup/)
