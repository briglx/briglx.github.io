---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Review of Copy Source As Html Tools"
date: "2007-07-19"
tags: 
  - "blogging"
  - "coding"
---

It makes sense that as a blog about .net programming I should include samples of code. 

Code is easier to read when there is syntax highlighting and proper indentation. I'm going to look at four tools that provide a way of displaying source code in Html documents. The first tool is a general add in to Visual Studio and the last tools are specific to [Windows Live Writer](http://windowslivewriter.spaces.live.com/Lists/cns!D85741BB5E0BE8AA!1340/).

The contestants are the following:

- [CopySourceAsHtml](http://www.jtleigh.com/people/colin/software/CopySourceAsHtml/)
- [Insert Code for Windows Live Writer](http://gallery.live.com/liveItemDetail.aspx?li=1f57bd9b-a692-4593-9e9e-e2962d9c0eee&bt=9&pl=8)
- [Paste from Visual Studio](http://gallery.live.com/liveItemDetail.aspx?li=d8835a5e-28da-4242-82eb-e1a006b083b9&bt=9&pl=8)
- [Code Snippet plugin for Windows Live Writer](http://gallery.live.com/liveItemDetail.aspx?li=d4409446-af7f-42ec-aa20-78aa5bac4748&bt=9&pl=8)

The plugins for Live Writer really are not named very well, but I'll give them a shot anyway.

## Screen Shot

In order to do a fair test, I will be comparing how the different tools handle the code in this screen:

![Raw Source](/assets/images/CropperCapture%5B1%5D.jpg)

## CopySourceAsHtml

This is an add-in for Visual Studio. Right clicking on the code to copy displays a Copy As Html... option in the context menu. Once clicked, an option box appears which provides additional configuration. I've used this tool in the past and have always been satisfied with the results. I selected Wrap words and Embed styles as the only options for the copy which produce the following results:

<div style="font-size:10pt;background:white;color:black;font-family:courier new;">
<p style="margin:0;"><span style="color:blue;">using</span> System;</p>
<p style="margin:0;">
</p><p style="margin:0;"><span style="color:gray;">///</span><span style="color:gray;">&lt;summary&gt;</span></p>
<p style="margin:0;"><span style="color:gray;">///</span><span style="color:green;"> Wizard represents a humanoid with special abilities</span></p>
<p style="margin:0;"><span style="color:gray;">///</span><span style="color:gray;">&lt;/summary&gt;</span></p>
<p style="margin:0;"><span style="color:blue;">public</span> <span style="color:blue;">class</span> <span style="color:#2b91af;">Wizard</span></p>
<p style="margin:0;">{</p>
<p style="margin:0;">&nbsp;&nbsp;&nbsp; <span style="color:blue;">const</span> <span style="color:blue;">string</span> Gretting = <span style="color:#a31515;">"Greetings and well met."</span>;</p>
<p style="margin:0;">
</p><p style="margin:0;">&nbsp;&nbsp;&nbsp; <span style="color:gray;">///</span><span style="color:gray;">&lt;summary&gt;</span></p>
<p style="margin:0;">&nbsp;&nbsp;&nbsp; <span style="color:gray;">///</span><span style="color:green;"> Says the greeting.</span></p>
<p style="margin:0;">&nbsp;&nbsp;&nbsp; <span style="color:gray;">///</span><span style="color:gray;">&lt;/summary&gt;</span></p>
<p style="margin:0;">&nbsp;&nbsp;&nbsp; <span style="color:blue;">public</span> <span style="color:blue;">void</span> SayGreeting()</p>
<p style="margin:0;">&nbsp;&nbsp;&nbsp; {</p>
<p style="margin:0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="color:green;">// Ensure it is Daylight Saving Time</span></p>
<p style="margin:0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="color:blue;">if</span> (<span style="color:#2b91af;">DateTime</span>.Now.IsDaylightSavingTime())</p>
<p style="margin:0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {</p>
<p style="margin:0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="color:#2b91af;">Console</span>.Write(<span style="color:#2b91af;">Math</span>.Abs(<span style="color:#2b91af;">Math</span>.PI + 25.4));</p>
<p style="margin:0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p style="margin:0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="color:blue;">else</span></p>
<p style="margin:0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {</p>
<p style="margin:0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="color:#2b91af;">Console</span>.Write(Gretting);</p>
<p style="margin:0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p style="margin:0;">&nbsp;&nbsp;&nbsp; }</p>
<p style="margin:0;">}</p>
</div>


Embedding the styles into the code gives the advantage of preserving the color highlighting when your post is picked up by an aggregator. If you do not embed the styles then you will lose the formatting and the code appears as normal text.

The tools provides options that really allow you to produce exactly what you want.

The only bad thing is I am forced to switch to html mode in order to insert the code snippet.

## Insert Code for Windows Live Writer

This is the first tool I've used as a plugin for Windows Live Writer. After the installation, I see a new option in my Insert list for Insert Code...

![Live Writer](/assets/images/CropperCapture%5B2%5D.jpg)

The web site for Insert Code describes it as able to format a snippet of text in a number of programming languages such as C#, HTML, MSH, JavaScript, Visual Basic and TSQL.

Here is the results of the insert:
<style>
    .csharpcode, .csharpcode pre
{
font-size: small;
color: black;
font-family: consolas, "Courier New", courier, monospace;
background-color: #ffffff;
/*white-space: pre;*/
}
.csharpcode pre { margin: 0em; }
.csharpcode .rem { color: #008000; }
.csharpcode .kwrd { color: #0000ff; }
.csharpcode .str { color: #006080; }
.csharpcode .op { color: #0000c0; }
.csharpcode .preproc { color: #cc6633; }
.csharpcode .asp { background-color: #ffff00; }
.csharpcode .html { color: #800000; }
.csharpcode .attr { color: #ff0000; }
.csharpcode .alt
{
background-color: #f4f4f4;
width: 100%;
margin: 0em;
}
.csharpcode .lnum { color: #606060; }
</style>

<pre class="csharpcode"><span class="kwrd">using</span> System;

<span class="rem">/// &lt;summary&gt;</span>
<span class="rem">/// Wizard represents a humanoid with special abilities</span>
<span class="rem">/// &lt;/summary&gt;</span>
<span class="kwrd">public</span> <span class="kwrd">class</span> Wizard
{
    <span class="kwrd">const</span> <span class="kwrd">string</span> Gretting = <span class="str">"Greetings and well met."</span>;

    <span class="rem">/// &lt;summary&gt;</span>
    <span class="rem">/// Says the greeting.</span>
    <span class="rem">/// &lt;/summary&gt;</span>
    <span class="kwrd">public</span> <span class="kwrd">void</span> SayGreeting()
    {
        <span class="rem">// Ensure it is Daylight Saving Time</span>
        <span class="kwrd">if</span> (DateTime.Now.IsDaylightSavingTime())
        {
            Console.Write(Math.Abs(Math.PI + 25.4));
        }
        <span class="kwrd">else</span>
        {
            Console.Write(Gretting);
        }
    }
}</pre>


Right away I can see that the color for strings is different that what I have defined in the original. More importantly I see I lost the specific font I had defined. The biggest advantage over CopySourceAsHtml is not forcing me to switch to html mode in order to insert the code. The plugin makes it completely transparent to me.

I think I'm going to run into trouble on some aggregators when it goes to process the code. Insert Code creates a `<style> </style>` section where it defines the css classes used to format the code. The tool doesn't provide the option for me to select embedded styles nor does it give me options to tweak the output.

One thing I do like is the ability to turn on alternate line background.

## Paste from Visual Studio

This is also an plugin for Windows Live Writer and also has nearly the same number of downloads as Insert Code. From the description on the web page, it can easily transfer syntax highlighted source code from Visual Studio to elegant HTML in Windows Live Writer. Copy from Visual Studio and insert directly to Windows Live Writer to maintain your unique syntax highlighting settings.


<pre class="code"><span style="color:#0000ff;">using</span> System;

<span style="color:#808080;">///</span><span style="color:#808080;">&lt;summary&gt;</span>
<span style="color:#008000;">/// Wizard represents a humanoid with special abilities </span>
<span style="color:#808080;">///</span><span style="color:#808080;">&lt;/summary&gt; </span>
<span style="color:#0000ff;">public</span> <span style="color:#0000ff;">class</span> <span style="color:#2b91af;">Wizard </span>{
    <span style="color:#0000ff;">const</span> <span style="color:#0000ff;">string</span> Gretting = <span style="color:#a31515;">"Greetings and well met."</span>;

    <span style="color:#808080;">///</span><span style="color:#808080;">&lt;summary&gt; </span>    
    <span style="color:#808080;">///</span><span style="color:#008000;"> Says the greeting. </span>    
    <span style="color:#808080;">///</span><span style="color:#808080;">&lt;/summary&gt; </span>    
    <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">void</span> SayGreeting()
    {
        <span style="color:#008000;">// Ensure it is Daylight Saving Time </span>        
        <span style="color:#0000ff;">if</span> (<span style="color:#2b91af;">DateTime</span>.Now.IsDaylightSavingTime())
        {
            <span style="color:#2b91af;">Console</span>.Write(<span style="color:#2b91af;">Math</span>.Abs(<span style="color:#2b91af;">Math</span>.PI + 25.4));
        }
        <span style="color:#0000ff;">else </span>        {
            <span style="color:#2b91af;">Console</span>.Write(Gretting);
        }
    }
}</pre>



Sure enough, this tool has kept the colors and font I have defined in VS. The tool doesn't give me any type of user interface but takes the contents of the clipboard and inserts them as html. I'm guessing the tool uses the rich text formatting that VS provides and builds the styles. I do like that the styles are embedded in the code so I won't lose any formatting in the aggregators. However, I miss having the opportunity to add any tweaks to the output before it is committed.

## Insert Code Snippet

The last Live Writer plugin to review is [Code Snippet plugin for Windows Live Writer](http://gallery.live.com/liveItemDetail.aspx?li=d8835a5e-28da-4242-8http://gallery.live.com/liveItemDetail.aspx?li=d4409446-af7f-42ec-aa20-78aa5bac4748&bt=9&pl=82eb-e1a006b083b9&bt=9&pl=8). This follows the same installation as the previous plugins. However, I do get the chance to make some changes before the code is inserted into my page.

![Insert Code Snippet](/assets/images/CropperCapture%5B3%5D.jpg)

I stick with the defaults and get the following results:


<div style="font-size:8pt;margin:20px 0 10px;overflow:auto;width:97.5%;cursor:text;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;max-height:200px;padding:4px;border:gray 1px solid;">
<div style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;padding:0;">
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;padding:0;"><span style="color:#606060;"> 1:</span> <span style="color:#0000ff;">using</span> System;</pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;padding:0;"><span style="color:#606060;"> 2:</span></pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;padding:0;"><span style="color:#606060;"> 3:</span> <span style="color:#008000;">/// &lt;summary&gt;</span></pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;padding:0;"><span style="color:#606060;"> 4:</span> <span style="color:#008000;">/// Wizard represents a humanoid with special abilities</span></pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;padding:0;"><span style="color:#606060;"> 5:</span> <span style="color:#008000;">/// &lt;/summary&gt;</span></pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;padding:0;"><span style="color:#606060;"> 6:</span> <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">class</span> Wizard</pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;padding:0;"><span style="color:#606060;"> 7:</span> {</pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;padding:0;"><span style="color:#606060;"> 8:</span>     <span style="color:#0000ff;">const</span> <span style="color:#0000ff;">string</span> Gretting = <span style="color:#006080;">"Greetings and well met."</span>;</pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;padding:0;"><span style="color:#606060;"> 9:</span></pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;padding:0;"><span style="color:#606060;"> 10:</span>     <span style="color:#008000;">/// &lt;summary&gt;</span></pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;padding:0;"><span style="color:#606060;"> 11:</span>     <span style="color:#008000;">/// Says the greeting.</span></pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;padding:0;"><span style="color:#606060;"> 12:</span>     <span style="color:#008000;">/// &lt;/summary&gt;</span></pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;padding:0;"><span style="color:#606060;"> 13:</span>     <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">void</span> SayGreeting()</pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;padding:0;"><span style="color:#606060;"> 14:</span>     {</pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;padding:0;"><span style="color:#606060;"> 15:</span>         <span style="color:#008000;">// Ensure it is Daylight Saving Time</span></pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;padding:0;"><span style="color:#606060;"> 16:</span>         <span style="color:#0000ff;">if</span> (DateTime.Now.IsDaylightSavingTime())</pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;padding:0;"><span style="color:#606060;"> 17:</span>         {</pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;padding:0;"><span style="color:#606060;"> 18:</span>             Console.Write(Math.Abs(Math.PI + 25.4));</pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;padding:0;"><span style="color:#606060;"> 19:</span>         }</pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;padding:0;"><span style="color:#606060;"> 20:</span>         <span style="color:#0000ff;">else</span></pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;padding:0;"><span style="color:#606060;"> 21:</span>         {</pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;padding:0;"><span style="color:#606060;"> 22:</span>             Console.Write(Gretting);</pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;padding:0;"><span style="color:#606060;"> 23:</span>         }</pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;padding:0;"><span style="color:#606060;"> 24:</span>     }</pre>
<pre style="font-size:8pt;margin:0;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;padding:0;"><span style="color:#606060;"> 25:</span> }</pre>
</div>
</div>

Not too bad. In fact, besides not keeping my original color and font, I like the end result. I especially like how the styles are embedded inline. I don't think I would use the line numbers too often but I do like the alternate line background.

## The Results

Among all of the tools I will keep two. 

- [CopySourceAsHtml](http://www.jtleigh.com/people/colin/software/CopySourceAsHtml/)
- [Code Snippet plugin](http://gallery.live.com/liveItemDetail.aspx?li=d8835a5e-28da-4242-8http://gallery.live.com/liveItemDetail.aspx?li=d4409446-af7f-42ec-aa20-78aa5bac4748&bt=9&pl=82eb-e1a006b083b9&bt=9&pl=8) for Windows Live Writer

I will keep [CopySourceAsHtml](http://www.jtleigh.com/people/colin/software/CopySourceAsHtml/) so I can get my code into html format whenever I want. 

For Windows Live Writer, I'm going to stick with the aptly named [Code Snippet plugin for Windows Live Writer](http://gallery.live.com/liveItemDetail.aspx?li=d8835a5e-28da-4242-8http://gallery.live.com/liveItemDetail.aspx?li=d4409446-af7f-42ec-aa20-78aa5bac4748&bt=9&pl=82eb-e1a006b083b9&bt=9&pl=8). I chose this as the winner because I am provided options over the results and it has inline styles. 

[Insert Code for Windows Live Writer](http://gallery.live.com/liveItemDetail.aspx?li=1f57bd9b-a692-4593-9e9e-e2962d9c0eee&bt=9&pl=8) gives me almost the same features but doesn't provide inline styles which is a must when it comes to aggregators.

I do wish that more languages were supported in the plugins and hope this will come in time. I know there must be more tools out there to get source code to html but these are the four that I found. If you have a tool that you enjoy, please share it. I'm always looking for ways to improve and make life easier.
