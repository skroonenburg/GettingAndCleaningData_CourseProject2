#
# See README.R for raw data location & description of the steps 
# performed in this script
# 
# See CodeBook.R for a description of each variable output by the script
# in tidydata.txt
#
###################################################
# 1. Read the data in
###################################################

#Read the training set data & activity labels
trainingData <- read.fwf("UCI HAR Dataset/train/X_train.txt", widths = rep(16, 561))
trainingLabels <- read.fwf("UCI HAR Dataset/train/Y_train.txt", widths = c(1), colClasses = "factor")
trainingSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", sep = ' ', colClasses = "numeric")

#Read the test set data & activity labels
testData <- read.fwf("UCI HAR Dataset/test/X_test.txt", widths = rep(16, 561))
testLabels <- read.fwf("UCI HAR Dataset/test/Y_test.txt", widths = c(1), colClasses = "factor")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", sep = ' ', colClasses = "numeric")

###################################################
# 2. Combine the data together into one data frame
###################################################

# Add the activity labels to the training data
trainingData[,562] <- trainingLabels[,1]
# Add the subjects to the training data
trainingData[,563] <- trainingSubjects[,1]

# Add the activity labels to the training data
testData[,562] <- testLabels[,1]
# Add the subjects to the training data
testData[,563] <- testSubjects[,1]

#Merge the data together into one data frame
totalData <- rbind(trainingData, testData)

###################################################
# 3. Set human-readable tidy data variable names
###################################################

#Set human-readable levels for the activity factors
levels(totalData[,562]) <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

#Read the variable names from the appropriate file
features <- read.table("UCI HAR Dataset/features.txt", sep = " ", stringsAsFactors = FALSE)[2]

# Set the variable names on the data columns
features[562,] = "Activity"
features[563,] = "Subject"
names(totalData) <- features[,1]

# Only keep columns relating to mean or stddev measurements
namedData <- totalData[ , grepl( "(mean|std|Activity|Subject)" , names( totalData ) ) ]

# Clean up the variable names to make them human readable
names(namedData) <- gsub("^t", "Time-", names(namedData))
names(namedData) <- gsub("^f", "Frequency-", names(namedData))
names(namedData) <- gsub("\\(\\)", "", names(namedData))

###################################################
# 4. Calculate the mean for each variable, by
#   activity and subject
###################################################

library(reshape)
meltedData <- melt(namedData, id=c("Subject","Activity"))

tidyData <- cast(meltedData, Subject + Activity ~ variable, mean)

###################################################
# 5. Write the tidy data set out to a file
###################################################

write.table(tidyData, file = "tidyData.txt", row.name = FALSE, sep = " ")