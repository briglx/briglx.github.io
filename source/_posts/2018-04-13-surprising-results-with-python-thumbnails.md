---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
cover: /assets/images/comparepythonthumbnailsfeature.png
title: "Surprising Results with Python Thumbnails"
date: "2018-04-13"
tags: 
  - "software"
  - "python"
---

I've been working with images recently and am using a technique for a hashing algorithm. This technique resized the image to a 9x8 gray scale image.

I found five different ways to do it with a few surprising results:

- cv2
- pillow
- skimage
- two custom gray scale functions

## The Code

The first part of the code loads the image file, convert it to black and white, and then resizes it down to an 9x8 thumbnail.

The rgb3gray and rgb2gray2 methods are custom functions that attempt to convert an RGB [n,d,3] matrix into a gray scale.

The second part of of the code uses matplotlib to show the thumbnails.

```
import os
import sys

import cv2
import numpy as np

import matplotlib.pyplot as plt

from PIL import Image
from skimage import io

from skimage import transform as skitr

hash_size=8

cv2Image = cv2.imread(fileName)
cv2Image = cv2.cvtColor(cv2Image, cv2.COLOR_BGR2GRAY)                            
cv2Image = cv2.resize(cv2Image, (hash_size +1 , hash_size))

pillowImage = Image.open(fileName)
pillowImage = pillowImage.convert('LA')
pillowImage = pillowImage.resize((9,8))

skImage = io.imread(fileName, as_grey=True)
skImage = skitr.resize(skImage, (hash_size, hash_size+1))
                                 
 #  Use CV2 to load and resize image as original
originalImage = resizeImage(cv2.imread(fileName))   
rgb2grayImage = rgb2gray(originalImage)
rgb2grayImage2 = rgb2gray2(originalImage)                               

# Display the images
fig, axes = plt.subplots(nrows=2, ncols=3)
axes[0, 0].set_title('Original Image')
axes[0, 0].imshow(originalImage, cmap='gray')
axes[0, 0].axis('off')
                                 
axes[0, 1].set_title('CV2 Image')
axes[0, 1].imshow(cv2Image, cmap='gray')
axes[0, 1].axis('off')
                                 
axes[0, 2].set_title('Pillow Image')
axes[0, 2].imshow(pillowImage, cmap='gray')
axes[0, 2].axis('off')
                                 
axes[1, 0].set_title('skimage Image')
axes[1, 0].imshow(skImage, cmap='gray')
axes[1, 0].axis('off')

axes[1, 1].set_title('Rgb2Gray Image')
axes[1, 1].imshow(rgb2grayImage, cmap='gray')
axes[1, 1].axis('off')

axes[1, 2].set_title('Rgb2Gray2 Image')
axes[1, 2].imshow(rgb2grayImage2, cmap='gray')
axes[1, 2].axis('off')

fig.tight_layout()
plt.show()
```

## The Method

I took four different images and ran it against the code. I used Cv2 as the baseline for my original image thumbnail. This thumbnail has the RGB colors and is resized.

## The Results

**Image 1 - Color**

![comparePythonThumbnails01]({{ site.url }}{{ site.baseurl }}/assets/images/comparepythonthumbnails01.png)

**Image 2 - Color**

![comparePythonThumbnails02]({{ site.url }}{{ site.baseurl }}/assets/images/comparepythonthumbnails02.png)

**Image 3 - Color**

![comparePythonThumbnails03]({{ site.url }}{{ site.baseurl }}/assets/images/comparepythonthumbnails03.png)

**Image 4 - Color**

![comparePythonThumbnails04]({{ site.url }}{{ site.baseurl }}/assets/images/comparepythonthumbnails04.png)

There are a few things I noticed:

- CV2 and skimage appear to be identical
- Cv2 and skimage seem too light and too dark compared to the original
- Pillow seemed best matching the luminance of the original
- Rgb2Gray nearly matches the CV2 and skimage
- Rgb2Gray2 does not produce anything that makes sense. Apparently I have a bug in my code.

It seems like pillow does a better job at matching the luminance. For the final test, I used Windows Color Filter feature to remove the color from the original image. I used this as my baseline.

**Image 1 - Gray Scaled**

![comparePythonThumbnails01bw]({{ site.url }}{{ site.baseurl }}/assets/images/comparepythonthumbnails01bw.png)

**Image 2 - Gray Scaled**

![comparePythonThumbnails02bw]({{ site.url }}{{ site.baseurl }}/assets/images/comparepythonthumbnails02bw.png)

**Image 3 - Gray Scale**

![comparePythonThumbnails03bw]({{ site.url }}{{ site.baseurl }}/assets/images/comparepythonthumbnails03bw.png)

**Image 4 - Gray Scale**

![comparePythonThumbnails04bw]({{ site.url }}{{ site.baseurl }}/assets/images/comparepythonthumbnails04bw.png)

## Conclusion

After running the images through windows color filter, it appears Pillow does the best job matching the original.
