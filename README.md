### run_analysis.R

## Objective:
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. 

# Data Summary
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

# Script Description
**Requirements**
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

* The train data is read first. The various measures in train_x correspond to the rows in features.txt
and the activity label is read from the activities_ label.txt. Next the columns are 
filterd by colnames that have the world "mean" in it. train_y has activity_id and train_sub_x had subject_id  for each
row in train_x. train_x  and train_y  and trian_subj_x are merged using cbind.
* The above operation is also performed for test data.
* Both test and train data obtained above is merged using rbind.
* ddply is used to get the means by subject_id and activity_id



