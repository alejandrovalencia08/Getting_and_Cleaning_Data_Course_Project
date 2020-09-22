#Getting and Cleaning Data Course Project

#Loading packages
library(dplyr)

#Name of file
filename <- "dataset.zip"

# Check if file already exists.
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method="curl")
}  

# Check if folder exists
if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
}

#get list names of files of zip file
list <- unzip("dataset.zip", list=TRUE)[,1]

#load data.frames
activities <- read.table(list[1], col.names = c("code", "activity")) #names of y
features <- read.table(list[2], col.names = c("n","functions"))# names of variables of x
subject_test <- read.table(list[16], col.names = "subject")
x_test <- read.table(list[17], col.names = features$functions)
y_test <- read.table(list[18], col.names = "code")
subject_train <- read.table(list[30], col.names = "subject")
x_train <- read.table(list[31], col.names = features$functions)
y_train <- read.table(list[32], col.names = "code")



#Step 1: Merges the training and the test sets to create one data set.
xdata <- rbind(x_train, x_test)
ydata <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merged_data <- cbind(subject, ydata, xdata)
str(merged_data)


#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

data <- merged_data %>% select(subject, code, contains("mean"), contains("std"))
head(data)


#Step 3: Uses descriptive activity names to name the activities in the data set.
data$code <- activities[data$code, 2]



#Step 4: Appropriately labels the data set with descriptive variable names.
names.data <- names(data)
names.data[2] <- "activity"
names.data <- names.data %>% 
            gsub("[[:punct:]]", "",.) %>%
            gsub("Acc", "Accelerometer.",.) %>%
            gsub("Gyro", "Gyroscope.",.) %>%
            gsub("Mag", "Magnitude.",.) %>%
            gsub("Gravityy|gravityy", "gravity",.) %>%
            gsub("gravity|Gravity", "Gravity.",.) %>%
            gsub("^t", "Time.",.) %>%
            gsub("^f", "Frequency.",.) %>%
            gsub("Body", "Body.",.) %>%
            gsub("Body.Body.", "Body.",.) %>%
            gsub("tBody", ".Time.Body",.) %>%
            gsub("Mean", "mean.",.) %>%
            gsub("angle", "Angle",.) %>%
            gsub("Jerk", "Jerk.",.) %>%
            gsub("X", ".X.",.) %>%
            gsub("Y", ".Y.",.) %>%
            gsub("Z", ".Z.",.) %>%
            gsub(pattern = "[.]$", replacement = "",.)

colnames(data) <- names.data



#Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

final_data <- data %>%
              group_by(subject, activity) %>%
              summarise_all(mean, na.rm=TRUE)

#Export data
write.table(final_data, "final_data.txt", row.name=FALSE)
