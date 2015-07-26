library(dplyr)
# This script will merge the test and training data from the Human Activity Recognition Using Smartphones Dataset,
# match the subject and activity to the measurements, and cleaned up by removing unwanted columns and renaming
# columns to be more descriptive.
#
# A second data set is then created from the tidy data to create a data set containing the average of each measurements
# by activity and subject and saved as avfByActivityAndSubject.txt

runScript <- function() {
	# First we'll read the features.txt and activity_labels.txt to get the related data we need
	# Measurements names to match the columns
	features <- read.table('dataset/features.txt', header = FALSE)[[2]]
	# Activity Labels to match the activity id
	activityLabels <- read.table('dataset/activity_labels.txt', header = FALSE, col.names = c('activityID', 'activity'))
	
	
	# Test Data
	# Test subjects
	testSubjects <- read.table('dataset/test/subject_test.txt', header = FALSE, col.names = 'subjectID')
	# Test activities
	testActivities <- read.table('dataset/test/Y_test.txt', header = FALSE, col.names = 'activityID')
	#  Retrieving the test data and adding the sibject and activity data to it
	test <- cbind(read.table('dataset/test/X_test.txt', header = FALSE, col.names = features), testSubjects, testActivities)
	
	# Training Data
	# Training subjects
	trainSubjects <- read.table('dataset/train/subject_train.txt', header = FALSE, col.names = 'subjectID')
	# Training activities
	trainActivities <- read.table('dataset/train/Y_train.txt', header = FALSE, col.names = 'activityID')
	# Retrieving the training data and adding the sibject and activity data to it
	train <- cbind(read.table('dataset/train/X_train.txt', header = FALSE, col.names = features), trainSubjects, trainActivities)
	
	
	# Now let's clean up the data
	# Merge the training and test data sets. Merge the activity labels and select only the columns we need 
	data <- rbind(test, train) %>% merge(activityLabels) %>% select(matches('mean|std|subjectID|^activity$'))
	
	# Cleaning up the column names to make them more readable
	colNames <- names(data)
	colNames <- gsub('^t', 'time', colNames)
	colNames <- gsub('^f', 'freq', colNames)
	colNames <- gsub('\\.mean', 'Mean', colNames)
	colNames <- gsub('\\.std', 'StdDev', colNames)
	colNames <- gsub('BodyBody', 'Body', colNames)
	colNames <- gsub('\\.', '', colNames)
	names(data) <- colNames # Assinging new columns names
	
	# Now we can calculate the average of each measurements for each activity and each subject.
	avgByActivityAndSubject <- group_by(data, activity, subjectID) %>% summarise_each(funs(mean), -activity, -subjectID)
	
	write.table(avgByActivityAndSubject, "avgByActivityAndSubject.txt", row.name=FALSE)
}

# run script
runScript()
