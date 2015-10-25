#run_analysis.R
This script does the following:
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The repository containing this script (GettingAndCleaningData) contains:
 - CodeBook.md: information about the original data set as well as the output of the `run_analysis.R` script--i.e., the `TidyDataSet.txt` file.
 - README.md: detailed description of the steps to create the `TidyDataSet.txt` file.
 - TidyDataSet.txt: a tidy extract of the original data created via `run_analysis.R`
 - run_analysis.R: the R code used to create the tidy data set from the original data set.

##Guide to Creating the Tidy Data File
 1. Download the smart phone data to a local file:
    * You can manually download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. This should be saved to a folder called "Data" that is in the directory you will use as your Working Directory in R.
    * Alternatively, there is code for downloading and unzipping the original data in the script that is commented out (between the rows of asterisks). If you uncomment out this code the file will be downloaded and saved programmatically.
 2. Save the R script called `run_analysis.R` to your working directory as well--NOT within the Data subfolder.
 3. Open R and set the working directory.
 4. The `run_analysis.R` script uses the dplyr package, so if you do not already have this package installed you must install it prior to running the script. You can install the package by running `install.packages("plyr")` from the console prompt. If this package is already installed move to step 5.
 5. Run `run_analysis.R` from the console prompt via `source("run_analysis.R")`
 6. The file `TidyDataSet.txt` will be created in the working directory.

##Guide to run_analysis.R Code
###Prestaging Steps
Load the `dplyr` package that will be used in this script
`library(dplyr)`
####Optional Code
The following script is currently commented out, but if enabled will download the data source and save it in a folder called *data* in the working directory
 1. Create a data folder (if one does not already exist) to store download
`if(!file.exists("./data")){dir.create("./data")}`

 2. Download data files and unzip them
`fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"`
`download.file(fileURL,"./data/dataset.zip",mode = "wb")`
`utils::unzip("./data/dataset.zip", exdir = "./data")`

####Load the testing and training data files into R
`subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)`
`subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)`

`labels_train <- read.table("data/UCI HAR Dataset/train/y_train.txt",header = FALSE)`
`labels_test <- read.table("data/UCI HAR Dataset/test/y_test.txt",header = FALSE)`

`sets_train <- read.table("data/UCI HAR Dataset/train/x_train.txt",header = FALSE)`
`sets_test <- read.table("data/UCI HAR Dataset/test/X_test.txt",header = FALSE)`

####Load the features and activity labels
`features <- read.table("data/UCI HAR Dataset/features.txt")`
`activity_labels <- read.table("data/UCI HAR Dataset/activity_labels.txt", header = FALSE)`

###STEP 1: Merges the training and the test sets to create one data set.
`subject <- rbind(subject_train, subject_test)`
`colnames(subject) <- "subject"`

`labels <- rbind(labels_train, labels_test)`
`colnames(labels) <- "activityid"`

`sets <- rbind(sets_train, sets_test)`
`features <- arrange(features,V1)`
`colnames(sets) <- t(features[2])`

Merge all three datasets 
`dat <- cbind(subject, labels, sets)`


###STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
Get all the column numbers corresponding to the columns with "mean" or "std" in their label
`ms_cols <- grep("*mean*|*std*", colnames(dat), ignore.case=TRUE)`

Create a new data.frame containing only subject (1), activityid (2), and mean or standard dev columns (ms_cols)
`ms_dat <- dat[,c(1,2,ms_cols)]`


###STEP 3: Uses descriptive activity names to name the activities in the data set
Assign column names to activity_lables data.frame
`colnames(activity_labels) <- c("activityid","activity")`
`ms_dat <- merge(activity_labels,ms_dat,by.x = "activityid",by.y = "activityid",all=TRUE)`

###STEP 4: Appropriately label the data set with descriptive variable names. 
Change the labels to title case for easier readability. Replace abbreviation with full words. Exception is standard deviation -- changed to StDev to save space.
`names(ms_dat) <- gsub("Acc", "Accelerometer", names(ms_dat), ignore.case = TRUE)`
`names(ms_dat) <- gsub("angle", "Angle", names(ms_dat), ignore.case = TRUE)`
`names(ms_dat) <- gsub("BodyBody", "Body", names(ms_dat), ignore.case = TRUE)`
`names(ms_dat) <- gsub("tBody", "TimeBody", names(ms_dat), ignore.case = TRUE)`
`names(ms_dat) <- gsub("Gyro", "Gyroscope", names(ms_dat), ignore.case = TRUE)`
`names(ms_dat) <- gsub("Mag", "Magnitude", names(ms_dat), ignore.case = TRUE)`
`names(ms_dat) <- gsub("freq", "Frequency", names(ms_dat), ignore.case = TRUE)`
`names(ms_dat) <- gsub("gravity", "Gravity", names(ms_dat), ignore.case = TRUE)`
`names(ms_dat) <- gsub("mean", "Mean", names(ms_dat), ignore.case = TRUE)`
`names(ms_dat) <- gsub("std", "StDev", names(ms_dat), ignore.case = TRUE)`

If first letter is a lower case "t" or "f" change to Time or Frequency, respectively
`names(ms_dat) <- gsub("^t", "Time", names(ms_dat))`
`names(ms_dat) <- gsub("^f", "Frequency", names(ms_dat))`

Remove non-letter characters
`names(ms_dat) <- gsub("-","",names(ms_dat))`
`names(ms_dat) <- gsub(",","",names(ms_dat))`
`names(ms_dat) <- gsub("\\(","",names(ms_dat))`
`names(ms_dat) <- gsub("\\)","",names(ms_dat))`


###STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Change subject from an integer to a factor (note activity is already a factor)
`ms_dat$subject <- as.factor(ms_dat$subject)`

Aggregate ms_dat data.frame by subject and activity and take mean of other variables
`tidy_dat <- aggregate(. ~subject + activity, ms_dat, mean)`

Sort data by subject then by activityid
`tidy_dat <- tidy_dat[order(tidy_dat$subject,tidy_dat$activityid),]`

Export tidy data set to working directory
`write.table(tidy_dat, file = "TidyDataSet.txt", row.names = FALSE)`
