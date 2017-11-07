library(plyr)
#####First step: Downloading data

if(!file.exists("UCI HAR Dataset.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","UCI HAR Dataset.zip", mode = "wb")
}

#unzipping the downloaded file

filename<-"UCI HAR Dataset"
if(!file.exists(filename)) {
  unzip("UCI HAR Dataset.zip")
}

####Second step: Reading the data and merging the training and testing sets

xtrain <- read.table(file.path(filename,"train", "x_train.txt"))
xtest <- read.table(file.path(filename,"test","x_test.txt"))
ytrain <- read.table(file.path(filename,"train","y_train.txt"))
ytest <- read.table(file.path(filename,"test","y_test.txt"))
subjecttrain <- read.table(file.path(filename,"train","subject_train.txt"))
subjecttest <- read.table(file.path(filename,"test","subject_test.txt"))

#merging x data
all_xdata<-rbind(xtrain,xtest)

#merging y data
all_ydata<-rbind(ytrain,ytest)

#merging subject data
all_subjectdata<-rbind(subjecttrain,subjecttest)

#### Third step: Extracting the mean and standard deviation measurements for each measurement

#reading features
features <- read.table(file.path(filename,"features.txt"))

#grepping for columnnames  with mean() and std()
mean_std_features <-grep("-(mean|std)\\(\\)",features[,2])

#subsetting the desired columns 
all_xdata<-all_xdata[,mean_std_features]

#fixing the column names
names(all_xdata)<-features[mean_std_features,2]

#### Fourth step: Use descriptive activity names to name the activities in data set

activities<-read.table(file.path(filename,"activity_labels.txt"))

#update values with the right activity names
all_ydata[,1]<-activities[all_ydata[,1],2]

#assigning column name 
names(all_ydata)<-"activity"


#### Fifth step: Appropriately label data set with descriptive variable names

#assigning column name 
names(all_subjectdata)<-"subject"

#combining all data sets 
alldata<-cbind(all_xdata,all_ydata,all_subjectdata)

#### Sixth step: Creating a new tidy data set with average of each variable for each activity and each subject

#averaging 
averagesdata<-ddply(alldata,.(subject,activity),function(x) colMeans(x[,1:66]))

#writing a new data set 
write.table(averagesdata,"tidy_data.txt",row.name=FALSE)
