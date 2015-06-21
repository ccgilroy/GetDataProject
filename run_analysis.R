## This script takes the UCI HAR Dataset and produces a tidy summary of some 
## of the features it measures and calculates. It outputs the tidy data frame
## as tidydata.txt in the working directory.
## author: Connor Gilroy

library(dplyr)
library(tidyr)

## optionally, download data
if (!file.exists("./UCI HAR Dataset")) {
  fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, "UCI HAR Dataset.zip")
  unzip("UCI HAR Dataset.zip")
}

## combine test and training data into one data set

## create a character vector of features to use as column names
## readLines() calls file(), which opens (and closes!) a connection
features <- readLines("./UCI HAR Dataset/features.txt") 

## assemble test data frame
test.activity <- read.table("./UCI HAR Dataset/test/y_test.txt", 
                            col.names="activity", colClasses = "factor")
test.subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                           col.names="subject")
test.x <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features, 
                     colClasses = "numeric")
test.data <- bind_cols(test.activity, test.subject, test.x)

## assemble train data frame
train.activity <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                             col.names = "activity", colClasses = "factor")
train.subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                            col.names = "subject")
train.x <- read.table("./UCI HAR Dataset/train/X_train.txt", 
                      col.names = features, colClasses = "numeric")
train.data <- bind_cols(train.activity, train.subject, train.x)

## combine test and training data into one data set
combined.data <- bind_rows(test.data, train.data)

## extract measurements on mean and standard deviation for each measurement
## chose to exclude meanFreq to maintain one-to-one mean-std correspondence
extracted.data <- select(combined.data, activity, subject, 
                         matches("mean\\.|std\\.", ignore.case=FALSE))

## name activities in data set by adjusting factor levels
## based on activity_labels.txt
levels(extracted.data$activity) <- c("walking", "walking upstairs", 
                                    "walking downstairs", "sitting", 
                                    "standing", "laying")

## label data set with variable names
names(extracted.data) <- gsub("X[0-9]+", "", names(extracted.data))
names(extracted.data) <- gsub("\\.", "", names(extracted.data))
names(extracted.data) <- gsub("^t", "time", names(extracted.data))
names(extracted.data) <- gsub("^f", "fft", names(extracted.data))
names(extracted.data) <- gsub("Gyro", "gyroscope", names(extracted.data))
names(extracted.data) <- gsub("Acc", "acceleration", names(extracted.data))
names(extracted.data) <- gsub("Mag", "magnitude", names(extracted.data))
names(extracted.data)[grep("[XYZ]$", names(extracted.data))] <- 
  paste(names(extracted.data)[grep("[XYZ]$", names(extracted.data))], 
        "axis", sep="")
names(extracted.data) <- tolower(names(extracted.data))

## from this data set, create a new data set
## with average of each variable for each activity and each subject
new.data.wide <- extracted.data %>% 
  group_by(activity, subject) %>%
  summarise_each(funs(mean)) 

new.data.long <- extracted.data %>% 
  gather(feature, value, -c(activity,subject)) %>%
  group_by(activity, subject, feature) %>%
  summarise(meanvalue = mean(value)) 

## write the new data set to a text file
write.table(new.data.long, "tidydata.txt", row.names=FALSE)
