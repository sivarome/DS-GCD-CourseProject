# The code book

This document provides information about the actual data used for the project and the steps followed to create the tidy dataset.

## About the Source data:

For this project, an existing dataset was used, which was collected from the accelerometers from the Samsung Galaxy S smartphone. A full description of this data is available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 

Dataset used for the project: [getdata_projectfiles_UCI HAR Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Format of the source data:

There are several files that comes with the source data. Following are the files used for this project:

Metadata:
* _'features.txt'_: It contains the list of all features.
* _'activity_labels.txt'_: It links the activity labels with their activity name.

Data files:  
There are 2 sets of data. One for training, and the other for test. Following are the files for training data set. Similar files are present for test dataset.
- _'X_train.txt'_ : Measurements collected for the training data. It is a 561-feature vector with time and frequency domain variables. All the values are normalized and bounded within [-1,1].
- _'y_train.txt'_ : Activity labels for the training data.
- _'subject_train.txt'_ : Each row of this file identifies the subject who performed the activity. Its range is from 1 to 30. 

##### More about the data:

The primary data is collected using the raw signals from Accelerometer and Gyroscope of the Samsung device. There are several other derived features which uses this raw data as a base. Finally there are some aggregated features that gives measures like mean, min, max, standard deviation etc. Please see _features_info.txt_ file to get more information about the source data.

## Extracting the data:

R Scripting is used for extracting the data to local folder and a sequence of steps are executed to create the tidy data.

Command used for extracting the source files (all the variables should be preset):

```
#to download the file from sourceUrl to a local file, sourceFile
download.file(sourceUrl, sourceFile) 

#to unzip the file contents to a local folder
unzip(sourceFile, exdir = targetFolder)

#to read the data into data frames
features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE)
```

## Design

Following steps are followed to transform the data into a tidy dataset:

#### 1. Merge the training and the test sets to create one data set.

Training and test datasets are individually extracted and binded into a single dataset using the cbind() and rbind() functions. After merging the data, column names are provided for all measurements using the features.txt as a reference. make.names() function is used to derive valid and unique column names.


#### 2. Extract only the measurements on the mean and standard deviation for each measurement. 

The source dataset contain 561 features for each activity. For this project, only the measurements on mean and standard deviation are used. The required fields are selected using the select() function. The restriction is provided using the contains() argument. All the columns that contain the word "mean" and "std" are selected. This gives 66 measurements containing the mean and standard deviation.

#### 3. Use descriptive activity names to name the activities in the data set

Activity names are stored in a separate file. The dataset from step 2 is merged with this activity_label data to get the activity name using a join based on the activity_id.

While 

#### 4. Appropriately label the data set with descriptive variable names.

Following substitutions are made to the column names to provide better names for the features:

  - Column names starting with "t", substituted to "Time."
  - Column names starting with "f", substituted to "Frequency."
  - Column name containig "...X", substituted with ".X" (same rule for "...Y" and "...Z"
  - Column name containing ".mean", substituted with ".Mean"
  - Column name containing ".std", substituted with ".Std"
  
The modified column names are applied to the final data set.

#### 5. Create an independent tidy data set with the average of each variable for each activity and each subject.

Dataset from above step is transformed into another tidy dataset with average of each variable grouped by subject and activity.

dpply() and numcolwise() functions are used to generate the new tidy dataset.

```
new_tidy_data <- ddply(new_selected_data, .(subject_id,activity), numcolwise(mean))
```


## Source code

The above mentioned steps are implemented in R programming. The source code is available in the repository as _run_analysis.R_. At the end of the process, the script will a tidy dataset and saves the file the working directory as _tidy_aggregated_UCI_HAR_Dataset.txt_.