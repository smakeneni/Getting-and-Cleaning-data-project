The run_analysis.R program executes all the steps necessary to do the analysis defined by the course project. The library(plyr) is required to run this program 

1) First, the data is downloaded to the current working directory using download.file and unzipped. Then, the data is read into different variables 
3) rbind is used to merge similar data. Data with similar columns and same entities.
4) Then we extract measurements of only columns with mean and standard deviation measures. After extracting these columns, they are given correct names from features.txt
5) Activity names and IDs are read from activity_labels.txt and then substituted in the dataset
6) Column names are then corrected
7) In the last step, a new data set called "tidy_text.dat" is generated with all the average measures for each subject and activity type.


Variables in the script

a) xtrain, ytrain, subjecttrain, xtest, ytest, subjecttest contain the raw data 

b) all_xdata,all_ydata,all_subjectdata contain all the merged data from both the training and test datasets

c) features contains names for all_xdata datset, mean_std_features contains column names with mean() or std(). The names from features are applied to column names 
stored in mean_std_features

d) Similar method is used with activity names usin the activities variable

e) alldata contains all the merged data from all_xdata,all_ydata, and all_subjectdata

f) averagesdata contains all the average values which are then used to write out the tidy_data.txt output file. ddply() from the plyr package is
used to apply colMeans() function to calculate the average values.


Variables in the final output(tidy_data.txt)

Contains 180 observations of 81 variables seperated by space

subject : Integer from 1 to 30
Activity: "walking" "walking upstairs" "walking downstairs" "sitting" "standing" "laying"

Mean and Stddev of the following variables were extracted

tBodyAcc.XYZ
tGravityAcc.XYZ
tBodyAccJerk.XYZ
tBodyGyro.XYZ
tBodyGyroJerk.XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc.XYZ
fBodyAccJerk.XYZ
fBodyGyro.XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag
