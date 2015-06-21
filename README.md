# DS-GCD-CourseProject

The purpose of this project is to demonstrate how to prepare a tidy dataset from a given dataset. 

For this project, an existing dataset was used, which was collected from the accelerometers from the Samsung Galaxy S smartphone. A full description of this data is available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 

Dataset used for the project: [getdata_projectfiles_UCI HAR Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)



Following files are created for this project:

* CodeBook.md ( a code book that describes the variables, the data, and any transformations or work that was performed to clean up the data )
* run_analysis.R ( script to create a tidy data set )
* tidy_aggregated_UCI_HAR_Dataset.txt ( tidy dataset created by the script )


Use following code to read this tidy dataset using R:

```
tidy_data <- read.table ("tidy_aggregated_UCI_HAR_Dataset.txt", header=TRUE)
```


#### Citation to the Dataset: 

Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012 (Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz)