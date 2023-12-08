---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Load Testing with AWS"
date: "2012-08-21"
tags:
  - "software"
  - "aws"
  - "bash"
  - "ec2"
  - "javascript"
  - "mongodb"
---

Spinning up servers on Amazon has been such a great way to test software. I recently did a performance test of [MongoDB](http://www.mongodb.org/ "MongoDB") and put together a process and a few scripts that helped me load test a server with 128 clients. Here is the approach I used:

- Stand Up Server
- Create Client Image
- Load Test Script
- Utility Scripts

## Stand Up Server

The first step was to setup and configure a MongoDB instance on a machine designated as the server. All of the clients will hit this server. This is the machine that I wanted to monitor for performance. For my test, I looked at the cpu load, memory usage, interrupts/sec, and CS/sec. My goal was to discover Mongo's performance in Amazon.

## Create Client Image

Creating an image of the client helps to spin up additional clients fast. With one image, I could create up to 128 client at one time. I could even change the size of the client from a small machine to a large one, not that it would matter much. The most important thing I could do was spin up my clients in different availability zones and even regions. Although moving to a different region required me to create a new AIM because AIM's can't be transferred between regions like east or west.

My client started with an Ubuntu image [which I like]({% post_url 2011-05-12-the-cloud-is-cool %} "The Cloud is Cool"). I [configured Mongo]({% post_url 2012-01-11-installing-node-and-mongo %} "Installing Node and Mongo") and copied the my JavaScript load script to the machine. I finally created a small script to start the client with the test script

```bash
# mymongoserver = 192.168.0.1
mongo 192.168.0.1/courses --quiet loadTest.js > results.csv
```

## Load Test Script

The load test is a simple JavaScript file that randomly selects an id from an array of two thousand possibilities. It then queried Mongo for a resource with the id. Very simple. The best part was learning that I could start the Mongo client with a JavaScript file. Every second the script writes out information on the response time like: current, running average, min, and max.

```js
db = db.getSiblingDB('courses');

var profileIds =  [ "1000045137", "and", "two", "thousand", "more" ];
var rnd, max, start, curId, item, diff, interval, t, aveLatency, j, delStart;

j =1;
aveLatency =0;
minLatency=1000;
maxLatency=0;
max = profileIds.length;
max = 10000;
interval = max / 20;
delStart = (new Date).getTime();

print('Latency, Running-Ave, Min, Max');

for(i=1;i<=max;i++) {
  rnd=Math.floor(Math.random()*profileIds.length);
  curId = profileIds[rnd];
  // Capture Response time
  start = (new Date).getTime();
  item = db.CourseOfferiningMemberships.findOne({"profile.id":curId});
  diff = (new Date).getTime() - start;
  // Calculate Latency in ms
  // Display Sample Data every second
  if((start - delStart) >= 1000) {

    if(diff < minLatency){
      minLatency = diff;
    }
    if(diff > maxLatency){
      maxLatency = diff;
    }

    // Calc moving average
    aveLatency = cumAverage(diff, aveLatency, j);
    j++;

    print(diff + ', ' + aveLatency.toFixed(2) + ', ' + minLatency + ', ' + maxLatency);
    delStart = (new Date).getTime();
  }
}
```

## Utility Scripts

There were two utility scripts I created. The first was a general administration of the [AWS](http://en.wikipedia.org/wiki/Amazon_Web_Services "Amazon Web Services") instances. This had my AWS credentials and would loop over each of the instances that were based off my Client Image. Some of the things I would do is:

- Start clients in increments of 1,2,4,8,16 etc.
- Get the domain name of the instances
- Terminate instances.

```python
from boto.ec2 import connect_to_region
from boto.ec2.connection import EC2Connection

#conn = connect_to_region('us-west-1', aws_access_key_id='MY_ACCESS_KEY_ID', aws_secret_access_key='MY_SECRET_KEY')
conn = connect_to_region('us-east-1', aws_access_key_id='MY_ACCESS_KEY_ID', aws_secret_access_key='MY_SECRET_KEY')

instances = []

for r in conn.get_all_instances():
  instances.extend(r.instances)

for item in instances:
  if(item.state == 'running'  and ("Mongo-Client" in item.tags.get("Name"))):
    print '%s\t%s' % (item.tags.get("Name"), item.public_dns_name)
    item.terminate()
```

The second script is my remote control script. This script allows me to:

- start the load script
- quickly ssh
- update the script
- clear results
- get results

```bash
#!/bin/bash

if [ -z $1 ]; then
    echo "Usage: $0 <command></command>"
    exit 1
fi

servers=(myserver1.compute-1.amazonaws.com
myserver2.compute-1.amazonaws.com
...
)

# Example commands
# loadtest start 4
# loadtest start 8
# loadtest copy 4 /path/to/file

case "$1" in
    ssh)
        if [ -z $2 ]; then
            echo "Usage: $0 ssh "
            exit 1
        fi

        echo "Quick login to $servers[$2]"
        ssh -o StrictHostKeyChecking=no ${servers[$2]}
        ;;
    updateKey)

        echo "Update Key"
        for s in ${servers[@]};do
            printf "Updating ${s}...\n"
            cat ~/.ssh/id_rsa.pub | ssh -o StrictHostKeyChecking=no  ${s} 'cat >> .ssh/authorized_keys'
        done
        printf " Done\n"
        ;;
    updateScript)

        echo "Updating Script"
        for s in ${servers[@]};do
            printf "Copying to ${s}...\n"
            cat ./mongoScripts/loadTest.js | ssh -o StrictHostKeyChecking=no ${s} 'cat > /tmp/loadTest.js' &
        done
        wait
        echo "Done"
        ;;
    exec)
        # execute  statement

        echo "Executing command"
        for s in ${servers[@]};do
            printf "Executing on ${s}...\n"
            ssh -o StrictHostKeyChecking=no ${s} 'ls'
        done
        echo "Done"
        ;;

    start)
        if [ -z $2 ]; then
            echo "Usage: $0 start "
            exit 1
        fi
        #    /path/to/mongo IP_TO_MONGO/courses --quiet /tmp/loadTestSamll.js > results.csv
        i=0
        while [ $i -lt $2 ];do
            printf "Starting Script on ${servers[$i]}...\n"
            ssh -o StrictHostKeyChecking=no ${servers[$i]} ':>/tmp/results.csv;/opt/mongo-latest/bin/mongo IP_TO_MONGO/courses --quiet /tmp/loadTest.js > /tmp/results.csv' &
            #ssh ${servers[$i]} 'mongo-latest/bin/; ls' &

            let i=i+1
        done
        wait
        echo "Done"
        ;;
    clear-results)
        if [ -z $2 ]; then
            echo "Usage: $0 results "
            exit 1
        fi
        i=0
        while [ $i -lt $2 ];do
            printf "Clearing results on ${servers[$i]}..."
            ssh ${servers[$i]} 'rm /tmp/results.csv'
            let i=i+1
            printf "Done"
        done
        ;;
    results)
        if [ -z $2 ]; then
            echo "Usage: $0 results "
            exit 1
        fi
        i=0
        while [ $i -lt $2 ];do
            echo "Fetching results on ${servers[$i]}..."
            ssh ${servers[$i]} 'tail -n 1 /tmp/results.csv' &
            let i=i+1
        done
        wait
        printf "Done"
        ;;
    *)
        echo $"Usage: $0 {ssh|updateKey|updateScript|start|results}"
        exit 1
esac
exit 0
```

## Results

It took me a while to build these scripts and find how to remotely control the Mongo clients. This may not be the most effective way to perform a load test on Mongo, but it is a way that worked very well for me. At one point, I was able to run the test on 128 clients and get the results in less than two minutes. Please let me know if there are better tools to do this, I'm sure there are.
