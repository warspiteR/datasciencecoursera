
#1. Merges the training and the test sets to create one data set.

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#working on a mac, so need to define the method
download.file(url, "dataset.zip",method="curl") 
unzip("dataset.zip")
path <- "UCI HAR Dataset"
#list.files(path)

#read the data files
SubjectTrain <- read.table(file.path(path, "train", "subject_train.txt"))
SubjectTest <- read.table(file.path(path, "test", "subject_test.txt"))
DataTrain <- read.table(file.path(path, "train", "X_train.txt"))
DataTest <- read.table(file.path(path, "test", "X_test.txt"))
ActivityTrain <- read.table(file.path(path, "train", "y_train.txt"))
ActivityTest <- read.table(file.path(path, "test", "y_test.txt"))

#read the label files
ActivityLabels <- read.table(file.path(path,"activity_labels.txt"))
Features <- read.table(file.path(path,"features.txt"))[,2]
#grep the filtered selection
SelectedFeatures <- grepl("mean|std", Features)

#Add the 2 row ranges together
CompleteSubject <- rbind(SubjectTrain,SubjectTest)
CompleteData <- rbind(DataTrain,DataTest)
CompleteActivity <- rbind(ActivityTrain,ActivityTest)

#cleanup the names of the columns
names(CompleteSubject) <- "subject"
names(CompleteActivity) <- "activity"
names(CompleteData) <- Features
names(ActivityLabels) <- c('id', 'label')

#descriptive activity names 
CompleteActivity$activity <- ActivityLabels[CompleteActivity$activity, ]$label

#Only keep the selected features
CompleteData <- CompleteData[,SelectedFeatures]

#Add the 3 column ranges together
Data <- cbind(CompleteSubject,CompleteActivity,CompleteData)

#switch to long layout
DataLong <- melt(Data, id = c("subject", "activity"))

#Grab the mean for combination of subject and activity
MeanData  = dcast(DataLong, subject + activity ~ variable, mean)

#store the output
write.table(MeanData, "tidy_clean_data.txt")
