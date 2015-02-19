###  THis script does the following. 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the average of 
#  each variable for each activity and each subject.
library("plyr")

activity_label  <- read.table("UCI_HAR_Dataset/activity_labels.txt", sep=" ")
colnames(activity_label) <- c("activity_id", "activity")
features_label  <- read.table("UCI_HAR_Dataset/features.txt", sep=" ")
colnames(features_label) <- c("feature_id", "feature")
# Now read the train data
train_x_o <- read.table("UCI_HAR_Dataset/train/X_train.txt")
# Set the col names 
train_x <- train_x_o
colnames(train_x) <- features_label$feature
# filter out only the mean and std deviation colums
filter_cols <- grep("(mean|std)", colnames(train_x))
# Get only these cols and filter out the rest
train_x <- train_x[, filter_cols]

# train_y has the activity IDS
train_y <- read.table("UCI_HAR_Dataset/train/Y_train.txt")
colnames(train_y) <- "activity_id"
# subj has the subject_id
train_subj_x <- read.table("UCI_HAR_Dataset/train/subject_train.txt")
colnames(train_subj_x) <- "subject_id"
# bind these for merge later
train_x <- cbind(train_x, train_subj_x, train_y)
# now add the activity label 
train_x <- merge(train_x, activity_label, x.by="activity_id", y.by=activity_id)


## Do the same for test data
# Now read the train data
test_x_o <- read.table("UCI_HAR_Dataset/test/X_test.txt")
# Set the col names 
test_x <- test_x_o
colnames(test_x) <- features_label$feature
# filter out only the mean and std deviation colums. This was calculated b4
# filter_cols <- grep("(mean|std)", colnames(train_x))
# Get only these cols and filter out the rest
test_x <- test_x[, filter_cols]

# test_y has the activity IDS
test_y <- read.table("UCI_HAR_Dataset/test/Y_test.txt")
colnames(test_y) <- "activity_id"
# subj has the subject_id
test_subj_x <- read.table("UCI_HAR_Dataset/test/subject_test.txt")
colnames(test_subj_x) <- "subject_id"
# bind these for merge later
test_x <- cbind(test_x, test_subj_x, test_y)
# now add the activity label 
test_x <- merge(test_x, activity_label, x.by="activity_id", y.by=activity_id)
## now we have test_x and train_x that have data for different subjects. 
## we just put them together and sort
t_x <- rbind(test_x, train_x)
t_x <- arrange(t_x, t_x$subject_id, t_x$activity_id)

##  Now split the merged data by subject_id and activity
df <- ddply(t_x[, 1:81], .(subject_id,activity_id),  colwise(mean))
write.table(df, file="summary.txt", row.name=FALSE)


             