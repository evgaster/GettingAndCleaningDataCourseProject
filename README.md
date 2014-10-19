GettingAndcleaningdatacourseproject
===================================

A repository for the project of the Coursera course "Getting and Cleaning Data"

# Obtaining the input for the project.
Via www.coursera.org --> Getting and Cleaning Data --> Course Project, I got to the projects web page.
There I found a [link to the data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and a [link to a description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

I downloaded the data on 2014-10-11 22:04. After unzipping I got a (sub)directory "UCI HAR Dataset".

# Inspecting the input.
Great, there is a README.txt file. It elaborates a little further on what this is all about then the description menioned above. It also lists the files with a very brief explanation. There are a few files at the top level and subdirectories train and test with similar structure.

## activity_labels.txt
Seems to map activity numbers to activity "verbs". This could be processed as a dataframe. It is space separated an has no heading --> col.name = c("ActivityId", "Activity").

## features_info.txt
describes how the raw measurements where processed to the machine learning features, sort of summary to the next file.

## features.txt
Similar to activity_labels.txt --> col.name = c(FeatureId, FeatureName). There appear to be duplicate Features. Need to check if they need to be processed!

## train/X_...
These are clearly the machine learning feature vectors (row wise). This is to big to eye-ball it ok. The linux command 'head -1 ... | wc -w' tells me there are 561 columns. That matches with the number of lines in features.txt.

## train/y_...
These are clearly the machine learning labels. The linux command 'sort ... | uniq -c' tells me the values are all in [1 - 6] which matches with my ActivityId. The frequencies differ.

## train/subject...
According to the README.txt "Each row identifies the subject who performed the activity ...". These are candidate for a SubjectId. The linux command 'sort ... | uniq -c' gives 21 different values in [1 - 30]. The frequencies differ

## train/X_..., y_... and subject...
These 3 files belong together. A row in one file corresponds to the same row in the other files. It is important to keep them in the same order! The linux command 'wc -l ...' gives 7352 lines in each of the files.

## train/Inertial...
Contains raw data from which X_... was derived. The structure of the files looks very consistent.

## test
This directory has the same structure as the train directory. But the numbers are different. Based on the SubjectId's test and train are indeed disjunct.
