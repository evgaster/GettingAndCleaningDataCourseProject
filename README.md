GettingAndcleaningdatacourseproject
===================================

A repository for the project of the Coursera course "Getting and Cleaning Data"

# Content
This file is divided into the following parts:
* Obtaining the input for the project
* Inspecting the input
* Processing the input

The latter describes the run_analysis.R script.


# Obtaining the input for the project.
Via www.coursera.org --> Getting and Cleaning Data --> Course Project, I got to the projects web page.
There I found a [link to the data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and a [link to a description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

I downloaded the data on 2014-10-11 22:04. After unzipping I got a (sub)directory "UCI HAR Dataset".

# Inspecting the input.
Great, there is a README.txt file. It elaborates a little further on what this is all about then the description menioned above. It also lists the files with a very brief explanation. There are a few files at the top level and subdirectories train and test with similar structure.

## activity_labels.txt
Seems to map activity numbers to activity "verbs". This could be processed as a dataframe. It is space separated and has no heading --> col.name = c("ActivityId", "Activity").

## features_info.txt
Describes how the raw measurements where processed to the machine learning features, sort of summary of the next file.

## features.txt
Similar to activity_labels.txt --> col.name = c(FeatureId, FeatureName). There appear to be duplicate Features. Need to check if they need to be processed!

## train/X_...
These are clearly the machine learning feature vectors (row wise). This is to big to eye-ball it ok. The linux command 'head -1 ... | wc -w' tells me there are 561 columns. That matches with the number of lines in features.txt.

## train/y_...
These are clearly the machine learning labels. The linux command 'sort ... | uniq -c' tells me the values are all in [1 - 6] which matches with my ActivityId. The frequencies differ.

## train/subject...
According to the README.txt "Each row identifies the subject who performed the activity ...". These are candidate for a SubjectId. The linux command 'sort ... | uniq -c' gives 21 different values in [1 - 30]. The frequencies differ

## train/X_..., y_... and subject...
These 3 files belong together. A row in one file corresponds to the same row in the other files. It is important to keep the rows in the files in the same consistent order! The linux command 'wc -l ...' gives 7352 lines in each of the files.

## train/Inertial...
Contains raw data from which X_... was derived. The structure of the files looks very consistent.

## test
This directory has the same structure as the train directory. But the numbers are different. Based on the SubjectId's test and train are indeed disjunct.

## This is not a tidy data set
This data set is well structured, clean but in my opinion it is questionable if it is tidy. The X_..., y_... and subject... files contain data that clearly belongs together. The relation is not facilitated by a key per row in each of the files but solely on the very row the data occurs. This is not an explicit but in implicit error prone key. Each row in the separate files together do form an instance of een observational unit. In my opinion this violates the "Each type of observational unit forms a table" requirement for a tidy data set.

# Processing the input
We are given the following assingment:

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Merges the training and the test sets ...
The script loops over the relevant files and within that loop, loops over the different sets. For each of the relevant files a new empty one is created. Subsequently the corresponding files from the different sets are appended to it.

The new files are left in the current directory. They are not removed by the script.

##  Extracts only ...
This means we should only pick the relevant columns from the X_... file. Since this specification in combination with features.txt is some what ambibuous, I chose to include every column of the X_... file of which the corresponding line in features.txt looks like mean or std.

The script first builds a data frame from the features.text file. From the resulting data frame it builds a selector to be used while reading the X_... file.

The data frames X, y and subjects are build by reading the corresponding files.

## Uses descriptive activity names ...
The script first builds a data frame from the activity_labels.txt file. That is used to add an extra column to the y data frame with an activity name corresponding to the activity Id.

## Appropriately labels ...
Nothing to do here. It has already been done on the fly in the previous steps.

## From the data set ...
For each column of X, for each combination of activity and subject, calculate the mean over the corresponding rows of that column.

The used function gives a data frame with the column names taken from the parameters and the input. These names are given a proper prefix.

Finally the data frame is written to the file tidy.text in the current directory.

## This is a tidy data set ...
In my opinion this is a tidy data set. It meets the following criteria for a tidy data set.

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.
