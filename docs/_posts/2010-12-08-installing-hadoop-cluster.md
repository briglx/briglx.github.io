---
title: "Installing Hadoop Cluster"
date: "2010-12-08"
tags: 
  - "hadoop"
---

I have four VM machines in dev and I want to configure my own [hadoop](http://hadoop.apache.org) cluster to use as a tool and analysis. I'm going to follow the general process out lined by [hadoop's instructions](http://hadoop.apache.org/common/docs/current/cluster_setup.html) and [yahoo help](http://developer.yahoo.com/hadoop/tutorial/module7.html#config-small), [here](http://www.michael-noll.com/tutorials/running-hadoop-on-ubuntu-linux-multi-node-cluster/) and [here](http://www.cloudera.com/blog/2009/08/hadoop-default-ports-quick-reference/).

# This is what the final setup will look like

[![HadoopCluster-Dev](/assets/images/hadoopcluster-dev2.png)](http://briglamoreaux.files.wordpress.com/2010/12/hadoopcluster-dev2.png)

# Prework

I found that hadoop has [default ports](http://www.cloudera.com/blog/2009/08/hadoop-default-ports-quick-reference/) that need to be opened between servers before it will work.

1. Added local ssh support on each machine

\[sourcecode language="bash"\] $ ssh-keygen -t dsa -P '' -f ~/.ssh/id\_dsa $ cat ~/.ssh/id\_dsa.pub &amp;gt;&amp;gt; ~/.ssh/authorized\_keys \[/sourcecode\]

1. Configured master to talk to each slave.

\[sourcecode language="bash"\] a.brlamore@master:~$ ssh-copy-id -i $HOME/.ssh/id\_rsa.pub a.brlamore@slave \[/sourcecode\]

1. Configured each slave to talk to the master.

\[sourcecode language="bash"\] a.brlamore@slave:~$ ssh-copy-id -i $HOME/.ssh/id\_rsa.pub a.brlamore@master \[/sourcecode\]

# Important Directories

| Directory | Description | Suggested location |
| --- | --- | --- |
| HADOOP\_LOG\_DIR | Output location for log files from daemons | /var/log/hadoop |
| hadoop.tmp.dir | A base for other temporary directories | /tmp/hadoop |
| dfs.name.dir | Where the NameNode metadata should be stored | /home/hadoop/dfs/name |
| dfs.data.dir | Where DataNodes store their blocks | /home/hadoop/dfs/data |
| mapred.system.dir | The in-HDFS path to shared MapReduce system files | /hadoop/mapred/system |

Configuration

1. **Hadoop Home**
    - HADOOP\_HOME is set to /u01/accts/a.brlamore/tmp/hadoop-0.21.0
    - I've put in a request for root access so I can change this to /opt/hadoop
2. **Edit Slaves file**
    
    - Edit slave file /conf/slaves
    
    \[sourcecode language="bash"\] ali-graph002.devapollogrp.edu ali-graph003.devapollogrp.edu ali-graph004.devapollogrp.edu \[/sourcecode\]
3. ****Site Configuration****
4. Set the JAVA\_HOME in conf/hadoop-env.sh to export JAVA\_HOME=/usr/java/default
5. Set values in conf/core-site.xml
6. \[sourcecode language="xml"\] <configuration> <property> hadoop.tmp.dir /u01/accts/a.brlamore/tmp/hadoop-datastore/hadoop-${user.name} A base for other temporary directories. Default location /tmp/hadoop-${user.name}. Suggested Location /tmp/hadoop </property> <property> <name>fs.default.name</name> hdfs://ali-graph001.devapollogrp.edu:8020 <description>The name of the default file system. This specifies the NameNode</description> </property> </configuration> \[/sourcecode\]
    
7. Set values in conf/hdfs-site.xml
8. \[sourcecode language="xml"\] <configuration> <!-- <property> dfs.name.dir /u01/accts/a.brlamore/tmp/path/to/namenode/namesapce/ Where the NameNode metadata should be stored. Default location is ${hadoop.tmp.dir}/dfs/name. Suggested location /home/hadoop/dfs/name </property> <property> <name>dfs.data.dir</name> /u01/accts/a.brlamore/tmp/path/to/datanode/namesapce/ <description>Where DataNodes store their blocks. Default location ${hadoop.tmp.dir}/dfs/data. Suggested location /home/hadoop/dfs/data</description> </property> --> </configuration> \[/sourcecode\]
    
9. Set values in conf/mapred-site.xml
10. \[sourcecode language="xml"\] <configuration> <property> <name>mapreduce.jobtracker.address</name> <value>ali-graph001.devapollogrp.edu:8021</value> <description>Host or IP and port of JobTracker</description> </property> </configuration> \[/sourcecode\]
11. Hadoop Startup
    - Format the filesystem

\[sourcecode language="bash"\] $ bin/hadoop namenode -format \[/sourcecode\]

- Start the HDFS on the NameNode

\[sourcecode language="bash"\] bin/start-dfs.sh \[/sourcecode\]

- Start Map-Reduce on the TrackerNode

\[sourcecode language="bash"\] $ bin/start-mapred.sh \[/sourcecode\]
