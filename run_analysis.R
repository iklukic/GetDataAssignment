#set the working directory that hosts the assignment data
setwd("D:/R/data/UCI HAR Dataset")

#read in the raw test set and store it as a data frame
X_testInitial <- read.table("./test//X_test.txt")

#read in sequence of subject IDs and activities as data frames
subjectTest <- read.table("./test/subject_test.txt")
subjectActivities <- read.table("./test/y_test.txt")

#append the subjectTest and subjectActivities data frames to X_testInitial data frame
X_testFull <- cbind(subjectTest, subjectActivities, X_testInitial)

#read in the raw variable names from features.txt as data frame
featuresInitial <- read.table("./features.txt")

#subset the featuresInitial data frame to obtain only the raw list of variables and store that list as a vector
featuresFinal <- as.vector(featuresInitial$V2)

#add names of subject ID and activity variables to the final list of raw variable names
featuresFinal <- c("subjectID", "activity", featuresFinal)

#set the names of the X_testFull to featuresFinal
names(X_testFull) <- featuresFinal

#read in the raw train set and store it as a data frame
X_trainInitial <- read.table("./train//X_train.txt")

#read in sequence of subject IDs and activities as data frames
subjectTrain <- read.table("./train//subject_train.txt")
subjectActivitiesTrain <- read.table("./train//y_train.txt")

#append the subjectTrain and subjectActivitiesTrain data frames to X_trainInitial data frame
X_trainFull <- cbind(subjectTrain, subjectActivitiesTrain, X_trainInitial)

#set the names of the X_trainFull to featuresFinal
names(X_trainFull) <- featuresFinal

#combine the X_testFull and X_trainFull data frames into the rawFull data frame
rawFull <- rbind(X_testFull, X_trainFull)

#at this point the test set and the train set are merged, the first column contains subject ID, the second contains the activity ID, while the remaining columns consist of the raw data varaibles with raw names

#recode the column 2 (activity) to replace the numeric labels with human-readable labels
#oldvalues are activities as coded by the activity_labels.txt
oldValues <- c(1,2,3,4,5,6)
newValues <- factor(c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying"))
rawFull$activity <- newValues[ match(rawFull$activity, oldValues) ]

#reformat subjectID set as factor variable
rawFull$subjectID <- as.factor(rawFull$subjectID)

#create an index vector to point to the columns of the rawFull data frame that need to be kept in the tidy data set and the extract the columns that contain only mean and std of each variable (store as rawColumns data frame)
positions <- intersect(grep("subjectID|activity|mean|std", featuresFinal), grep("meanFreq",featuresFinal, invert=TRUE))
rawColumns <- rawFull[, positions]

#clean up the column names

#remove the () from the names
names(rawColumns) <- sub("()", "", names(rawColumns), fixed=TRUE)
#remove the dashes
names(rawColumns) <- gsub("-", "", names(rawColumns), fixed=TRUE)
#convert the beginning t into time
names(rawColumns) <- sub("^t","time", names(rawColumns))
#convert the beginning f into frequency
names(rawColumns) <- sub("^f","frequency",names(rawColumns))
#change Acc to acceleration
names(rawColumns) <- sub("Acc","Acceleration",names(rawColumns))
#change std to stddev
names(rawColumns) <- sub("std","stddev",names(rawColumns))
#change Mag to Magnitude
names(rawColumns) <- sub("Mag","Magnitude",names(rawColumns))
#convert all the column names to lower cases
names(rawColumns) <- tolower(names(rawColumns))

#rename the rawColumns to tidySet
tidySet <- rawColumns

#write the tidySet data frame as the final tidy data set .txt
write.table(tidySet, file="tidyset.txt", sep=",", col.names=TRUE, qmethod="double")

#for the step 5 of the assignment, first load the plyr package
library(plyr)

#then use the ddply function to create the means by subject and by activity
summarySet <- ddply(tidySet, c("subjectid", "activity"), numcolwise(mean))

#write the summarySet data frame as .txt
write.table(summarySet, file="summaryset.txt", sep=",", col.names=TRUE, qmethod="double")