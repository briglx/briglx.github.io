---
title: "Getting Started with Cacti"
date: "2011-03-11"
tags: 
  - "cacti"
---

I'm going to try this again. I've tried to install Cacti once before and had difficulty. Hopefully I can be more successful. I don't know much about PHP so hopefully that won't matter.

These steps are a mix of my adventure and my attempt to document how to setup cacti on Oracle Enterprise Linux 5.5

1. **Install Required Packages**
    - Run the commands\[code source="bash"\] $ sudo yum install $ sudo yum install httpd $ sudo yum install php $ sudo yum install php-mysql $ sudo yum install php-snmp $ sudo yum install mysql $ sudo yum install mysql-server $ sudo yum install net-snmp $ sudo yum install net-snmp-utils`
2. **Verify that httpd and mysqld**
    - httpd and mysqld are configured for auto startup by default
3. **Configure PHP**
    - Verify modules are loaded
    `$ php -m`- Trouble. When I run the command, I get a list of errors like the following for (dbase.so, gd.so, ldap.so, mysql.so, mysqli.so, pdo.so, pdo\_mysql.so, pdo\_sqlite.so, snmp.so)
    `PHP Startup: Unable to load dynamic library '/etc/php.d/msql.so' - /etc/php.d/msql.so: cannot open shared object file: No such file or directory in Unknown on line 0`- It's looking for the file /etc/php.d/msql.so but that file lives in /usr/lib64/php/modules/
    - Point where the modules are and rstart apache
        - Modified /etc/php.ini. Changed the line to `extension\_dir = "/usr/lib64/php/modules"`
        - Restart apache
        `$ /usr/sbin/apachectl stop $ /usr/sbin/apachectl start`
    - More errors. I'm still getting the errors `PHP Warning: PHP Startup: Unable to load dynamic library '/usr/lib64/php/modules/msql.so' - /usr/lib64/php/modules/msql.so: cannot open shared object file: No such file or directory in Unknown on line 0 PHP Warning: Module 'snmp' already loaded in Unknown on line 0`
    - Let's look in php.ini. `$ grep ^#\*ex /etc/php.ini expose\_php = On #extension\_dir = "/etc/php.d" extension\_dir = "/usr/lib64/php/modules" extension=msql.so extension=snmp.so`
    - I see where I changed the extension\_dir. But I also see two explicit extensions. One for msql and snmp. Hmm those match my errors. I wonder if that could be the issue. I'm going to comment them out.
    - That got rid of the errors.
    - At this point running the command `php -m` shows all the modules are loaded. I'm not too sure if PHP is configured properly though :(
4. **Configure Apache**
    - Looks like it was already configured
5. **Configure MySql**
    - Set Admin Password and Create Cacti Schema. (Replace MY\_PASSWORD with whatever password you want) `mysqladmin --user=root password MY\_PASSWORD mysqladmin --user=root --password reload mysqladmin --user=root --password=MY\_PASSWORD create cacti`
6. **Install Cacti**
    - Create new user `useradd cactiuser groupadd cacti usermod -a -G cacti cactiuser`
    - Setup Folder Structure `mkdir /opt/cacti cd /opt/cacti wget http://www.cacti.net/downloads/cacti-0.8.7g.tar.gz tar xzvf cacti-0.8.7g.tar.gz ln -s /opt/cacti/current/ /opt/cacti/cacti-0.8.7g chomod cactiuser:cacti -R /opt/cacti`
7. **Verify Cacti Installation**
    - Navigating to http://hostname/cacti/ gave 404
    - Need to made a symbolic link `ln -s /var/www/html/cacti /opt/cacti/current`
    - Now when I navigate to http://hostname/cacti/ I get the following error: `FATAL: Cannot connect to MySQL server on 'localhost'. Please make sure you have specified a valid MySQL database name in 'include/config.php'`
    - Looking at the file, I put the password in wrong. But I now see the Cacti Installation Screen. I'm so happy.
8. **Cacti Web Installation Wizard**
    - I clicked next
    - Selected New installation
    - The next screen has a lot of invalid file paths. Really?
        - invalid path: rrdtool
        - invalid path: snmpwalk
        - invalid path: snmpget
        - invalid path: snmpbulkwalk
        - invalid path: snmpgetnext
    - Install rddtools `sudo yum install cairo-devel libxml2-devel pango-devel pango libpng-devel freetype freetype-devel libart\_lgpl-devel cd /opt sudo wget http://oss.oetiker.ch/rrdtool/pub/rrdtool-1.4.5.tar.gz sudo tar -zxvf rrdtool-1.4.5.tar.gz cd rrdtool-1.4.5 # export PKG\_CONFIG\_PATH=/usr/lib/pkgconfig/ ./configure --prefix=/usr/local/rrdtool sudo make sudo make install cp /opt/rrdtool-1.4.5/bin/\* /usr/local/bin/`
    - Install snmpwalk
        - After looking around I need to install net-snmp-utils. I added this to the initial installation items above. Lame.
    
9. **Done!** [![](/assets/images/Cacti.png "Cacti")](http://127.0.0.1:4000/imgs/uploads/2011/03/Cacti.png)

I'll configure cacti in another post. This was too much to get it installed.

### Extra

1. Install MySql Workbench
    
    - Download code `sudo dpkg -i mysql-workbench-gpl-5.2.32-1ubu1010-i386.deb`
    - It said I had missing references. libzip1 and python-pysqlite2 So I ran `apt-get -f install`
    - I ran the deb again with no errors
    - Mysql workbench is now in the Menu Items
    - When I attempt to connect though I'm told my desktop isn't allowed to connect. Oh well, save for a future post.

### Notes

The commands for link service and chkconfig live in /sbin directory.

Prepare first by creating service accounts for cacti

### Resources

[MySql Admin Tool](http://dev.mysql.com/downloads/mirror.php?id=401623#mirrors) [Install Cacti on Linux (Not too helpful)](http://www.cacti.net/downloads/docs/html/install_unix.html) [Installing MySQL and getting running](http://dev.mysql.com/doc/refman/5.5/en/linux-installation-native.html) [Add a user to group](http://www.cyberciti.biz/faq/howto-linux-add-user-to-group/) [Add user and groups](http://www.yolinux.com/TUTORIALS/LinuxTutorialManagingGroups.html) [Install rrdtool on Red Hat](http://www.cyberciti.biz/faq/howto-install-rrdtool-on-rhel-linux/)
