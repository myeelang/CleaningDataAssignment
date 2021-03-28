# CleaningDataAssignment
All the data files needed should be in the "working directory" where the function run_analysis will be run including: x_test.txt, y_test.txt, x_train.txt, y_train.txt, subject_test.txt, subject_train.txt, features.txt, activity_labels.txt

The package "dplyr" should have been installed before runnng the function and the run_analysis will load the package

No parameter is needed for the funciton run_analysis to run and the resulting data set will be created in the "working directory"

The following are steps used for cleaning the data

a. The 6 activities in y_test and y_train files were linked to respective feature measurement in x_test and x_train files by creating a new varaible called "Activity".

b. By using "dplyr" package, the "Activity" variable was re-arranged as the first variable in the test and train data sets.

c. The IDs in "Activity" field were also replaced with descriptive activity names by using the "activity_labels" file

e. Similar to the activities, the subjects of the test and train data were linked to respective activity and feature measument using the subject file provided

f. A new variable called "Subject" was created and re-arranged as the first variable, with "Activity" now became the second variable.

g. The test and train data sets were then merged into one data set.

h. The descriptive labels of the features were used for the names of the feature variable of the data sets by using names specified in the features file

i. Extract only mean and standard deviations of each measurement in the resulting data set.

j. Clean up the names of the feature description by removing brackets and replacing dash with underscore.

k. Create a new data set by averaging each variable for each activity and each subject.

l. Save the data set created to a new file named "TidyData.txt"
