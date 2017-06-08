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

# How the Script works:

The following information explains how the script works:

### 1. Merges the training and the test sets to create one data set. ###
First, the files `X_train.txt`, `X_test.txt`, `y_train.txt`, `y_test.txt`, `subject_train.txt` and `subject_test.txt`  were read as dataframes. The next step was
to merge those files via the `rbind()` function.
The same was performed for `subject_train.txt` and `subject_test.txt`
In the end, the resulting variables were `xMergedData` (`X_train.txt` and `X_test.txt`), `yMergedData` (`y_train.txt` and `y_test.txt`)
and `mergedSubject` (`subject_train.txt` and `subject_test.txt`).

### 2. Extracts only the measurements on the mean and standard deviation for each measurement. ###
The first step here was to name the header of the data frame `xMergedData`, with the variable names from `features.txt` file.
Next, the variables with mean and standard deviation were selected via the `grepl()` function applied to select the columns from
`xMergedData` that cointained the strings "mean" or "std".
The result of this step was saved as the data frame `xMergedDataMeanSd`.

### 3. Uses descriptive activity names to name the activities in the data set. ###
The `factor()` function was applied in this step, with the levels ranging from 1 to 6 (according to the activity labels)
and labels argument coming from the file `activity_labels.txt`.
The result of this operation was given to the column name from the data frame `yMergedData`.

### 4. Appropriately labels the data set with descriptive variable names. ###
In this step, the headers of the data frames `mergedSubject` and `yMergedData` were named as "subject" and "activity", respectively.
Next, the following operations were performed in the variable names from `xMergedDataMeanSd`, so those could be more
descriptive:
1. The term "t" was replaced by "time"
2. The term "f" was replaced by "freq"
3. The term "Acc" was replaced by "Accelerometer"
4. The term "Gyro" was replaced by "Gyroscope"
5. The term "Mag" was replaced by "Magnitude"
6. The term "mean()" was replaced by "Mean"
7. The term "std()" was replaced by "Std"
8. The punctuation "-" was removed
9. The term "BodyBody" was replaced by "Body"

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. ###
The first step here was to merge the data frames `xMergedDataMeanSd`, `yMergedData` and `mergedSubject`, via the function
`cbind()`, creating a tidy data set. Then, the function `aggregate()` from the library plyr was applied in order to retrieve
the  the average of each variable in `xMergedDataMeanSd` for each activity and subject.
In the end, the final tidy dataset was exported in `.csv` and `.txt` formats.
