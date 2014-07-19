The run_analysis.R script is a solution to the programming assigment of the Coursera course "Getting and Cleaning Data". The script was used to create the tidy data set (tidyset.txt) uploaded to the Coursera site as a part of the assignment.

This file is based on the comments already included in the run_analysis.R script.

The script first sets the working directory to the directory that hosts the assignment data (raw files).

Next, the raw test set file (X_test.txt) is loaded and stored as a data frame. Information on the subject IDs and subjects' activities (found in the subject_test.txt and y_test.txt files, respectively) are added to the data frame as two additional annotation columns. In the other words, the first raw data data frame has the following layout: 2947 rows and 563 columns. Each row corresponds to one data point, as recorded by subject's smart phone; "subjectid" column contains the subject ids, while their activities are in the "activity" column. Remaining columns (561) contain the accelerometer and gyroscope readouts, with the column names as listed in the features.txt file

In the subsequent step the raw train set file (X_train.txt) is red and stored as a data frame. Subject IDs and subjects' activities are appended as described above, and the columns are labeled using the features.txt file. This data frame consist of 7352 rows and 563 columns.

The data frames based on test and train data set are then merged to produce a joined data frame of 10299 rows and 563 columns. That data frame is the starting point for all the operations described below.

Column 2 ("activity") is recoded to replace the numeric codes for activities (described in activity_labels.txt file) with descriptive, i.e. human readible labels.

The subject ID is initially a numeric variable, and it was reformated to a factor variable.

The data frame was subsetted to include only those numeric columns (i.e. smart phone readouts)  on the mean and standard deviation for each measurement (this was done by including the column headers with strings "mean" or "std", but not "meanFreq"). After the subsetting, the data frame had 10299 rows and 68 columns (2 factor columns, i.e. "subject ID" and "activity", as well as 66 numeric variables with phone readouts).

The column labels were then formatted as follows: "()" and "-" symbols were removed; "t" was replaced by "time", "f" by "frequency", "Acc" by "accleration", "Mag" by "magnitude"; all the column labels were set to lower case characters.

The resulting tidy data set was saved as tidyset.txt file, with "," as the column separator and with column names included in the file. That file can be directly loaded into Microsoft Excel.

To complete the step 5 of the assignment (the average of each variable for each activity and each subject), the script loads the plyr package and then invoces the ddply function to complete the task.

The resulting data frame is saved as summaryset.txt file, with "," as the column separator and with column names included in the file. That file can be directly loaded into Microsoft Excel.
