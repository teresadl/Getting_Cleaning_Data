run_analysis.R script performs the following functions:
* Set the working directory and import needed library 
  - Here, set the working directory you will be working in. In addition, the library used for this script is plyr. 
* Download dataset
  - Downloaded file and unzip. The folder extracted is called `UCI HAR Dataset`. 
* Merge training and test sets to create one dataset. 
  - Read files and label columns of each file
    - `activities` from `activity_labels.txt` (6 rows, 2 columns) links the class labels with their activity name
    - `features` from `features.txt` (561 rows, 2 columns) is a list of all features.
    - `test_X` from `/test/X_test.txt` (2947 rows, 561 columns) is the test set. 
    - `train_X` from `/train/X_train.txt` (7352 rows, 561 columns) is the training set. 
    - `subj_test` from `/test/subject_test.txt` (2947 rows, 1 column) is the test data of the subjects observed. 
    - `test_Y` from `/test/y_test.txt` (2947 rows, 1 column) is the test labels. 
    - `train_Y` from `/train/y_train.txt` (7352 rows, 1 column) is the training labels. 
    - `subj_train` from `/train/subject_train.txt` (7352 rows, 1 column) identifies the subject who performed the activity for each window sample.
  - Bind datasets to create one dataset
    - `X` (10299 rows, 561 columns) is `test_X` and `train_X` merged. 
    - `Y` (10299 rows, 1 column) is `test_Y` and `train_Y` merged.
    - `Subject` (10299 rows, 1 column) is `subj_test` and `subj_train` merged. 
    - `Test_Train_df` (10299 rows, 563 columns) is the merged dataset. 
* Extract mean and standard deviation for each measurement. 
  - Used the **grepl()** function to execute this code. 
* Use descriptive activity labels to name the activities in the dataset. 
  - `code` column of `Test_Train_df` is replaced with activity name from 2nd column of `activities`. 
* Label dataset with descriptive variable names.
  - Used the **gsub()** function to replace labels with descriptive names.
  - Replacements: 
    - `code` -> `activity`
    - `Acc` -> `Acceleration`
    - `mean` -> `Mean`
    - `std` -> `Std`
    - `Freq` -> `Frequency`
    - `^t` -> `Time` which means that all variables starting with the character `t` is replaced with `Time`
    - `^f` -> `Frequency` which means that all variables starting with the character `f` is replaced with `Frequency`
    - `BodyBody` -> `Body`
    - `gravity` -> `Gravity`
    - `mag` -> `Magnitude`
    - `Gyro` -> `Gyroscope`
* Create a second, independent tidy dataset with the average of each variable for each activity. 
  - Used the **ddply()** to find the average of each variable in columns `subject` and `activity` and stored to new dataset, `tidy_avg_df`.
  - Then, write new table and save as a text file, `tidy_df.txt`.
