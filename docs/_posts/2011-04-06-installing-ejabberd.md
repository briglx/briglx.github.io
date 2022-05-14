---
title: "Installing Ejabberd"
date: "2011-04-06"
---

I'm working on a project that needs to stand up an XMPP server. I've decided on using ejabberd for a couple of reason. Here is how I got it started

1. Download and install
    - First I Downloaded [ejabberd 2.1.6](http://www.process-one.net/en/ejabberd/downloads) 64bit version for linux.
    - I then unziped and installed
    `$ gzip -d ejabberd-2.1.6-linux-x86\_64-installer.bin.gz $ chmod +x ejabberd-2.1.6-linux-x86\_64-installer.bin $ ./ejabberd-2.1.6-linux-x86\_64-installer.bin`- I followed all the defaults except for where to install it. I decided on /opt/ejabberd/
2. Run
    - Add new user for ejabberd to run under. Note that these commands live under /user/sbin/
    `$ useradd ejabberd $ groupadd ejabberd $ usermod -a -G ejabberd ejabberd`- Copy startup script to init.d
    `$ cp /opt/ejabberd/bin/ejabberd.init /etc/init.d/ejabberd`- Start service
    `$ /etc/init.d/ejabberd start`
3. Create Admin Account
    
    - Add the account with
    `$ ejabberdctl register admin1 example.org FgT5bk3 $ Failed RPC connection to the node ejabberd@localhost: nodedown`
    

Hmmm. I don't think I supposed to get that message. Running ejabber in live mode gives a better message. Of course I have no idea what this means. Now I did have trouble creating the user. I added then removed. So there might be issues with the user.

{% raw  %}
`$/opt/ejabberd/bin/ejabberdctl live el,init,1},{gen\_server,init\_it,6},{proc\_lib,init\_p,5}\]}\]} {error\_logger,{{2011,4,5},{16,59,46}},crash\_report,\[\[{pid,<0.20.0>},{registered\_name,net\_kernel},{error\_info,{exit,{error,badarg},\[{gen\_server,init\_it,6},{proc\_lib,init\_p,5}\]}},{initial\_call,{gen,init\_it,\[gen\_server,<0.17.0>,<0.17.0>,{local,net\_kernel},net\_kernel,{'ejabberd@localhost',shortnames,15000},\[\]\]}},{ancestors,\[net\_sup,kernel\_sup,<0.8.0>\]},{messages,\[\]},{links,\[#Port<0.6>,<0.17.0>\]},{dictionary,\[{longnames,false}\]},{trap\_exit,true},{status,running},{heap\_size,610},{stack\_size,23},{reductions,451}\],\[\]\]} {error\_logger,{{2011,4,5},{16,59,46}},supervisor\_report,\[{supervisor,{local,net\_sup}},{errorContext,start\_error},{reason,{'EXIT',nodistribution}},{offender,\[{pid,undefined},{name,net\_kernel},{mfa,{net\_kernel,start\_link,\[\['ejabberd@localhost',shortnames\]\]}},{restart\_type,permanent},{shutdown,2000},{child\_type,worker}\]}\]} {error\_logger,{{2011,4,5},{16,59,46}},supervisor\_report,\[{supervisor,{local,kernel\_sup}},{errorContext,start\_error},{reason,shutdown},{offender,\[{pid,undefined},{name,net\_sup},{mfa,{erl\_distribution,start\_link,\[\]}},{restart\_type,permanent},{shutdown,infinity},{child\_type,supervisor}\]}\]} {error\_logger,{{2011,4,5},{16,59,46}},crash\_report,\[\[{pid,<0.7.0>},{registered\_name,\[\]},{error\_info,{exit,{shutdown,{kernel,start,\[normal,\[\]\]}},\[{application\_master,init,4},{proc\_lib,init\_p,5}\]}},{initial\_call,{application\_master,init,\[<0.5.0>,<0.6.0>,{appl\_data,kernel,\[application\_controller,erl\_reply,auth,boot\_server,code\_server,disk\_log\_server,disk\_log\_sup,erl\_prim\_loader,error\_logger,file\_server\_2,fixtable\_server,global\_group,global\_name\_server,heart,init,kernel\_config,kernel\_sup,net\_kernel,net\_sup,rex,user,os\_server,ddll\_server,erl\_epmd,inet\_db,pg2\],undefined,{kernel,\[\]},\[application,application\_controller,application\_master,application\_starter,auth,code,code\_aux,packages,code\_server,dist\_util,erl\_boot\_server,erl\_distribution,erl\_prim\_loader,erl\_reply,erlang,error\_handler,error\_logger,file,file\_server,file\_io\_server,prim\_file,global,global\_group,global\_search,group,heart,hipe\_unified\_loader,inet6\_tcp,inet6\_tcp\_dist,inet6\_udp,inet\_config,inet\_hosts,inet\_gethost\_native,inet\_tcp\_dist,init,kernel,kernel\_config,net,net\_adm,net\_kernel,os,ram\_file,rpc,user,user\_drv,user\_sup,disk\_log,disk\_log\_1,disk\_log\_server,disk\_log\_sup,dist\_ac,erl\_ddll,erl\_epmd,erts\_debug,gen\_tcp,gen\_udp,gen\_sctp,prim\_inet,inet,inet\_db,inet\_dns,inet\_parse,inet\_res,inet\_tcp,inet\_udp,inet\_sctp,pg2,seq\_trace,wrap\_log\_reader,zlib,otp\_ring0\],\[\],infinity,infinity},normal\]}},{ancestors,\[<0.6.0>\]},{messages,\[{'EXIT',<0.8.0>,normal}\]},{links,\[<0.6.0>,<0.5.0>\]},{dictionary,\[\]},{trap\_exit,true},{status,running},{heap\_size,610},{stack\_size,23},{reductions,127}\],\[\]\]} {error\_logger,{{2011,4,5},{16,59,46}},std\_info,\[{application,kernel},{exited,{shutdown,{kernel,start,\[normal,\[\]\]}}},{type,permanent}\]} {"Kernel pid terminated",application\_controller,"{application\_start\_failure,kernel,{shutdown,{kernel,start,\[normal,\[\]\]}}}"}

\[/code\]

{% endraw  %}
