Code Book

Data
The data was downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Functionality:
The script run_analysis.R creates a tidy data set in the following steps:
-1. Merges the training and the test sets to create one data set.
-2. Extracts only the measurements on the mean and standard deviation for each measurement.
-3. Uses descriptive activity names to name the activities in the data set
-4. Appropriately labels the data set with descriptive variable names.
-5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Variables
-Xtest/Xtrain - contains table in X_test.txt and X_train.txt
-Ytest/Ytrain - contains table in y_test.txt and y_train.txt
-Stest/Strain - contains table in subject_test.txt and subject_train.txt
-features - contains table of features.txt - later mutated to include an extra column called 'name' which contains a V# 
	 - where # is the corresponding index in column V1
-X - contains row bound table of Xtest and Xtrain
-Y - contains row bound table of Ytest and Ytrain plus Activity column
-S - contains row bound table of Stest and Strain plus Subject column
-combinedData - contains column bound table of S, Y and X
-meanStdData - contains the rows of the features' table which have the word 'mean' or 'std' but not 'angle'
-names - contains the combination of the contents of column name in meanStdData together with new ones called 'Activity' and 'Subject'
-stdMeanData - contains all the rows of combinedData which contain mean or std
-activities - contains table of activity_labels.txt which has more meaningful labels than just numeric indices
	   - this has its column names changed to 'Activity' and 'ClearActivity' where the latter indicates a meaningful name.
-data 	- takes the table stdMeanData and then organises it according to ascending Activity ID, then the Activity column is removed because it is redundant
     	- because there is a ClearActivity column in it.
-numCols - gives the number of columns that has numerical data in it and does not include the Subject and ClearActivity columns
-tidyData - is the subset of clearly labeled data with the average of each variable for each activity and each subject

Output
tidyData.txt contains the tidyData table:
- column 1 contains the subject IDs, between 1 to 30.
- column 2 contains the name of the activities.
- the remaining columns contain the means and standard deviation for each measurement as described below

Throughout the names the following is true:
-1. a 'mean' suffix in the name denotes this is a mean measurement
-2. a 'stdDev' suffix in the name denotes this is a standard deviation measurement
-3. X, Y or Z means the axis the measurement was taken along.
-4. a 'time' prefix means this was taken in the time domain
-5. a 'frequency' prefix means this was taken in the frequency domain.
-6. a 'Jerk' in the name implies that the movement is a sudden one as oppose to a smooth one.
-7. a 'Magnitude' in the name implies that this is the magnitude only measurement and not phase.

The rest of the data column names mean the following, where ... denotes prefix or suffix, as described above:
-1. ... BodyAcceleration-... : this is the body acceleration measurement
-2. ... GravityAcceleration ... : this is the acceleration due to gravity
-3. ... BodyGyroscope ... : This is the gyroscopic measurement of body movement
 
