---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Installing Ejabberd"
date: "2011-04-06"
---

I'm working on a project that needs to stand up an XMPP server. I've decided on using ejabberd for a couple of reason. Here is how I got it started

1. Download and install
    - First I Downloaded [ejabberd 2.1.6](http://www.process-one.net/en/ejabberd/downloads) 64bit version for linux.
    - I then unzipped and installed
    `$ gzip -d ejabberd-2.1.6-linux-x86_64-installer.bin.gz $ chmod +x ejabberd-2.1.6-linux-x86_64-installer.bin $ ./ejabberd-2.1.6-linux-x86_64-installer.bin`- I followed all the defaults except for where to install it. I decided on /opt/ejabberd/
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
`$/opt/ejabberd/bin/ejabberdctl live el,init,1},{gen_server,init_it,6},{proc_lib,init_p,5}]}]} {error_logger,{{2011,4,5},{16,59,46}},crash_report,[[{pid,<0.20.0>},{registered_name,net_kernel},{error_info,{exit,{error,badarg},[{gen_server,init_it,6},{proc_lib,init_p,5}]}},{initial_call,{gen,init_it,[gen_server,<0.17.0>,<0.17.0>,{local,net_kernel},net_kernel,{'ejabberd@localhost',shortnames,15000},[]]}},{ancestors,[net_sup,kernel_sup,<0.8.0>]},{messages,[]},{links,[#Port<0.6>,<0.17.0>]},{dictionary,[{longnames,false}]},{trap_exit,true},{status,running},{heap_size,610},{stack_size,23},{reductions,451}],[]]} {error_logger,{{2011,4,5},{16,59,46}},supervisor_report,[{supervisor,{local,net_sup}},{errorContext,start_error},{reason,{'EXIT',nodistribution}},{offender,[{pid,undefined},{name,net_kernel},{mfa,{net_kernel,start_link,[['ejabberd@localhost',shortnames]]}},{restart_type,permanent},{shutdown,2000},{child_type,worker}]}]} {error_logger,{{2011,4,5},{16,59,46}},supervisor_report,[{supervisor,{local,kernel_sup}},{errorContext,start_error},{reason,shutdown},{offender,[{pid,undefined},{name,net_sup},{mfa,{erl_distribution,start_link,[]}},{restart_type,permanent},{shutdown,infinity},{child_type,supervisor}]}]} {error_logger,{{2011,4,5},{16,59,46}},crash_report,[[{pid,<0.7.0>},{registered_name,[]},{error_info,{exit,{shutdown,{kernel,start,[normal,[]]}},[{application_master,init,4},{proc_lib,init_p,5}]}},{initial_call,{application_master,init,[<0.5.0>,<0.6.0>,{appl_data,kernel,[application_controller,erl_reply,auth,boot_server,code_server,disk_log_server,disk_log_sup,erl_prim_loader,error_logger,file_server_2,fixtable_server,global_group,global_name_server,heart,init,kernel_config,kernel_sup,net_kernel,net_sup,rex,user,os_server,ddll_server,erl_epmd,inet_db,pg2],undefined,{kernel,[]},[application,application_controller,application_master,application_starter,auth,code,code_aux,packages,code_server,dist_util,erl_boot_server,erl_distribution,erl_prim_loader,erl_reply,erlang,error_handler,error_logger,file,file_server,file_io_server,prim_file,global,global_group,global_search,group,heart,hipe_unified_loader,inet6_tcp,inet6_tcp_dist,inet6_udp,inet_config,inet_hosts,inet_gethost_native,inet_tcp_dist,init,kernel,kernel_config,net,net_adm,net_kernel,os,ram_file,rpc,user,user_drv,user_sup,disk_log,disk_log_1,disk_log_server,disk_log_sup,dist_ac,erl_ddll,erl_epmd,erts_debug,gen_tcp,gen_udp,gen_sctp,prim_inet,inet,inet_db,inet_dns,inet_parse,inet_res,inet_tcp,inet_udp,inet_sctp,pg2,seq_trace,wrap_log_reader,zlib,otp_ring0],[],infinity,infinity},normal]}},{ancestors,[<0.6.0>]},{messages,[{'EXIT',<0.8.0>,normal}]},{links,[<0.6.0>,<0.5.0>]},{dictionary,[]},{trap_exit,true},{status,running},{heap_size,610},{stack_size,23},{reductions,127}],[]]} {error_logger,{{2011,4,5},{16,59,46}},std_info,[{application,kernel},{exited,{shutdown,{kernel,start,[normal,[]]}}},{type,permanent}]} {"Kernel pid terminated",application_controller,"{application_start_failure,kernel,{shutdown,{kernel,start,[normal,[]]}}}"}


{% endraw  %}
