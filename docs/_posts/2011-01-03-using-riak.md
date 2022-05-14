---
title: "Using Riak"
date: "2011-01-03"
---

I'm setting up [Riak](http://www.basho.com/developers.html#Riak) to see what it is about. I'm going to follow the [Fast Track](http://wiki.basho.com/The-Riak-Fast-Track.html) and keep track of my notes.

Change of gears. The fast track setup up a simple local three node cluster. I want to see Riak in real action on my 4 node cluster in dev. So I'm going to follow the [installation](http://wiki.basho.com/Installing-on-RHEL-and-CentOS.html) instructions.

First step is pretty simple. Run the rpm package to install \[sourcecode language="bash"\] $ sudo rpm -Uvh riak-0.13.0-2.el5.x86\_64.rpm \[/sourcecode\]

The one thing I don't like about rpm package is how the files end up all over the file system. It took me a while to find where the riak command lives. I found you can use rpm to list all the files. I still have to use my own detective work to figure out where the files are. For reference, this command will list all the file installed \[sourcecode language="bash"\] $ rpm -ql riak-0.13.0-2.el5.x86\_64 \[/sourcecode\]

So the riak command is installed to \`/etc/init.d/riak\`. Good to know.

I was able to get it installed. Now I'm going to install [the other nodes](http://wiki.basho.com/Basic-Cluster-Setup.html).

Since I want to have multiple nodes, I need to edit some files and replace the 127.0.0.1 with the ip of the machine.

- /etc/riak/app.config
- /etc/riak/vm.args

Note: The instructions say you can use the hostname, but I wasn't able to do that.

Since I started this host once before, I have to run reip to update the ring file. \[sourcecode language="bash"\] $ sudo /usr/sbin/riak-admin reip riak@127.0.0.1 riak@10.16.100.213

Attempting to restart script through sudo -u riak Backed up existing ring file to "/var/lib/riak/ring/riak\_core\_ring.default.20110103205917.BAK" New ring file written to "/var/lib/riak/ring/riak\_core\_ring.default.20110103215539" \[/sourcecode\]

### Add a Second Node to Your Cluster

I installed riak like I did for the first machine and call the join command \[sourcecode language="bash"\] $ sudo /usr/sbin/riak-admin join riak@10.16.100.213 \[/sourcecode\]

### Add Data

Now that I have the app setup I'll look at [Basic Riak API Operations](http://wiki.basho.com/Basic-Riak-API-Operations.html).
