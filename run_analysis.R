
#basic setting
setwd('/Users/Julia/Documents/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/')
library(plyr)
xTrain = read.table("./train/X_train.txt")
yTrain = read.table("./train/y_train.txt")
subjectTrain = read.table("./train/subject_train.txt")
xTest = read.table("./test/X_test.txt")
yTest = read.table("./test/y_test.txt")
subjectTest = read.table("./test/subject_test.txt")
xTrain = read.table("./train/X_train.txt")
#1.Merges the training and the test sets to create one data set.
#combine datasets
xdata <- rbind(xTrain, xTest) #'x'data set
ydata <- rbind(yTrain, yTest) #'y'data set
subjectdata <- rbind(subjectTrain, subjectTest) #'subject' data set

#2.Extract only the measurements on the mean and standard deviation for each measurement

features <- read.table("features.txt")
meanstd <- grep("-(mean|std)\\(\\)", features[, 2])
xdata <- xdata[, meanstd]
names(xdata) <- features[meanstd, 2]

#3.Uses descriptive activity names to name the activities in the data set

activities <- read.table("activity_labels.txt")
ydata[, 1] <- activities[ydata[, 1], 2]
names(ydata) <- "activity"

#4.Appropriately labels the data set with descriptive variable names. 

names(subjectdata) <- "subject"
Alldata <- cbind(xdata, ydata, subjectdata)

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
dim(Alldata)#10299 68
cleandata <- ddply(Alldata, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(cleandata, "cleandata.txt", row.name=FALSE)


