## Project Description
Data from the Human Activity Recognition Using Smartphones Dataset
Version 1.0 was sourced and modified to create a tidy data set.

##Study design and data processing

###Collection of the raw data
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

Data (zip file) is located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###Notes on the original (raw) data 
The original data set contains the following for each record:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The original dataset includes the following files:
 - 'README.txt'
 - 'features_info.txt': Shows information about the variables used on the feature vector.
 - 'features.txt': List of all features.
 - 'activity_labels.txt': Links the class labels with their activity name.
 - 'train/X_train.txt': Training set.
 - 'train/y_train.txt': Training labels.
 - 'test/X_test.txt': Test set.
 - 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
 - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
 - 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
 - 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
 - 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
 - Features are normalized and bounded within [-1,1].
 - Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

##Creating the tidy datafile

###Guide to creating the tidy data file
 1. Download the smart phone data to a local file:
    * You can manually download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. This should be saved to a folder called "Data" that is in the directory you will use as your Working Directory in R.
    * Alternatively, there is code for downloading and unzipping the original data in the script that is commented out (between the rows of asterisks). If you uncomment out this code the file will be downloaded and saved programmatically.
 2. Save the R script called `run_analysis.R` to your working directory as well--NOT within the Data subfolder.
 3. Open R and set the working directory.
 4. The `run_analysis.R` script uses the dplyr package, so if you do not already have this package installed you must install it prior to running the script. You can install the package by running `install.packages("plyr")` from the console prompt. If this package is already installed move to step 5.
 5. Run `run_analysis.R` from the console prompt via `source("run_analysis.R")`
 6. The file `TidyDataSet.txt` will be created in the working directory.

###Cleaning of the data
The script run_analysis.R does the following:
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

For more information please see the README file: https://github.com/schoda01/GettingAndCleaningData/blob/master/README.md

##Description of the variables in the TidyDataSet.txt file
TidyDataSet.txt is a a space-delimited text file. The first row contains the field names for the variables. There are a total of 180 observations (30 subjects by 6 activities) and 86 variables containing information on the mean and standard deviation variables.

