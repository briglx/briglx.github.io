---
layout: post
current: post
# cover:  assets/images/confluencev1.png
navigation: True
title: Finding Missing Images
date: 2022-05-20
tags: 
  - sed
  - awk
  - linux
  - software
class: post-template
subclass: 'post'
author: brig
---

As part of my blog migration, I discovered one of my images wasn't showing because it had the wrong case `myimage.png` vs `MyImage.png`. This is how I checked what other images were named wrong or missing.

My strategy is to:
1. Get the list of images I have
2. Find all the image referenced in the blog
3. Alert where the reference name <> an actual name

## Getting the list of images

This is really easy
```bash
ls /images > images_list.csv
```

## Getting the images refereced

This is a bit trickier because I have to look inside the files. `grep` seems like a good way to do this.

```bash
grep -Er '/images/(.+)' _posts > referenced_images.csv

head referenced_images.csv
_posts/2014-07-31-what-version-of-php-am-i-running.md:cover: assets/images/phpapache.jpg
_posts/2011-02-17-a-tour-of-jmeter-part-1.md:  You should now have two elements. ![Record1](/assets/images/Record1.png)
_posts/2011-02-17-a-tour-of-jmeter-part-1.md:  JMeter now has your actions recorded ![Record2](/assets/images/Record2.png)
```

I don't need all the info retured. ow do I just get the image name part.

looking at `man grep` the options `-o -h` look promising.

```
 -o, --only-matching
              Print only the matched (non-empty) parts of a matching line, with each such part on a  separate  output
              line.

 -h, --no-filename
              Suppress  the  prefixing  of file names on output.  This is the default when there is only one file (or
              only standard input) to search.
```

```bash
grep -Eroh '/images/(.+)' _posts > referenced_images.csv

head referenced_images.csv
/images/phpapache.jpg
/images/Record1.png)
/images/Record2.png)
/images/SBCLOptions.Png)
```

I'd like to just get the image name though. Pearl has a [look-around assersion](https://perldoc.perl.org/perlre#Lookaround-Assertions) syntax which will check for things before or after the pattern match. 

```bash
# Find a word between foo and bar
grep -oP '(?<=foo )\w+(?= bar)' test.txt

# Shortcut for the same query
grep -oP 'foo \K\w+(?= bar)' test.txt
```

I can modify my query to drop everything before the `\K`.
```bash
grep -rPoh '/images/\K.+(png|jpe?g|gif)' _posts > referenced_images.csv
head referenced_images.csv
phpapache.jpg
Record1.png
Record2.png
```

Nice, now I just need to loop over each one in the reference and see if there is a match in the actualls.

## Finding the outlyers

I'm sure there is an easier way to do this.

```bash
while read l; do echo -n "$l "; grep -c $l image_list.csv; done < referenced_images.csv  > results.csv

head results.csv
phpapache.jpg,1
Record1.png,0
Record2.png,0
trainingvalidation

cat results.csv | grep ' 0' | awk '{print $1}'  > missing_images

head missing_images
Record1.png,0
Record2.png,0
CropperCapture88.png,0

```

Now I have my list but don't know if it's just missing or has a case of bad formatting.

```bash

awk '{print $1;}' missing_images

while read l; do echo -n $l,; grep -ic $l image_list.csv; done < missing_images > wrong_case.csv

head
Record1.png,1
Record2.png,1
CropperCapture%5B12%5D.png,0

# 1 means it's named wrong
# 0 means it's not in the image list
```

## References
- Can I grep out a group match https://unix.stackexchange.com/questions/13466/can-grep-output-only-specified-groupings-that-match
- Basic Grep info https://linuxize.com/post/regular-expressions-in-grep/

