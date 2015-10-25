## Load packages that will be used in this script
library(dplyr)

## Create a data folder (if one does not already exist) to store download
if(!file.exists("./data")){dir.create("./data")}

## Download data files and unzip them
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,"./data/dataset.zip",mode = "wb")
utils::unzip("./data/dataset.zip", exdir = "./data")

## Load the testing and training data files into R
subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)

labels_train <- read.table("data/UCI HAR Dataset/train/y_train.txt",header = FALSE)
labels_test <- read.table("data/UCI HAR Dataset/test/y_test.txt",header = FALSE)

sets_train <- read.table("data/UCI HAR Dataset/train/x_train.txt",header = FALSE)
sets_test <- read.table("data/UCI HAR Dataset/test/X_test.txt",header = FALSE)

## Load the features and activity labels
features <- read.table("data/UCI HAR Dataset/features.txt")
activity_labels <- read.table("data/UCI HAR Dataset/activity_labels.txt", header = FALSE)

## STEP 1: Merges the training and the test sets to create one data set.
subject <- rbind(subject_train, subject_test)
colnames(subject) <- "subject"

labels <- rbind(labels_train, labels_test)
colnames(labels) <- "activityid"

sets <- rbind(sets_train, sets_test)
features <- arrange(features,V1)
colnames(sets) <- t(features[2])

# Merge all three datasets 
dat <- cbind(subject, labels, sets) 


## STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
#get all the column numbers corresponding to the columns with "mean" or "std" in their label
ms_cols <- grep("*mean*|*std*", colnames(dat), ignore.case=TRUE)

#Create a new data.frame containing only subject (1), activityid (2), and mean or standard dev columns (ms_cols)
ms_dat <- dat[,c(1,2,ms_cols)]


## STEP 3: Uses descriptive activity names to name the activities in the data set
#assign column names to activity_lables data.frame
colnames(activity_labels) <- c("activityid","activity")
ms_dat <- merge(activity_labels,ms_dat,by.x = "activityid",by.y = "activityid",all=TRUE)

## STEP 4: Appropriately label the data set with descriptive variable names. 
#Change the labels to title case for easier readability
#Replace abbreviation with full words. Exception is standard deviation -- changed to StDev to save space
names(ms_dat) <- gsub("Acc", "Accelerometer", names(ms_dat), ignore.case = TRUE)
names(ms_dat) <- gsub("angle", "Angle", names(ms_dat), ignore.case = TRUE)
names(ms_dat) <- gsub("BodyBody", "Body", names(ms_dat), ignore.case = TRUE)
names(ms_dat) <- gsub("tBody", "TimeBody", names(ms_dat), ignore.case = TRUE)
names(ms_dat) <- gsub("Gyro", "Gyroscope", names(ms_dat), ignore.case = TRUE)
names(ms_dat) <- gsub("Mag", "Magnitude", names(ms_dat), ignore.case = TRUE)
names(ms_dat) <- gsub("freq", "Frequency", names(ms_dat), ignore.case = TRUE)
names(ms_dat) <- gsub("gravity", "Gravity", names(ms_dat), ignore.case = TRUE)
names(ms_dat) <- gsub("mean", "Mean", names(ms_dat), ignore.case = TRUE)
names(ms_dat) <- gsub("std", "StDev", names(ms_dat), ignore.case = TRUE)

#if first letter is a lower case "t" or "f" change to Time or Frequency, respectively
names(ms_dat) <- gsub("^t", "Time", names(ms_dat))
names(ms_dat) <- gsub("^f", "Frequency", names(ms_dat))

#Remove non-letter characters
names(ms_dat) <- gsub("-","",names(ms_dat))
names(ms_dat) <- gsub(",","",names(ms_dat))
names(ms_dat) <- gsub("\\(","",names(ms_dat))
names(ms_dat) <- gsub("\\)","",names(ms_dat))


## STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#Change subject from an integer to a factor (note activity is already a factor)
ms_dat$subject <- as.factor(ms_dat$subject)

#aggregate ms_dat data.frame by subject and activity and take mean of other variables
tidy_dat <- aggregate(. ~subject + activity, ms_dat, mean)

#sort data by subject then by activityid
tidy_dat <- tidy_dat[order(tidy_dat$subject,tidy_dat$activityid),]

#export tidy data set to working directory
write.table(tidy_dat, file = "TidyDataSet.txt", row.names = FALSE)