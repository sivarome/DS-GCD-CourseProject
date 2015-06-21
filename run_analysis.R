
# Course project
  
# Dataset used:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# The script creates a tidy dataset through following steps: 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#=============== initial set up ======================

## dplyr & plyr packages are needed, install the packagees if needed
if (!is.element("dplyr",installed.packages()) ) {install.packages("dplyr")}
if (!is.element("plyr",installed.packages()) ) {install.packages("plyr")}
library(dplyr)
library(plyr)

sourceUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
sourceFile <- "getdata_projectfiles_UCI HAR Dataset.zip"

workDir <- "ProjectWD"
rootDir <- getwd()

if (!file.exists(sourceFile)) {
  download.file(sourceUrl, sourceFile)
}

if (!file.exists(workDir)) {
  dir.create(workDir)
}

unzip(sourceFile, exdir = paste("./",workDir,sep=""))

setwd(workDir)

#=========== Downloading the data files ==================

 activity_label <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)
  colnames(activity_label) <- c("activity_id","activity")
 
 features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE)
  colnames(features) <- c("feature_id","feature")

 subject_train <- read.table ("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
 measurements_train <- read.table ("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
 activity_train <- read.table ("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
 subject_test <- read.table ("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
 measurements_test <- read.table ("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
 activity_test <- read.table ("./UCI HAR Dataset/test/y_test.txt", header=FALSE)

#========== 1. Merging the training and test data sets ==============

 ### Step 1a) create single training dataset by binding subject, activity & measurements data
 training_data <- cbind(subject_train, activity_train, measurements_train)

 ### Step 1b) create single test dataset by binding subject, activity & measurements data
 test_data <- cbind(subject_test, activity_test, measurements_test)

 ### Step 1c) Merge training and test datasets
 merged_source_data <- rbind(training_data, test_data)

 measurement_names <- make.names(names=features[,2], unique=TRUE, allow_ = TRUE)
 colnames(merged_source_data) <- c("subject_id", "activity_id", measurement_names)

#===== 2. Extracts only the measurements on the mean and standard deviation for each measurement. === 

  selected_data  <- select(merged_source_data, subject_id, activity_id, contains("mean..",ignore.case=FALSE), contains("std.."))
  
#====== 3. Uses descriptive activity names to name the activities in the data set =========

 ### Step 3a) Merge the selected_data with activity_label using activity_id
  ## Step 3b) Select all columns except activity_id in proper order
   new_selected_data <- merge(selected_data, activity_label, by="activity_id") %>%
                        select (subject_id, activity, contains("mean.."), contains("std.."))

#======== 4. Appropriately labels the data set with descriptive variable names.======= 

 ## Step 4a) Retrieve surrent column names
  data_colnames <- colnames(new_selected_data)

 ## Step 4b) Substitute text in the column names as given below
  ## If name starts with "t", substitute to "Time."
  ## If name starts with "f", substitute to "Frequency."
  ## "...X" substituted with ".X" (same rule for y & Z)
  ## ".mean" with ".Mean"
  ## ".std" with ".Std"
  data_colnames <- gsub("^t","Time.",data_colnames)
  data_colnames <- gsub("^f","Frequency.",data_colnames)
  data_colnames <- gsub("...X",".X",data_colnames)
  data_colnames <- gsub("...Y",".Y",data_colnames)
  data_colnames <- gsub("...Z",".Z",data_colnames)
  data_colnames <- gsub(".mean",".Mean",data_colnames)
  data_colnames <- gsub(".std",".Std",data_colnames)

 ## Step 4c) Rename the dataset's columns with the new column names
  colnames(new_selected_data) <- data_colnames

#================ 5. Create new tidy data set =========================
# with the average of each variable for each activity and each subject

  new_tidy_data <- ddply(new_selected_data,.(subject_id,activity),numcolwise(mean))

setwd(rootDir)
write.table(new_tidy_data, file="tidy_aggregated_UCI_HAR_Dataset.txt", row.name=FALSE)

# =================== clean up ==================

#Delete the temporary folder including the data files
unlink(workDir, recursive=TRUE)

#Close all connections before ending the process
closeAllConnections()

rm(list = ls())
