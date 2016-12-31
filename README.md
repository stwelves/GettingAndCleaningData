Tidy Data Project

This document explains how the run_analysis.R script works.

The script completes the following tasks:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

For Task 1, the script carries out the following steps:
- Downloads the raw zip data to a file called projectData.zip in the local directory.
- it then unzips this file
- it reads in the following tables:
	1. X_test.txt
	2. y_test.txt
	3. subject_test.txt
	4. X_train.txt
	5. y_train.txt
	6. subject_train.txt
- It then concatenates the rows of the test and train data for X, Y and Subject separately before
- and then binds them altogether after renaming the Y and Subject data columns to be Activity and Subject respectively.
- The names from the mean and std subset are extracted from the column name

For Task 2, the script carries out the following steps:
- It reads in the table from features.txt to obtain the names of the rows of measurements in the combined data set from Step 1.
- The features table have an extra column added which is used in subsetting the data - this column contains V# where # is the V1 ID
- The mean and std data is then extracted using grep1 which searches for mean or std but ignores anything with angle in it because 
  the term angle is used in some names along with mean but does not give a mean or std.
- The new features name column is combined with 'Activity' and 'Subject' which is then used in selection of the relevant mean and std
  columns in the combined data set.

For Task 3, the following steps are undertaken:
- It loads the table from activity_labels.txt which contains the descriptive activity names.
- It changes the activities column names to Activity and ClearActivity
- Then this table of activity names is merged with the mean and std data table by the 'Activity' column.
- Finally the original 'Activity' column is removed as it is now redundant.

For Task 4, the following is carried out:
- The global substitution function, gsub, is used to change the names in the data table as follows:
	1. Anything starting with a 't' is replaced with 'time' at the start
	2. Anything starting with an 'f' is replaced with 'frequency' at the start
	3. Anywhere an 'Acc' is found, it is replaced with 'Acceleration'
	4. Anywhere a 'Gyro' is found, it is replaced with 'Gyroscope'
	5. Anywhere a '()' is found, it is removed
	6. Anywhere an 'std' is found, it is replaced with 'stdDev'
	7. Anywhere 'Body' is found repeated, the repetition is removed 
	8. Anywhere a 'Mag' is found, it is replaced with 'Magnitude'

For Task 5, the follwing steps are undertaken:

To accomplish goal 5, the run_analysis.R script performs the following steps:
- The number of columns with numeric results in is counted.
- Then for all those columns, the mean is calculated for each individual Subject IDs and Activity names separately.
- The resulting tidy data is then written out to the local directory in a file named 'tidy_data.txt'