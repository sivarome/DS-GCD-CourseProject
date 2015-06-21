# The code book

This document provides information about the tidy dataset that is generated using the run_analysis.R script.

## Following information is present in the tidy dataset

### 1. Subject

The source data contains the sensor measurements collected from the Samsung Galaxy devide. The experiment is conducted on 30 subjects each of them are identified using the *subject_id*. The values ranges from 1 to 30.

### 2. Activity

Each record in the data has one observation for a given subject and activity. An activity can be any of the following, and is identified using the *activity* field in the dataset:

- WALKING
- WALKING_UPSTAIRS
- WALKING_DOWNSTAIRS
- SITTING
- STANDING
- LAYING

### 3. Measurements

The original measurements were calculated using the primary measurements collected from the device sensors (accelerometer & gyroscope). There are several mearurements in the source dataset, which are derived using these primary measurements. Only the measurements on the mean and the standard deviation are used for creating this tidy dataset. These measurements can be identified by the columns containing the word *Mean* and *Std*.

Following are the fields from the tidy dataset, which contains the *Mean* values. For representation purpose some fields are grouped into XYZ (read this as 3 different fields, one for X axis, one for Y axis and the other for Z axis).
- Time.BodyAcc.Mean.XYZ
- Time.BodyAcc.Mean.XYZ
- Time.BodyAcc.Mean.XYZ
- Time.BodyAcc.Mean.XYZ
- Time.BodyGyroJerk.Mean.XYZ
- Time.BodyGyroJerk.Mean.XYZ
- Time.BodyGyroJerk.Mean.XYZ
- Time.BodyGyroJerk.Mean.XYZ
- Time.BodyAccMag.Mean..
- Time.GravityAccMag.Mean..
- Time.BodyAccJerkMag.Mean..
- Time.BodyGyroMag.Mean..
- Time.BodyGyroJerkMag.Mean..
- Frequency.BodyAccMag.Mean..
- Frequency.BodyBodyAccJerkMag.Mean..
- Frequency.BodyBodyGyroMag.Mean..
- Frequency.BodyBodyGyroJerkMag.Mean..

The fields prefixed with *Time* represents the time, and the fields starting with *Frequency* represents the frequency domain signals. The measuring device can be identified by *Acc* - for Accelerometer and *Gyro* - for Gyroscope. All the values are aggregated for a given subject and activity.

Similar set of fields are present for the measurements containing Standard deviation with same naming convention.

Note: All measurements are normalized and bounded within [-1,1].

To know more about how the data is transformed, please check the data analysis in README.md file, and the detailed instructions in run_analysis.R script file.