  ## run_analysis.R- Sanjeev Sinha

  library(reshape2) 


  features <- c(1, 2, 3, 4, 5, 6, 41, 42, 43, 44, 45, 46, 81, 82, 83, 84, 85, 86, 121, 122, 123, 124, 125, 126, 161, 162, 163, 164, 165, 166, 201, 202, 214, 215, 227, 228, 240, 241, 253, 254, 266, 267, 268, 269, 270, 271, 345, 346, 347, 348, 349, 350, 424, 425, 426, 427, 428, 429, 503, 504, 516, 517, 529, 530, 542, 543) 
  featureNames <- c("tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z", "tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z", "tGravityAcc-mean()-X", "tGravityAcc-mean()-Y", "tGravityAcc-mean()-Z", "tGravityAcc-std()-X", "tGravityAcc-std()-Y", "tGravityAcc-std()-Z", "tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y", "tBodyAccJerk-mean()-Z", "tBodyAccJerk-std()-X", "tBodyAccJerk-std()-Y", "tBodyAccJerk-std()-Z", "tBodyGyro-mean()-X", "tBodyGyro-mean()-Y", "tBodyGyro-mean()-Z", "tBodyGyro-std()-X", "tBodyGyro-std()-Y", "tBodyGyro-std()-Z", "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-mean()-Z", "tBodyGyroJerk-std()-X", "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z", "tBodyAccMag-mean()", "tBodyAccMag-std()", "tGravityAccMag-mean()", "tGravityAccMag-std()", "tBodyAccJerkMag-mean()", "tBodyAccJerkMag-std()", "tBodyGyroMag-mean()", "tBodyGyroMag-std()", "tBodyGyroJerkMag-mean()", "tBodyGyroJerkMag-std()", "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y", "fBodyAcc-mean()-Z", "fBodyAcc-std()-X", "fBodyAcc-std()-Y", "fBodyAcc-std()-Z", "fBodyAccJerk-mean()-X", "fBodyAccJerk-mean()-Y", "fBodyAccJerk-mean()-Z", "fBodyAccJerk-std()-X", "fBodyAccJerk-std()-Y", "fBodyAccJerk-std()-Z", "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z", "fBodyGyro-std()-X", "fBodyGyro-std()-Y", "fBodyGyro-std()-Z", "fBodyAccMag-mean()", "fBodyAccMag-std()", "fBodyBodyAccJerkMag-mean()", "fBodyBodyAccJerkMag-std()", "fBodyBodyGyroMag-mean()", "fBodyBodyGyroMag-std()", "fBodyBodyGyroJerkMag-mean()", "fBodyBodyGyroJerkMag-std()") 
  activities <- c(1, 2, 3, 4, 5, 6) 
  activityNames <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING") 



  # Returns dataframe for data directory passed into function
  getData <- function(dir, name) { 
  
  # Data File Names for features, activities and subjects 
  dirpath <- file.path(dir, name) 
  
  
  # Read the features table. 
  featuresFilename <- file.path(dirpath, paste("X_", name, ".txt", sep = "")) 
  featuresTable <- read.table(featuresFilename)[features] 
  names(featuresTable) <- featureNames 
  
  
  cleanData <- featuresTable
  
  
  # Read the activities list. 
  activitiesFilename <- file.path(dirpath, paste("Y_", name, ".txt", sep = "")) 
  
  activitiesTable <- read.table(activitiesFilename) 
  names(activitiesTable) <- c("activity") 
  activitiesTable$activity <- factor(activitiesTable$activity, levels = activities, labels = activityNames) 
  cleanData <- cbind(cleanData, activity = activitiesTable$activity) 
  
  
  # Read the subjects list. 
  subjectsFilename <- file.path(dirpath, paste("subject_", name, ".txt", sep = "")) 
  subjectsTable <- read.table(subjectsFilename) 
  names(subjectsTable) <- c("subject") 
  cleanData <- cbind(cleanData, subject = subjectsTable$subject) 
  
  
  # Return the clean data 
  cleanData 
} 

# Performs the full analysis of both the test and train 
# datasets. Writes a clean dataset to disk. 
  
  # "Getting current working directory"
  
  dir <- getwd()
  # Read the data. 
  
  test <- getData(dir, "test") 
 
  train <- getData(dir, "train") 
  
  
  # Join the data. 
  
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
  
