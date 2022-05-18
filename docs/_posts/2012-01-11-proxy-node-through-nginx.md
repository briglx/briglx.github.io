---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Proxy Node through nginx"
date: "2012-01-11"
tags:
  - "software"
  - "nginx"
  - "nodejs"
---

Once I got node service setup on my server I wasn't happy with having to specify a port. Looking around I see others use nginx to listen on port 80 and proxy everything to node.

I really don't know too much about security but read that in order to run on port 80 you need to run as root. If I run node as root, that could expose my system to hackers who could find an exploit in node and take over my system because I'm running as root. So to avoid that, run nginx in a special way to get port 80 going.

Although it seems like nginx is now exposed. If not, why can't I just run node the same way I start nginx?

Despite my own lack of understanding, having nginx in front will be useful if I want to serve up static images without having to go through node.

1. Install nginx
    
    - Follow the instruction to install [nginx](http://library.linode.com/web-servers/nginx/installation/debian-6-squeeze)
    
    </li
2. Forward request to node
    - Edit nginx config at 
    ```bash
    vi /opt/nginx/conf/nginx.conf

    worker_processes  1;
 
    error_log  /var/log/nginx/error.log notice;
    
    events {
        worker_connections  1024;
    }
    
    http {
        include       mime.types;
        default_type  application/octet-stream;
        access_log    /var/log/nginx/access.log;
        sendfile      on;
        keepalive_timeout  65;
        
        # Define the node service 
        upstream node_service {
            server 127.0.0.1:9451;
        }
    
        server {
            listen       80;
            server_name  localhost;
    
            # Proxy traffic to node service
            location / {
                # add proxy headers
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_set_header X-NginX-Proxy true;
                # Here is where node service is specified
                proxy_pass http://node_service/;
                proxy_redirect off;
            }
        }
    }
    ```

## References

- [Proxy node with nginx](http://pau.calepin.co/how-to-deploy-a-nodejs-application-with-monit-nginx-and-bouncy.html)
- [Install NGinx](http://library.linode.com/web-servers/nginx/installation/debian-6-squeeze)
- [Point nginx to node](http://stackoverflow.com/questions/6109089/how-do-i-run-node-js-on-port-80)
