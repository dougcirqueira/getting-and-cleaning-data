# Variables

The variables provided in each recorded of the dataset are related to:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

# Data
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

Therefore, the files available and their respective values units are:
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

# Transformations
The following information presents the transformations and manipulations performed by the script `run_analysis.R`, in order to 
achieve the goals of this course project.

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

