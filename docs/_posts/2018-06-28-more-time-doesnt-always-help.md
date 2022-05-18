---
title: "More Time Doesn't Always Help"
date: "2018-06-28"
categories: 
  - "software"
tags: 
  - "keras"
  - "machine-learning"
  - "python"
  - "tensorflow"
---

Continuing on with Keras, there is a simple IMDB data set with movie ratings.  Building a quick model and training over a few epochs shows the training accuracy goes up to the high 90%. However, the validation accuracy hovers around 87%.

![TrainingValidationAccuracy](/assets/images/trainingvalidationaccuracy.png)

The model is over-fitting the data somehow. No matter how many more epochs I run, the validation won't get better.
