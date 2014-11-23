---
title: "Code Book Markdown"
author: "Grace"
date: "Monday, November 24, 2014"
output: html_document
---

Variable list and descriptions
------------------------------

Variable name    | Description
-----------------|------------
traindata        | train measurement data
trainlabel       | train activity data
trainsubject     | train subject data
testdata         | test measurement data
testlabel        | test activity data
testsubject      | test subject data
mergedata        | merge train and test measurement data
mergelabel       | merge train and test activity data
mergesubject     | merge train and test subject data
features         | 561 measurements
extractmergedata | signal data pertaining to mean and standard deviation only
activity         | activity subject performed e.g. walking,sitting, etc
cleandata        | dataset that merges the subject, activity name, and acceleration and velocity              
                 | signal data
resultdf         | final dataset with mean of variable for each activity and subject