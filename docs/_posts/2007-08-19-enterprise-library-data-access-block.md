---
title: "Enterprise Library - Data Access Block"
date: "2007-08-19"
tags: 
  - "net"
---

The [Enterprise Library](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnpag2/html/entlib2.asp) from Microsoft is a great framework to quickly get started with coding. I've been using the Data Access Blocks for a while now and love them. What I've notice though is I don't really have a document that will quickly get me started. That's what this post is for. Here are the steps to get up and running with the Data Access block.  
  
This first thing is to download the library from Microsoft. Do a search to get the latest version. And keep in mind that there are some major differences between the 1.1 and 2.0 frameworks so beware.  
  
I'll be using the 2.0 framework in this example. I've set up a project and set a reference to Microsoft.Practices.EnterpriseLibrary.Common and Microsoft.Practices.EnterpriseLibrary.Data. That should get us going.  
  
[![](/assets/images/CropperCapture%5B17%5D.Png)](http://bp3.blogger.com/_io6q_2NOAVQ/RX3CcLi48sI/AAAAAAAAAAM/Xz17E5dWTPI/s1600-h/CropperCapture%5B17%5D.Png)  
  
The next step is the start up the EntLibConfig.exe and select File - Open Application and select the app.config file for our project. At first glance, the configuration tool is not at all intuitive. But if you are lucky, you will have a node called Data Access Application Block. If not, then just select your app node and choose to add the Data Application Block manually.  
  
[![](/assets/images/CropperCapture%5B23%5D.Png)](http://bp0.blogger.com/_io6q_2NOAVQ/RX3EDbi48tI/AAAAAAAAAAU/7k_J_0WFgFA/s1600-h/CropperCapture%5B23%5D.Png)  
  
The vital piece of the Data Application Block is the Connection String setting. I modified the default LocalSqlServer connection to have the settings I need. First I'll change the Provider name for an Oracle Client connection. Unfortunately the tool isn't smart enough to set default connection string values for an oracle connection so you have to manually add, edit, or remove the default nodes under the connection string.  
  
[![](/assets/images/CropperCapture%5B26%5D.Png)](http://bp3.blogger.com/_io6q_2NOAVQ/RX3GcLi48uI/AAAAAAAAAAc/41EWb-VN7D8/s1600-h/CropperCapture%5B26%5D.Png)  
  
Once you've updated the connection string with the correct values, be sure to select the connection string as the default connection.  
  
[![](/assets/images/CropperCapture%5B29%5D.Png)](http://bp3.blogger.com/_io6q_2NOAVQ/RX3LDLi48vI/AAAAAAAAAAk/5aK3qMdBf2I/s1600-h/CropperCapture%5B29%5D.Png)  
  
Save and close the tool. Going back to the application we can see that the app.config was updated with our modifications.  
  

<?xml version\="1.0" encoding\="utf-8"?>

<configuration\>

  <configSections\>

   <section

      name\="dataConfiguration"

      type\="Microsoft.Practices.EnterpriseLibrary.Data.Configuration.DatabaseSettings, Microsoft.Practices.EnterpriseLibrary.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=null" />

  </configSections\>

  <dataConfiguration defaultDatabase\="DevOracleServer" />

  <connectionStrings\>

   <add

      name\="DevOracleServer"

      connectionString\="Server=SERVERNAME;User ID=USERNAME;Password=\*\*\*\*\*\*\*\*;"

      providerName\="System.Data.OracleClient" />

  </connectionStrings\>

</configuration\>

  
  
Now our application can connect to the Oracle database and is ready to go. All I need to do now is create a database and execute a command to get a DataReader.  
  

    1 using System;

    2 using System.Collections.Generic;

    3 using System.Text;

    4 

    5 using Microsoft.Practices.EnterpriseLibrary.Data;

    6 using System.Data;

    7 using System.Data.Common;

    8 

    9 namespace DataApplicationBlock

   10 {

   11    class Program

   12    {

   13         static void Main(string\[\] args)

   14         {

   15             string SQLScript = "select \* from persons";

   16 

   17             Database db = DatabaseFactory.CreateDatabase();

   18             DbCommand dbCommand = db.GetSqlStringCommand(SQLScript);

   19 

   20             using (IDataReader dr = db.ExecuteReader(dbCommand))

   21             {

   22                while (dr.Read())

   23                {

   24                     Console.WriteLine(String.Format("{0}, {1}",

   25                         dr.GetValue(0), dr.GetValue(1)));

   26                }

   27             }

   28         }

   29    }

   30 }

  
  
There we have it. Nice and easy steps to get you using the Data Application block.
