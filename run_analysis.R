##Download data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- "projectData.zip"
download.file(url, f)
unzip(f)

## dplyr is already installed, use library
library(dplyr)

## Q1 There are 3 training and 3 test sets which must be merged:
Xtest <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
Xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
Ytest <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
Ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
Stest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
Strain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

## Combine the test and train data by rows and remove separate data tables
X <- rbind (Xtest, Xtrain)
Y <- rbind (Ytest, Ytrain)
S <- rbind (Stest, Strain)
rm(Xtest)
rm(Xtrain)
rm(Ytest)
rm(Ytrain)
rm(Stest)
rm(Strain)

## combine X Y and S data together by column after adding 
## extra easy-to-read columns for Y (activity) and subject data
names(Y) <- c("Activity")
names(S) <- c("Subject")
combinedData <- cbind(S, Y, X)
View(combinedData)

## Q2 Extract mean and STD. Firstly, get the names that have mean or std in them
## Obtain a list of the features to extract their names 
## Add an extra column with V + index added
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
features <- mutate(features, name = paste0("V", V1))
meanStdData <- filter(features, grepl("(mean|std)", V2, ignore.case=T)&!grepl("angle", V2))

## Now add activity and subject names so that these can be used to subset the data
names <- c(meanStdData$name, "Activity", "Subject")

## Select the relevant data from the data set for std and mean
stdMeanData <- select(combinedData, one_of(names))
View(stdMeanData)

## Q3 Use descriptive activity names to name the activities in the data set
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activities) <- c("Activity", "ClearActivity")

## Merge the data with these activities
## Then remove the unclear activity label because it isn't needed any longer
data <- merge(stdMeanData, activities,by = 'Activity', all.x = TRUE)
data <- select(data, -Activity)
View(data)

## Q4. Appropriately labels the data set with descriptive variable names.
names(data) <- gsub("^t", "time", names(data))
names(data) <- gsub("^f", "frequency", names(data))
names(data) <- gsub("Acc", "Acceleration", names(data))
names(data) <- gsub("Gyro", "Gyroscope", names(data))
names(data) <- gsub("\\(\\)", "", names(data))
names(data) <- gsub("std", "stdDev", names(data))
names(data) <- gsub("BodyBody", "Body", names(data))
names(data) <- gsub("Mag", "Magnitude", names(data))
names(data)

## Q5. From the data set in step 4, creates a second, independent tidy 
## data set with the average of each variable for each activity and each subject.
## First need the number of columns with number data in it - i.e. not the last 2 columns
numCols <- ncol(data)-2

## Now get the mean for each subject and activity
tidyData <- aggregate(as.matrix(data[, 1:numCols])~ Subject + ClearActivity, data, mean)
View(tidyData)
write.table(tidyData, file = "tidy_data.txt")






