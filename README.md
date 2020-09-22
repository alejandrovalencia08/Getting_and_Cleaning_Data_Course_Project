# Getting_and_Cleaning_Data_Course_Project
# Code Book

#This file contains information about run_analysis.R script which is a data preparation in 5 steps.

#(i) Download the dataset
    Dataset downloaded from url (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and extracted under the folder called UCI HAR Dataset

#(ii) Load each data from folder UCI HAR dataset list
   activities <- list[1] ---> activity_labels.txt : 6 rows, 2 columns
        Links the class labels with their activity name
   features <- list[2] ---> features.txt; 561 rows, 2 columns
        List of all features of the database which come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
   subject_test <- list[16] --> subject_test.txt : 2947 rows, 1 column: min=2, max=24
        Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
   x_test <- list[17] --> X_test.txt : 2947 rows, 561 columns
        contains recorded test set
   y_test <- list[18] --> y_test.txt : 2947 rows, 1 columns
        contains code labels of test data activities 
   subject_train <- list[30] --> subject_train.txt : 7352 rows, 1 column; min=1, max=30
        Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
   x_train <- list[31] --> X_train.txt : 7352 rows, 561 columns
        contains recorded train set
   y_train <- list[32] --> y_train.txt : 7352 rows, 1 columns
        contains code labels of train data activities 


#(iii) Merge the train and test data sets to create one data set (Step 1)
        xdata <- is created by merging x_train and x_test using rbind() function (10299 rows, 561 columns) 
        ydata <- is created by merging y_train and y_test using rbind() function (10299 rows, 1 column)
        subject <-  is created by merging subject_train and subject_test using rbind() function (10299 rows, 1 column)
        merged_data <- is created by merging subject, ydata and xdata using cbind() function (10299 rows, 563 column)

#(iv) Extracts only the measurements on the mean and standard deviation for each measurement (Step 2)
   data  <-   is created by subsetting merged_data using select function in columns of merge_data: "subject", "code" and column that contain "mean" and "std" (standard deviation); (10299 rows, 88 columns)

#(v) Uses descriptive activity names to name the activities in the data set (Step 3)
     code column from data is replaced with the corresponding activity using second column of the activities object

#(vi) Appropriately labels the data set with descriptive variable names (Step 4)
        names.data <- a new objete with column names of data is created 
        "code" name from names.data is renamed to "activities"
        variables names in names.data is padronized using gsub function and %>% operator; Acronym of variables is standartized (e.g. Acc by Accelerometer,
            Gyro by Gyroscope, etc); start character was changed (t and f by Frequency and Time respectively)
        names.data padronized was associated with the column names of data

#(vii) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject (Step 5)
        final_data <- is created by sumarizing data by means of each variable for each activity and each subject, after groupped by subject and activity.
        
#(viii) Export data
        final_data <- is exported into final_data.txt file.