Below is a summary of the variables in TidyDataSet.txt:
 1. subject: Factor w/ 30 levels (integers between 1 and 30)
 2. activity: Factor w/ 6 levels (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
 3. activityid: num w/ 6 levels (integers between 1 and 6)
 4. TimeBodyAccelerometerMeanX: num
 5. TimeBodyAccelerometerMeanY: num
 6. TimeBodyAccelerometerMeanZ: num
 7. TimeBodyAccelerometerStDevX: num
 8. TimeBodyAccelerometerStDevY: num
 9. TimeBodyAccelerometerStDevZ: num
 10. TimeGravityAccelerometerMeanX: num
 11. TimeGravityAccelerometerMeanY: num
 12. TimeGravityAccelerometerMeanZ: num
 13. TimeGravityAccelerometerStDevX: num
 14. TimeGravityAccelerometerStDevY: num
 15. TimeGravityAccelerometerStDevZ: num
 16. TimeBodyAccelerometerJerkMeanX: num
 17. TimeBodyAccelerometerJerkMeanY: num
 18. TimeBodyAccelerometerJerkMeanZ: num
 19. TimeBodyAccelerometerJerkStDevX: num
 20. TimeBodyAccelerometerJerkStDevY: num
 21. TimeBodyAccelerometerJerkStDevZ: num
 22. TimeBodyGyroscopeMeanX: num
 23. TimeBodyGyroscopeMeanY: num
 24. TimeBodyGyroscopeMeanZ: num
 25. TimeBodyGyroscopeStDevX: num
 26. TimeBodyGyroscopeStDevY: num
 27. TimeBodyGyroscopeStDevZ: num
 28. TimeBodyGyroscopeJerkMeanX: num
 29. TimeBodyGyroscopeJerkMeanY: num
 30. TimeBodyGyroscopeJerkMeanZ: num
 31. TimeBodyGyroscopeJerkStDevX: num
 32. TimeBodyGyroscopeJerkStDevY: num
 33. TimeBodyGyroscopeJerkStDevZ: num
 34. TimeBodyAccelerometerMagnitudeMean: num
 35. TimeBodyAccelerometerMagnitudeStDev: num
 36. TimeGravityAccelerometerMagnitudeMean: num
 37. TimeGravityAccelerometerMagnitudeStDev: num
 38. TimeBodyAccelerometerJerkMagnitudeMean: num
 39. TimeBodyAccelerometerJerkMagnitudeStDev: num
 40. TimeBodyGyroscopeMagnitudeMean: num
 41. TimeBodyGyroscopeMagnitudeStDev: num
 42. TimeBodyGyroscopeJerkMagnitudeMean: num
 43. TimeBodyGyroscopeJerkMagnitudeStDev: num
 44. FrequencyBodyAccelerometerMeanX: num
 45. FrequencyBodyAccelerometerMeanY: num
 46. FrequencyBodyAccelerometerMeanZ: num
 47. FrequencyBodyAccelerometerStDevX: num
 48. FrequencyBodyAccelerometerStDevY: num
 49. FrequencyBodyAccelerometerStDevZ: num
 50. FrequencyBodyAccelerometerMeanFrequencyX: num
 51. FrequencyBodyAccelerometerMeanFrequencyY: num
 52. FrequencyBodyAccelerometerMeanFrequencyZ: num
 53. FrequencyBodyAccelerometerJerkMeanX: num
 54. FrequencyBodyAccelerometerJerkMeanY: num
 55. FrequencyBodyAccelerometerJerkMeanZ: num
 56. FrequencyBodyAccelerometerJerkStDevX: num
 57. FrequencyBodyAccelerometerJerkStDevY: num
 58. FrequencyBodyAccelerometerJerkStDevZ: num
 59. FrequencyBodyAccelerometerJerkMeanFrequencyX: num
 60. FrequencyBodyAccelerometerJerkMeanFrequencyY: num
 61. FrequencyBodyAccelerometerJerkMeanFrequencyZ: num
 62. FrequencyBodyGyroscopeMeanX: num
 63. FrequencyBodyGyroscopeMeanY: num
 64. FrequencyBodyGyroscopeMeanZ: num
 65. FrequencyBodyGyroscopeStDevX: num
 66. FrequencyBodyGyroscopeStDevY: num
 67. FrequencyBodyGyroscopeStDevZ: num
 68. FrequencyBodyGyroscopeMeanFrequencyX: num
 69. FrequencyBodyGyroscopeMeanFrequencyY: num
 70. FrequencyBodyGyroscopeMeanFrequencyZ: num
 71. FrequencyBodyAccelerometerMagnitudeMean: num
 72. FrequencyBodyAccelerometerMagnitudeStDev: num
 73. FrequencyBodyAccelerometerMagnitudeMeanFrequency: num
 74. FrequencyBodyAccelerometerJerkMagnitudeMean: num
 75. FrequencyBodyAccelerometerJerkMagnitudeStDev: num
 76. FrequencyBodyAccelerometerJerkMagnitudeMeanFrequency: num
 77. FrequencyBodyGyroscopeMagnitudeMean: num
 78. FrequencyBodyGyroscopeMagnitudeStDev: num
 79. FrequencyBodyGyroscopeMagnitudeMeanFrequency: num
 80. FrequencyBodyGyroscopeJerkMagnitudeMean: num
 81. FrequencyBodyGyroscopeJerkMagnitudeStDev: num
 82. FrequencyBodyGyroscopeJerkMagnitudeMeanFrequency: num
 83. AngleTimeBodyAccelerometerMeanGravity: num
 84. AngleTimeBodyAccelerometerJerkMeanGravityMean: num
 85. AngleTimeBodyGyroscopeMeanGravityMean: num
 86. AngleTimeBodyGyroscopeJerkMeanGravityMean: num
 87. AngleXGravityMean: num
 88. AngleYGravityMean: num
 89. AngleZGravityMean: num
