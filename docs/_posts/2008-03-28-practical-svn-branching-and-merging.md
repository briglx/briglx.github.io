---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Practical SVN Branching and Merging"
date: "2008-03-28"
tags: 
  - "svn"
---

I love SVN and the ability to branch and tag my repository. 

I work on a two week release cycle with each revision being a version change. In SVN, I create a branch when I go into QA. Just about once a month I need to make a fix in QA which requires the need to merge a the branch fix into the trunk. Here are the steps I use in order to make that happen.

Steps to update Trunk with Branch changes

1. Finish and commit changes on branch.
2. Point working copy to trunk via Switch
3. Ensure working copy has latest changes via update
4. Merge changes of Branch in to Working Copy via Merge Command.
    1. Click Merge
    2. Start URL will be the Branch
    3. Click Show Log to select the start of the branch
    4. End URL will also be the Branch
    5. Click the HEAD Revision. This will get all the changes made during the branch.
    6. Take Note of the Start and End Revisions. These values will be used later. You will have to log at the log to see what the head revision is.
    7. Click Dry Run to see what files will be affected.
    8. If things looks good, click Merge.  
        ![SVNMerge]({{ site.url }}{{ site.baseurl }}/assets/images/SVNMerge.Png.png)
5. Your working copy now has the changes made during the branch. Edit conflicts if any.
6. Commit you changes with the comment like: "Merged v2.0-branch changes r99026:99343 into the trunk"

I hope this helps, if not, I know it will help me because I keep forgetting how to do this. Let me know if you have a different approach of merging in patches.
