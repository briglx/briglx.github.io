---
title: "Javascript Templating"
date: "2011-11-01"
categories: 
  - "software"
tags: 
  - "javascript"
  - "web"
---

Way back in 2008 I was really getting into JavaScript development and created a small templating object.

The basic idea is to keep view code all in the same location. In this case the view is a html page. JavaScript will update the view. Any new elements on the page should be defined on the page in a hidden template. Notice the naming convention using -t for templates.

\[code lang="html"\] <table class="employees"> <tr><td>Name</td><td>Location</td></tr> <tr><td>John</td><td>Phoenix, AZ</td></tr> <tr><td>Bill</td><td>Tempe, AZ</td></tr> </table>

<div class="hidden employee-t"> <tr><td>{name}</td><td>{location}</td></tr> </div>`

The JavaScript code will add a new employee to the employees list.

\[code lang="js"\] // Get the template from the hidden div var newRowTemplate = $(".employee-t").html();

// Create a new template using the html for the pattern var newRow = new helios.template(newRowTemplate);

// Fetch employee data. Returns // {employees : \[ // {"name":"Jim","location","San Jose, CA"}, // {"name":"Sara","location","L.A., CA"} \]} var items = ajax.get("/employee/ca")

var len = items.length; for (var i=0; i<len; i++) { var item = items\[i\];

// Evaluate the JSON object into the template var text = newRow.evaluate(item);

// Add the new element to the page $(.employees).append(text); }`

### JavaScript Template

Here is the very simple template to get the job done. Nothing special here.

\[code lang="js"\] /\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/ /// <summary> /// An object that uses an html template and data to produce merged html. /// </summmary> helios.template = function(text){ this.\_pattern = $.trim(text); }

helios.template.prototype = { evaluate : function(data){ var s = this.\_pattern; // Cycle each property name $.each(data, function(i){ // Replace Named Placeholder with property value var re = new RegExp("{" + i + "}","g"); s = s.replace(re, data\[i\] ); //s = s.split(re).join(data\[i\]); }); // Replace the data found in the template. return s; } }`
