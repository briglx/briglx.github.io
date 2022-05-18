---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: ".Net Development Trees part II"
date: "2007-08-16"
tags: 
  - "net"
  - "talks"
---

I've found that taking thought in setting up your project development tree can really help with unit testing and having continuous integration for you projects. 

This is the second installment of a presentation I put on during Desert Code Camp.

## Tools

The following tools were used during the presentation and I'll go over how each one can be used with a sample project.

- NAnt
- NAntContrib
- NUnit
- NCover
- WatiN
- SVN
- TortoiseSvn
- CruiseControl.Net
- TreeSurgon

## Sample Project

Using Visual Studio 2005, I created a solution called Castor with several projects in it. The entire solution is in the nice development tree structure under the `/castor/src/` folder. Here is what the solution looks like. 
![Castor Project](/assets/images/CropperCapture%5B7%5D.png)

## First Step: Build

Once you have a solution set up you might look at the list of tools and get lost on where to start. The easiest place to begin is to set up your project to auto-build. This is simple to do with `NAnt`. We will create a file called `Castor.build` and place it in the root of the project tree structure `/castor/`. Here is the first pass to get the project to build.

```xml
<?xmlversion="1.0" ?>
<projectname="Castor"default="compile"xmlns="http://nant.sf.net/schemas/nant.xsd">
  <!-- Private Properties -->
   <propertyname="build.dir"value="build" />
   <!-- User Targets -->  
   <targetname="clean"description="Delete Automated Build artifacts">
      <deletedir="${build.dir}"if="${directory::exists(build.dir)}"/>
   </target>  
   <targetname="compile"description="Compiles using the AutomatedDebug Configuration">
      <msbuildproject="src\Castor.sln">
         <propertyname="Configuration"value="AutomatedDebug"/>
      </msbuild>     
   </target>  
</project>
```

What I did was set up a special build configuration on the castro project called AutomatedDebug. This build type will compile to project just like Debug but will output the files not to the `/bin` folder but to the `../build` folder. Then `castro.build` just kicks off this custom build type using the NAntContrib `<msbuild/>` task.

## Build Type

Setting up the AutomatedDebug configuration is pretty easy to do in Visual Studio 2005. Just click on Build -> Configuration Manager. ![Build Configure](/assets/images/CropperCapture%5B8%5D.png)]

## Go.bat

The last thing to do in order to get the project to build with a single click is create a batch file called `go.bat` and save it in the same location as the build file. The file has a single line

```bat
@tools\nant\NAnt.exe -buildfile:Castor.build %*
```

And with that, we can open up a prompt at our project root and type `go`. We should get something like the following with a nice little 'Build Successful' at the end. ![Success](/assets/images/CropperCapture%5B10%5D.png) 

That does it for this installment. Next I'll dig into adding value to our build script by including auto unit testing.
