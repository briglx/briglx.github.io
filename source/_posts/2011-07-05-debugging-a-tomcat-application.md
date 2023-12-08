---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Debugging a Tomcat Application"
date: "2011-07-05"
tags:
  - "cargo"
  - "eclipse"
  - "maven"
  - "tomcat"
---

I primarily develop web applications but have been out of it for a while and needed to look at old code for a reminder. Well here is how I configure a project to debug in tomcat.

There are two parts to debugging the application

1. Configuring the Maven Cargo plug-in. (Deploys the project to Tomcat with debug args)
2. Attaching Eclipse to a remote process.

## Configure Maven Cargo

|Setting |Description|
|--------|-----------|
|`${cargo.wait}` |   Setting `cargo.wait` to true will pause tomcat once it's started so you can debug |
|`${catalina.home}` | `catalina.home` should point to the home folder of tomcat `/opt/tomcat/` |
|`${project-name}` | The name of the project and war name. |

```xml
<plugin>
    <groupId>org.codehaus.cargo</groupId>
    <artifactId>cargo-maven2-plugin</artifactId>
    <configuration>
        <wait>${cargo.wait}</wait>
        <container>
            <containerId>tomcat6x</containerId>
            <type>installed</type>
            <home>${catalina.home}</home>
        </container>
        <configuration>
            <home>target/tomcat6x</home>
            <properties>
                <!-- Debug Mode On -->
                <cargo.jvmargs>-Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,address=8787,server=y,suspend=n -Xms512m -Xmx1024m -XX:MaxPermSize=256m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC</cargo.jvmargs>
                <!-- Debug Mode Off -->
                <!--<cargo.jvmargs>-Xnoagent -Xms512m -Xmx1024m -XX:MaxPermSize=256m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC</cargo.jvmargs>-->
            </properties>
            <deployables>
                <deployable>
                    <location>target/${project-name}.war}</location>
                    <pingURL>http://localhost:8080/${project-name}</pingURL>
                    <properties>
                        <context>${project-name}</context>
                    </properties>
                </deployable>
            </deployables>
        </configuration>
    </configuration>
</plugin>
```

## Attach to Remote Process

Create a new Debug Configuration in Eclipse

- Click on Run -> Debug Configurations
- Select Remote Java Application
- Press the 'New' Button
- Give it a name like 'MyWebApp'
- Click Browse to select the Project that has the code you want to debug
- Make sure the Port matches what was configured in Cargo. In this case port 8787

## Putting it Together

To debug just do the following now:

- From the command line in the project run
```bash
mvn -Dcargo.wait=true cargo:start
```
- From eclipse select `Debug - MyWebApp`

There you go, the project can now be launched and debugged in tomcat.
