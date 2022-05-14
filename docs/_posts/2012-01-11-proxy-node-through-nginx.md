---
title: "Proxy Node through nginx"
date: "2012-01-11"
categories: 
  - "software"
tags: 
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
    - Edit nginx config at /opt/nginx/conf/nginx.conf
    `worker\_processes 1;
    
    error\_log /var/log/nginx/error.log notice;
    
    events { worker\_connections 1024; }
    
    http { include mime.types; default\_type application/octet-stream; access\_log /var/log/nginx/access.log; sendfile on; keepalive\_timeout 65; # Define the node service upstream node\_service { server 127.0.0.1:9451; }
    
    server { listen 80; server\_name localhost;
    
    \# Proxy traffic to node service location / { # add proxy headers proxy\_set\_header X-Real-IP $remote\_addr; proxy\_set\_header X-Forwarded-For $proxy\_add\_x\_forwarded\_for; proxy\_set\_header Host $http\_host; proxy\_set\_header X-NginX-Proxy true; # Here is where node service is specified proxy\_pass http://node\_service/; proxy\_redirect off; }`

### References

- [Proxy node with nginx](http://pau.calepin.co/how-to-deploy-a-nodejs-application-with-monit-nginx-and-bouncy.html)
- [Install NGinx](http://library.linode.com/web-servers/nginx/installation/debian-6-squeeze)
- [Point nginx to node](http://stackoverflow.com/questions/6109089/how-do-i-run-node-js-on-port-80)
