# CleaningDataProject

The script run_analysis.R performs the analysis on the Samsung data. The script includes all steps required to prepare the tidy data. The working directory is the "UCI HAR DAtaset" folder of the downloaded data.

The script consists of the following steps:
1. loading the train and test data from the working directory to merge them 
2. extracting the mean and std measurements to form a smaller data, labeled as dataNew
3. naming the activities in the data set, by adding to dataNew a new column for activity
4. labeling the data set with descriptive variable names by removing the dash and parentheses from the variable names
5. creating a tidy data set with the average of each measurements for each activity and each subject, by using group by and summarize functions of dplyr library.
