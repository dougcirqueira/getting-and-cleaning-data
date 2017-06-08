# getting-and-cleaning-data
Repository created for the Getting and Cleaning Data course project from Coursera.

The dataset used in this course project is related to [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).


# Files
`run_analysis.R` 
This is the script responsible for performing the analyses required. 
It has all the necessary code to run the steps asked in this course project from Coursera, which are the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

`tidyData.csv`
This file contains the output in .csv from step 5 on run_analysis.R script.

`tidyData.txt`
This file contains the output in text file format from step 5 on run_analysis.R script.

`CodeBook.md`
This file is a code book that describes the variables, the data, and any transformations or work that were performed to clean up the data.
