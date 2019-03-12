run_analysis <- function() {
        setwd('/Users/teresakle/Coursera')
        library(plyr)
        
        # Download and unzip zip file
        if (!file.exists('Final_Proj.zip')) {
                download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 
                              'Final_Proj.zip', method = 'curl')
        }
        unzip(file)
        
        # Read files and label columns
        activities <- read.table('UCI HAR Dataset/activity_labels.txt', col.names = c('code', 'activity'))
        features <- read.table('UCI HAR Dataset/features.txt', col.names = c('n', 'functions'))
        test_X <- read.table('UCI HAR Dataset/test/X_test.txt', col.names = features$functions)
        train_X <- read.table('UCI HAR Dataset/train/X_train.txt', col.names = features$functions)
        subj_test <- read.table('UCI HAR Dataset/test/subject_test.txt', col.names = 'subject')
        test_Y <- read.table('UCI HAR Dataset/test/y_test.txt', col.names = 'code')
        train_Y <- read.table('UCI HAR Dataset/train/y_train.txt', col.names = 'code') 
        subj_train <- read.table('UCI HAR Dataset/train/subject_train.txt', col.names = 'subject') 
        
        # Merging training and test datasets
        X <- rbind(test_X, train_X)
        Y <- rbind(test_Y, train_Y)
        Subject <- rbind(subj_test, subj_train)
        Test_Train_df <- cbind(Subject, Y, X)
        
        # Extracting mean and SD for each measurement
        Test_Train_df[, grepl('mean|std|subject|code', colnames(Test_Train_df))]
        
        # Descriptive labels to name activities in dataset
        Test_Train_df$code <- activities[Test_Train_df$code, 2]
        
        # Labels dataset with descriptive variable names
        names(Test_Train_df) <- gsub('code', 'activity', names(Test_Train_df))
        names(Test_Train_df) <- gsub('Acc', 'Acceleration', names(Test_Train_df))
        names(Test_Train_df) <- gsub('mean', 'Mean', names(Test_Train_df))
        names(Test_Train_df) <- gsub('std', 'Std', names(Test_Train_df))
        names(Test_Train_df) <- gsub('Freq', 'Frequency', names(Test_Train_df))
        names(Test_Train_df) <- gsub('^t', 'Time', names(Test_Train_df))
        names(Test_Train_df) <- gsub('^f', 'Frequency', names(Test_Train_df))
        names(Test_Train_df) <- gsub('BodyBody', 'Body', names(Test_Train_df))
        names(Test_Train_df) <- gsub('gravity', 'Gravity', names(Test_Train_df))
        names(Test_Train_df) <- gsub('mag', 'Magnitude', names(Test_Train_df))
        names(Test_Train_df) <- gsub('Gyro', 'Gyroscope', names(Test_Train_df))
        
        # Create a second, independent tidy dataset with the avg of each var for each activity
        tidy_avg_df <- ddply(Test_Train_df, c('subject', 'activity'), numcolwise(mean))
        write.table(tidy_avg_df, file = 'tidy_df.txt')
}