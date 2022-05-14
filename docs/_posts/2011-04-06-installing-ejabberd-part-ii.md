---
title: "Installing Ejabberd - Part II"
date: "2011-04-06"
tags: 
  - "ejabberd"
  - "path"
  - "tutorial"
---

So my [first attempt](/wordpress/?p=537) at installing ejabberd ended with the app not being able to start up. I think this could be due to the fact that I was monkeying around with adding the ejabberd user and group and also the possiblity of a bad setup because `/usr/sbin` isn't in the path. So I'm going to try again on a new clean server.

1. First I made sure the `/usr/sbin` was in the path.
    - Edit `/etc/profile` to include the path 
    ```bash
    PATH=$PATH:/usr/sbin 
    export PATH
    ```
    - Edit roots `~/.bash_profile`
    ```bash    
    PATH=$PATH:/usr/sbin 
    export PATH
    ```
2. Download and install. See [first attempt](/wordpress/?p=537)
    ```bash
    sudo ./ejabberd-2.1.6-linux-x86_64-installer.bin 
    Installation Directory \[/opt/ejabberd-2.1.6\]: 
    Cluster \[y/N\]: n
    ```
3. Run
    - I'm going to to a test run with just the admin. I don't want to create an ejabberd user yet.
4. Start service
```bash
$ sudo /opt/ejabberd-2.1.6/bin/ejabberdctl start 
$ sudo /opt/ejabberd-2.1.6/bin/ejabberdctl status 
# The node ejabberd@localhost is started with status: started ejabberd 2.1.6 is running in that node
```

I don't see a crash dump so this looks good.

5. Add an account with admin privileges
    - Add user `sudo /bin/ejabberdctl register testuser ca7bf9e4b2.devols.phoenix.edu Welcome1`
    - Edit configuration `{acl, admins, {user, "admin", "ca7bf9e4b2.devols.phoenix.edu"}, {user, "brlamore", "ca7bf9e4b2.devols.phoenix.edu"}}.`
        
        Hmm. That didn't work very well for me. I keep getting the error
        
        {% raw  %}
        ```bash
        application: ejabberd
        exited: {bad_return,
                    {{ejabberd_app,start,[normal,[]]},
                        {'EXIT',
                            {{case_clause,
                                {acl,admin,
                                    {user,"admin","ca7bf9e4b2.devols.phoenix.edu"},
                                    {user,"brlamore",
                                        "ca7bf9e4b2.devols.phoenix.edu"}}},
                            [{ejabberd_config,process_term,2},
                            {ejabberd_config,load_file,1},
                            {ejabberd_config,start,0},
                            {ejabberd_app,start,2},
                            {application_master,start_it_old,4}]}}}}
        type: temporary
        ```
        {% endraw %}
        
        Let's just have one admin account
        
    - Restart
7. Connect with Client
    - Added second user
    - Opened two chat clients on two computers and added the contacts on each roster

Success!

### Next Steps

OK now I have the server up and running and can communicate between two users. I want to look into:

- Auto populate the roster for a user

### References

- [Adding Directory to PATH](http://www.troubleshooters.com/linux/prepostpath.htm)
