# tidyAssignment#
Coursera Getting and Cleaning Data project week 4 Assignment
This R script takes public data from the web facing project "Human Activity Recognition Using Smartphones Dataset
Version 1.0" it then performs a prescribed series of steps per the assignment to deliver a tidy data set as follows:\ 
##Step 1: "Merges the training and the test sets to create one data set"##
Download and unzip dataset from coursera web address. Data set contains "Readme.txt" which explains the structure of
experiments, types of measurements and the structure of the raw data in the zip file.
Load and merge  "Test" and "Training data sets using rbind into a single R dataframe (MergeDS) containing 563 variables;
561 feature vectors" together with a subject ID and "activity" indicator.
Variable names are assigned to the columns based on decriptions in the supplied "features.txt"
A check for missing values was made in development and raw zip files aand intermeidate steps are deleted to avoid clutter
##Step 2: "Extracts only the measurements on the mean and standard deviation (std) for each measurement"##
Extract 33 mean and 33 corresponding standard deviation variable by subsetting using a regular expression in grep to subset
On review of raw data, mean Frequency signals was excldued since this is a weighted mean with no corresponding std.
Similarly angle signal is based on a number of averages for whihc there is no corresponding std.
Subject ID nd Activity were also assigned to the extracted data frame (xtractDS).
Intermemdiate vectors and data frames are removed after extraction.
##Step 3: "Uses descriptive activity names to name the activities in the data set"##
Activity columsn is updated with labels corresponding to six activity types in the experiment
##Step 4: "Appropriately labels the data set with descriptive variable names"##
feature names were assigned to variables in step 1, names are tidied further to leave only alphanumerics in variabel names.
Capitalisation in line with the raw data is retained to allow easier reading of complex variables
##Step 5: "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject".##
Extracted dataset is grouped by activity(6) and subject (30). A corresponding 180 mean of means and mean of std's are then reported
in a tidy file "tidyAssignment.txt. this file can be loaded in R using read.table( , header=TRUE).
