################################################################
# This script contains a function that cleans a data set on human 
# activity recognition

# # To work properly this function require:
#   activity_labels.txt
#   features.txt
#   X_train.txt
#   y_train.txt
#   subject_train.txt
#   X_test.txt
#   y_test.txt
#   subject_test.txt
#

### Arguments:
#   
#
### Return: 
#
#
# Author: Paula Andrea Ortiz Otalvaro
# Created:  August 2019
# Last modified:   19-08-2019
#
################################################################

# --------------------------------------------------------------
#                        LOAD PACKAGES
# --------------------------------------------------------------
library(dplyr)
library(tidyr)

#setwd("C:/Users/potalvar/Google Drive/Learning/Springboard_Intro2DS_onlylocal/Springboard_Intro2DS_Wrangling/Human_activity_recognition")


#---------------------------------------------------------------------------------------
#                        GET DATA FRAMES AND CREATE/MODIFY HEADERS
#---------------------------------------------------------------------------------------

# *********************** Read test and train data ***********************
test_x <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, stringsAsFactors = FALSE)
train_x <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, stringsAsFactors = FALSE)

# ******** Add column identifying source (train or test) ********
test_x <- dplyr::mutate(test_x, subset = "test")
train_x <- dplyr::mutate(train_x, subset = "train")

# *********************** Read data related to activity names and labels ***********************
# activity labels
test_activi_label <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, stringsAsFactors = FALSE)
train_activi_label <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, stringsAsFactors = FALSE)
colnames(test_activi_label) <- "ActivityLabel"
colnames(train_activi_label) <- "ActivityLabel"
# Get activity names corresponding to  activity labels
activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE, stringsAsFactors = FALSE)
colnames(activity_names) <- c("ActivityLabel", "ActivityName")

# ******************************* Read data related to subject **********************************
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, stringsAsFactors = FALSE)
colnames(test_subject) <- "subject"
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, stringsAsFactors = FALSE)
colnames(train_subject) <- "subject"


#---------------------------------------------------------------------------------------
#                                 MERGE DATA SETS
#---------------------------------------------------------------------------------------
har_dataset <- dplyr::bind_rows(test_x, train_x)
activity_labels <- dplyr::bind_rows(test_activi_label, train_activi_label)
subject <- dplyr::bind_rows(test_subject, train_subject)

# *************************** Get names of all features (column names) ***************************
col_names <- read.delim("./UCI HAR Dataset/features.txt", header = FALSE, stringsAsFactor = FALSE, sep = " ")
colnames(har_dataset) <- make.names(t(col_names[2]), unique = TRUE)

# **************** Assign to each observation its corresponding activity label ********************
har_dataset <- dplyr::bind_cols(activity_labels, har_dataset)

# ******** Assign to each observation its corresponding activity name (using the labels) **********
har_dataset <- dplyr::right_join(x = activity_names, y = har_dataset, by = "ActivityLabel")

# ******************************* Assign subject to each observation ******************************
har_dataset <- dplyr::bind_cols(subject, har_dataset)



#---------------------------------------------------------------------------------------
#                       EXTRACT TIDY DATA SET
#---------------------------------------------------------------------------------------

# ******** Extract only columns containing mean or standard deviation of each observation *********
selected_features <- colnames(har_dataset)[grepl("mean|std", colnames(har_dataset))]
har_subset <- har_dataset[selected_features]

# *********************** Write cleaned dataframe to file ***********************
data.table::fwrite(har_subset, file = "har_clean.csv" )

