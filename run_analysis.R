run_analysis <- function() {
  
  library(dplyr)
  
  testdata <- read.table("X_test.txt")
  traindata <- read.table("X_train.txt")
  
  ## Link activity to the data using activity label file y_test and
  ## y-train. Insert a new variable "Activity" as the first variable
  
  testlabel <- read.table("y_test.txt")
  trainlabel <- read.table("y_train.txt")

  testdata$Activity = testlabel[ ,1]
  testdata <- testdata %>% select(Activity, everything())
  traindata$Activity = trainlabel[ ,1]
  traindata <- traindata %>% select(Activity, everything())
  
  ## change activity field to descriptive names by using 
  ## descriptive names in activity_labels file
  
  activitylabel <- read.table("activity_labels.txt")
  
  testdata$Activity = activitylabel[testdata$Activity,2]
  traindata$Activity = activitylabel[traindata$Activity,2]
  
  ## link subject to the data by using the subject file
  ## Insert a new variable "Subject" as the first variable
  
  testsubject <- read.table("subject_test.txt")
  trainsubject <- read.table("subject_train.txt")

  testdata$Subject = testsubject[ ,1]
  testdata <- testdata %>% select(Subject, everything())
  traindata$Subject = trainsubject[ ,1]
  traindata <- traindata %>% select(Subject, everything())  
  
  ## Merge Test and Train data sets into one data set
  
  binddata <- merge(traindata, testdata, all=TRUE)
  
  ## Label the features with descriptive variable name by using the 
  ## feature file
  
  features <- read.table("features.txt")
  features <- features[,2]
  features <- c("Subject", "Activity", features)
  names(binddata) <- features
  
  ## Extracts only the measurements on the mean and standard 
  ## deviation for each measurement
  
  meancol <- grepl("mean\\(\\)", features)
  stdcol <- grepl("std", features)
  meanstdcol <- meancol | stdcol
  outcome <- binddata[ , meanstdcol]
  
  outcome$Subject = binddata$Subject
  outcome$Activity = binddata$Activity
  outcome <- outcome %>% select(Subject, Activity, everything())
  
  ## Clean up the variable names by removing "()" and replace "-"
  ## with "_" from the variable names
  
  names(outcome) <- sub("mean\\(\\)", "mean", names(outcome))
  names(outcome) <- sub("std\\(\\)", "std", names(outcome))
  names(outcome) <- gsub("-", "_", names(outcome))
  
  ## Create a new data set by the averaging each variable for 
  ## each activity and each subject. 
  
  newdata <- outcome %>% group_by(Subject, Activity)
  newdata <- newdata %>% summarise_if(is.numeric, mean)
  
  ## Generate a file and save as "TidyData.txt"
  
  write.table(newdata, "TidyData.txt")

}