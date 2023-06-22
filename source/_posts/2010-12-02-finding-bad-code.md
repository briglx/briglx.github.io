---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Finding Bad Code"
date: "2010-12-02"
tags: 
  - "performance"
---

I've been working on parsing 1 million records into a local graph. I noticed that it was taking a while so I put together a test app to find where the problem could be. The tests was creating `int.MaxValue` number of vertices into the HashRepository.

## NVerticies Test

Running the test verified what I thought was happening. Somewhere the code is causing \\(O(n^2)\\).


<img loading="lazy" title="Growth" src="http://chart.apis.google.com/chart?chxt=x,y&amp;chs=300x225&amp;cht=s&amp;chds=0,169,0,6013,0,100&amp;chd=t:13,14,15,25,26,27,38,39,40,47,48,49,87,88,89,117,118,119,129,130,131,138,139,140,167,168,169|38,43,50,137,148,159,302,320,339,485,507,529,1656,1694,1732,2965,3016,3066,3585,3637,3689,4078,4137,4195,5874,5940,6008|84,23,69,81,47,94,60,93,64,54" alt="" width="300" height="225">

I ran a profiler on the code and found that 60% of the time was being spent on json serialization.

![Profiler]({{ site.url }}{{ site.baseurl }}/assets/images/CropperCapture86.png "Profiler")

