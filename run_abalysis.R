#I first unzipped the files and set the 'UCI HAR Dataset' folder as the working directory

#1.Load the train and test data from the working directory
train<-read.table('train/X_train.txt');
test<-read.table('test/X_test.txt');

#2.Merge the train and test data
data<-rbind(train, test);


#3.Extract the mean and std measurements
#First load the names of all measurements
measure<-read.table('features.txt');
#Second get the indices of the mean and std measurements
indices<-grep("std\\(\\)|mean\\(\\)",measure[,2]);
#Third subset the dataset unsing indices to create the new data set
dataNew<-data[,indices]
#the feature names to the names of each column of the new data 
names(dataNew)<-measure[indices,2];

#4.Name the activities in the data set
#First load the activities for the train and test data and merge them
trainActivities<-read.table('train/y_train.txt');
testActivities<-read.table('test/y_test.txt');
activities<-rbind(trainActivities,testActivities);
#Second load the the activity labels
labels<-read.table('activity_labels.txt');
#Extract into a vector the activities of the data
v<-activities[,1];
#Map the activities into their labels 
rowlabel<-labels[v,];
#Add to dataNew column that specifices the activity of each row
library(dplyr)
dataNew<-mutate(dataNew,activity=rowlabel[,2]);

#5.Labels the data set with descriptive variable names
#Remove the dash and parentheses from the column names
names(dataNew)<-gsub("-|\\(|\\)","",names(dataNew));

#6.Creates a tidy data set with the average of each variable for each activity and each subject
#Load the subject data and add the subject column to dataNew
trainSubject<-read.table('train/subject_train.txt');
testSubject<-read.table('test/subject_test.txt');
subj<-rbind(trainSubject,testSubject);
dataNew<-mutate(dataNew,subject=subj[[1]]);
#Group datat by subject and activity
dataGrouped<-group_by(dataNew,subject,activity);
#Create new tidy data
dataTidy<-summarize_all(dataGrouped,funs(mean));
#Save data
write.table(dataTidy,file="tidyData.txt",row.names=FALSE)