# Getting and Cleaning Data Course Project
This repository contains instructions on how to collect and clean the Human Activity Recognition Using Smartphones Data Set
from UC Irvine's Machine Learning Repo. 

# Dataset
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Scripts
* CodeBook.md describes the variables, data, and transformations that was performed to clean up the data.
* run_analysis.R is an R script that performs the following: 
  - Merges training and test sets to create one dataset.
  - Extracts only mean and standard deviation for each measurement. 
  - Uses descriptive activity labels to name the activities in the dataset.
  - Labels dataset with descriptive variable names. 
  - From the previous step, creates second and independent tidy dataset with the average of each variable for each activity and each subject.
* tidy_df.txt contains the final tidy dataset. 