So I swapped out to a different [JSON serializer](http://json.codeplex.com/) an re-ran the test.


<img loading="lazy" class="alignnone" title="JSon.NET Serializer" src="http://chart.apis.google.com/chart?chxt=x,y&amp;chs=300x225&amp;cht=s&amp;chds=5,51,0,316,0,100&amp;chd=t:-1,-1,-1,-1,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,-1|0,2,3,5,8,10,12,16,19,22,25,29,32,37,42,46,51,56,60,65,72,77,82,87,92,96,104,112,120,128,137,144,152,160,168,179,187,195,203,212,221,230,239,247,255,263,275,284,292,300,308,316|84,23,69,81,47,94,60,93,64,54" alt="" width="300" height="225">

The first part of the graph could be \\(O(n^2)\\) and the second looks linear \\(O(n)\\). The profiler showed an improvement. Now only 41% of the time is spent in serializing. But still it's not what I'm looking for. I want at least linear time.

![Newtonsoft JSon Serializer]({{ site.url }}{{ site.baseurl }}/assets/images/croppercapture88.png)

Since it looks like it may be the serializer, I switch caused the serializer to just return a constant value each time.

<img loading="lazy" class="alignnone" title="NVertex Constant Serializer" src="http://chart.apis.google.com/chart?chxt=x,y&amp;chs=300x225&amp;cht=s&amp;chds=0,50,0,100,0,100&amp;chd=t:0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,-1|0,1,3,4,5,7,8,10,12,13,15,16,18,21,23,25,26,28,30,31,33,36,37,39,41,44,49,51,53,56,58,60,62,64,66,68,70,73,75,77,79,82,84,86,88,90,92,94,100,-1,-1,-1|84,23,69,81,47,94,60,93,64,54" alt="" width="300" height="225">

Whala! There is the linear time I wanted. Notice the hops on the line when something took a little longer than usual. I would guess that is the hash table resizing. Let's see where the profiler says the code is spending its time. Now all the time is spent calculating the KeyHash for the property

![NVertiecies Constant Serializer Profile Output]({{ site.url }}{{ site.baseurl }}/assets/images/croppercapture1.png)

Here are how they compare to each other

<img loading="lazy" class="alignnone" title="NVertexAll" src="http://chart.apis.google.com/chart?chs=440x220&amp;cht=lxy&amp;chco=3072F3,FF0000,FF9900&amp;chds=0,50,0,375,0,50,0,375,0,50,0,370&amp;chd=t:-1|0,1,3,4,5,7,8,10,12,13,15,16,18,21,23,25,26,28,30,31,33,36,37,39,41,44,49,51,53,56,58,60,62,64,66,68,70,73,75,77,79,82,84,86,88,90,92,94,100,102,105|-1|0,2,4,6,8,10,13,16,19,23,27,30,33,37,41,46,50,54,60,64,69,74,78,83,87,92,97,104,110,116,123,129,136,145,151,158,165,172,179,185,192,202,217,230,250,270,281,297,323,343,365|-1|0,2,3,5,8,10,12,16,19,22,25,29,32,37,42,46,51,56,60,65,72,77,82,87,92,96,104,112,120,128,137,144,152,160,168,179,187,195,203,212,221,230,239,247,255,263,275,284,292,300,308&amp;chdl=No+Serializer|Default|Newton&amp;chdlp=b&amp;chls=2,4,1|1|1&amp;chma=5,5,5,25|0,5" alt="" width="440" height="220">

## NProperty Test

I still don't feel comfortable with the serializer as the culprit for the quadratic growth. Instead of creating a lot of Vertices, I will just create one vertex and add a lot of properties using the default serializer. This had a much better growth.

<img loading="lazy" class="alignnone" title="NPropertyTest Default Serializer" src="http://chart.apis.google.com/chart?chxt=x,y&amp;chs=300x225&amp;cht=s&amp;chds=0,50,0,100,0,100&amp;chd=t:0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,-1|0,1,3,4,5,7,8,10,12,13,15,16,18,21,23,25,26,28,30,31,33,36,37,39,41,44,49,51,53,56,58,60,62,64,66,68,70,73,75,77,79,82,84,86,88,90,92,94,100,-1,-1,-1|84,23,69,81,47,94,60,93,64,54" alt="" width="300" height="225">

The profile tells me most of the time is in the Serializer. Hmmm. I have good growth and am using a serializer. Perhaps the serializer isn't the issue.

![NPropertyTest Default Serializer Profiler]({{ site.url }}{{ site.baseurl }}/assets/images/croppercapture2.png)

Let's see the Newtonsoft serializer.

<img loading="lazy" class="alignnone" title="Property Only" src="http://chart.apis.google.com/chart?chxt=x,y&amp;chs=300x225&amp;cht=s&amp;chds=25,202,0,100,0,100&amp;chd=t:26,29,32,34,36,38,41,43,44,46,48,49,51,52,54,55,57,59,61,63,65,67,68,70,72,73,75,77,79,81,82,84,87,88,90,91,96,97,100,102,103,105,107,109,111,113,115,116,118,121,123,125,127,128,130,131,133,134,135,137,140,142,143,145,146,147,149,150,151,152,154,155,157,158,160,161,163,165,166,168,170,172,173,175,177,179,180,182,183,185,186,187,189,191,192,195,196,198,199,200,202|0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100|84,23,69,81,47,94,60,93,64,54" alt="" width="300" height="225">

Same growth, and most of the time was spent in the Serializer. Hmmm.

![Newtonsoft and NProperty]({{ site.url }}{{ site.baseurl }}/assets/images/croppercapture89.png "Newtonsoft and NProperty")

Let's see with no serializer.

<img loading="lazy" class="alignnone" title="NPropertyTest No Serializer" src="http://chart.apis.google.com/chart?chxt=x,y&amp;chs=300x225&amp;cht=s&amp;chds=0,100,0,38,0,100&amp;chd=t:0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100|0,1,1,1,2,2,2,3,3,3,4,4,5,5,5,6,6,7,7,7,8,8,9,9,9,10,10,10,11,11,12,12,12,13,13,13,14,14,14,15,15,16,16,16,17,17,18,18,18,19,19,19,20,20,21,21,22,22,22,23,23,23,24,24,25,25,26,26,26,27,27,27,28,28,28,29,29,29,30,30,30,31,31,32,32,32,33,33,33,34,34,35,35,35,36,36,36,37,37,37,38|84,23,69,81,47,94,60,93,64,54" alt="" width="300" height="225">

![NPropertyTest No Serializer Profiler]({{ site.url }}{{ site.baseurl }}/assets/images/croppercapture3.png)

Together they look like this

<img loading="lazy" title="NPropertyAll" src="http://chart.apis.google.com/chart?chs=440x220&amp;cht=lxy&amp;chco=3072F3,FF0000,FF9900&amp;chds=0,100,0,65,0,100,0,65,0,100,-5,65&amp;chd=t:-1|0.2,0.6,1,1.3,1.7,2,2.4,2.7,3,3.4,3.8,4.2,4.6,5,5.5,5.8,6.1,6.6,7,7.3,7.7,8.2,8.6,9,9.4,9.7,10,10.4,10.8,11.2,11.6,11.9,12.2,12.7,13,13.4,13.8,14.1,14.5,14.8,15.2,15.6,16,16.4,16.8,17.2,17.5,17.9,18.2,18.6,19,19.4,19.9,20.3,20.7,21.1,21.5,21.9,22.4,22.7,23.1,23.4,23.9,24.3,24.6,25.1,25.6,26,26.3,26.7,27.1,27.4,27.8,28.1,28.4,28.8,29.1,29.5,29.8,30.1,30.5,30.8,31.2,31.6,31.9,32.2,32.6,33,33.5,33.8,34.2,34.6,34.9,35.3,35.7,36.1,36.5,36.8,37.2,37.5,37.8|-1|0.3,1,1.8,2.7,3.4,4.2,4.8,5.5,6.1,6.8,7.3,7.9,8.7,9.3,9.8,10.5,11.3,11.9,12.7,13.2,13.9,14.7,15.3,15.9,16.5,17.1,17.7,18.3,18.8,19.4,20,20.6,21.2,21.8,22.5,23.1,23.7,24.3,24.9,25.8,26.3,26.9,27.9,28.5,29.1,29.6,30.1,30.7,31.2,31.8,32.4,33.3,34,34.7,35.4,35.9,36.7,37.2,37.9,38.7,39.2,39.9,40.4,41,41.7,42.4,43,43.5,44.1,44.8,45.5,46.2,47.2,47.9,48.5,49,49.7,50.3,50.8,51.4,52,52.6,53.3,54.1,54.6,55.3,55.9,56.5,57,57.7,58.3,58.9,59.4,60,60.5,61.1,61.6,62.2,62.9,63.8,64.7|-1|2.6,2.9,3.2,3.4,3.6,3.8,4.1,4.3,4.4,4.6,4.8,4.9,5.1,5.2,5.4,5.5,5.7,5.9,6.1,6.3,6.5,6.7,6.8,7,7.2,7.3,7.5,7.7,7.9,8.1,8.2,8.4,8.7,8.8,9,9.1,9.6,9.7,10,10.2,10.3,10.5,10.7,10.9,11.1,11.3,11.5,11.6,11.8,12.1,12.3,12.5,12.7,12.8,13,13.1,13.3,13.4,13.5,13.7,14,14.2,14.3,14.5,14.6,14.7,14.9,15,15.1,15.2,15.4,15.5,15.7,15.8,16,16.1,16.3,16.5,16.6,16.8,17,17.2,17.3,17.5,17.7,17.9,18,18.2,18.3,18.5,18.6,18.7,18.9,19.1,19.2,19.5,19.6,19.8,19.9,20,20.2&amp;chdl=No+Serializer|Default|Newton&amp;chdlp=b&amp;chls=2,4,1|1|1&amp;chma=5,5,5,25" alt="" width="440" height="220">

I'm not really seeing anything.

<script
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
  type="text/javascript">
</script>