# Getting & Cleaning Data - Course Project 2

## Introduction

Four things required to create a tidy data set (included with this project submission):
 - **the raw data** (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
 - **a tidy data set** (the output from the script, submitted via Coursera)
 - **a code book** describing each variable and its values in the tidy data set (**CodeBook.md** in this repository)
 - **an explicit and exact recipe** to go from the raw data to the tidy data (**run_analysis.R** R script in this repository)


## Tidy Data Principles
  - Each variable you measure should be in one column
  - Each different observation of that variable should be in a different row
  - There should be one table for each "kind" of variable
  - If you have multiple tables, they should include a column to link them in some way

## Project Approach

Below is a description of how the script was designed, and the steps performed to achieve a data set that exhibits the principles of tidy data:

**1. Read data in**
 - Reads the training data, activity labels & subjects from the relevant files
 - Reads the test data, activity labels & subjects from the relevant files

**2. Combine data into one data frame**
 - Adds columns for activity labels & subjects to the training data
 - Adds columns for activity labels & subjects to the test data
 - Merges the training & test data together as one data frame

**3. Set human readable tidy-data variable names**
 - Reads the raw data set variable names for the 561 variables collected during the study
 - Clean up the variable names, making them more human readable:
   - Remove parenthesis
   - Replace 't' with 'Time'
   - Replace 'f' with 'Frequency'

**4. Calculate the required grouped means**
 - Calculate the mean of each variable measured, grouped by subject and activity

**5. Output the resultant tidy data to a file**

**The result is a table that has one row per observation, one column per variable measured, and human readable variable names on each column.**
