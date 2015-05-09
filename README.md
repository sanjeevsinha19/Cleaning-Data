# run_analysis.R

run_analysis.R that does the following. 
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 

5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#    Program 
 use library(reshape2) 

#Extract  measurements on the mean and standard deviation for each measurement. 
  "tBodyAcc-mean()-X",   "tBodyAcc-mean()-Y",   "tBodyAcc-mean()-Z",   "tBodyAcc-std()-X",   "tBodyAcc-std()-Y",
  "tBodyAcc-std()-Z",   "tGravityAcc-mean()-X",   "tGravityAcc-mean()-Y",  "tGravityAcc-mean()-Z",   "tGravityAcc-std()-X", 
  "tGravityAcc-std()-Y",  "tGravityAcc-std()-Z",   "tBodyAccJerk-mean()-X",  "tBodyAccJerk-mean()-Y",  "tBodyAccJerk-mean()-Z",
  "tBodyAccJerk-std()-X",  "tBodyAccJerk-std()-Y",  "tBodyAccJerk-std()-Z",   "tBodyGyro-mean()-X",   "tBodyGyro-mean()-Y", 
  "tBodyGyro-mean()-Z",   "tBodyGyro-std()-X",   "tBodyGyro-std()-Y",   "tBodyGyro-std()-Z",  "tBodyGyroJerk-mean()-X", 
  "tBodyGyroJerk-mean()-Y",   "tBodyGyroJerk-mean()-Z", "tBodyGyroJerk-std()-X",  "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z", "tBodyAccMag-mean()", "tBodyAccMag-std()", "tGravityAccMag-mean()", "tGravityAccMag-std()", "tBodyAccJerkMag-mean()", "tBodyAccJerkMag-std()", "tBodyGyroMag-mean()", "tBodyGyroMag-std()", "tBodyGyroJerkMag-mean()", "tBodyGyroJerkMag-std()", "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y", "fBodyAcc-mean()-Z", "fBodyAcc-std()-X", "fBodyAcc-std()-Y", "fBodyAcc-std()-Z", "fBodyAccJerk-mean()-X", "fBodyAccJerk-mean()-Y", "fBodyAccJerk-mean()-Z", "fBodyAccJerk-std()-X", "fBodyAccJerk-std()-Y", "fBodyAccJerk-std()-Z", "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z", "fBodyGyro-std()-X", "fBodyGyro-std()-Y", "fBodyGyro-std()-Z", "fBodyAccMag-mean()", "fBodyAccMag-std()", "fBodyBodyAccJerkMag-mean()", "fBodyBodyAccJerkMag-std()", "fBodyBodyGyroMag-mean()", "fBodyBodyGyroMag-std()", "fBodyBodyGyroJerkMag-mean()", "fBodyBodyGyroJerkMag-std()") 

#Use descriptive activity names to name the activities in the data set 
 "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"


# getDate(dir, name) funtion

  Returns dataframe for data directory passed into function
  
  Parameters: dir - current working directory and name of subdirectory
  
  
  # Read the features table in to cleanData dataframe
  # Read the activities list in to cleanData dataframe. 
  # Read the subjects list in to cleanData dataframe. 
  # Return the cleanData 


# Main Program

  # "Getting current working directory"
  
 
  # call getData to Read the "test"data. 
  getData(dir, "test") 
  # call getData to Read the "test"data.
   getData(dir, "train") 
  
  # Join the test and train data. 
  
  finalData <- rbind(test, train) 
  
  
  # Reshape the data. Melting and DaCASTING
  
  long <- melt(finalData, id = c("subject", "activity")) 
  
  wide <- dcast(long, subject + activity ~ variable, mean) 
  
  
  # final Tidyup data. 
  Clean <- wide 
  
  # final tidy data file will be saved as cleanData.txt
 
  # Save the clean data -cleanData.txt
  cleanDataFile<- file.path(dir, "cleanData.txt") 
  
  write.table(Clean, cleanDataFile, row.names = FALSE, quote = FALSE) 
  
  print ( paste("Final Output file location:   " ,cleanDataFile,sep=""))
  
