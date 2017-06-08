# Import library
library(plyr)

# Download file
filename <- "getdata_projectfiles_UCI HAR Dataset.zip"
if(!file.exists(filename)) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                destfile = filename)
  
  unzip(filename)
}

# Reading files
xTrain <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table(file = "UCI HAR Dataset/train/y_train.txt")

xTest <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
yTest <- read.table(file = "UCI HAR Dataset/test/y_test.txt")

featureNames <- read.table("UCI HAR Dataset/features.txt")

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")

subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")


# 1. Merges the training and the test sets to create one data set.
xMergedData <- rbind(xTrain, xTest)
yMergedData <- rbind(yTrain, yTest)
mergedSubject <- rbind(subjectTrain, subjectTest) 


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Attribute Names to Header
names(xMergedData) <- featureNames$V2
xMergedDataMeanSd <- xMergedData[, grepl("mean\\(\\)|std\\(\\)", names(xMergedData))]


# 3. Uses descriptive activity names to name the activities in the data set
yMergedData$V1 <- factor(yMergedData$V1, levels=c(1,2,3,4,5,6), labels=activityLabels$V2)


# 4. Appropriately labels the data set with descriptive variable names.

# Appropriately label subject
names(mergedSubject) <- "subject"

# Appropriately label Y (activity)
names(yMergedData) <- "activity"

# Appropriately label X variable names
currentNames <- names(xMergedDataMeanSd)

currentNames <- gsub("^t", "time", currentNames)
currentNames <- gsub("^f", "freq", currentNames)
currentNames <- gsub("Acc", "Accelerometer", currentNames)
currentNames <- gsub("Gyro", "Gyroscope", currentNames)
currentNames <- gsub("Mag", "Magnitude", currentNames)
currentNames <- gsub("mean\\(\\)", "Mean", currentNames)
currentNames <- gsub("std\\(\\)", "Std", currentNames)
currentNames <- gsub("-", "", currentNames)
currentNames <- gsub("BodyBody", "Body", currentNames)

names(xMergedDataMeanSd) <- currentNames


# 5. From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject

# Merge X, y and subjects
tidyDataset <- cbind(xMergedDataMeanSd, yMergedData, mergedSubject)

# Create the second tidy data set as requested, with the average of each variable
# for each activity and subject
tidyDatasetFinal <- aggregate(.~subject + activity, tidyDataset, mean)

# Export the tidy data set
write.csv(tidyDatasetFinal,file="tidyDataset.csv", row.names = F)
write.csv(tidyDatasetFinal,file="tidyDataset.txt", row.names = F)
write.table(tidyDatasetFinal,file="tidyDatasetTable.txt", row.names = F)

