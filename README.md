# gettingcleaningdata
## Project for the Getting and Cleaning Data Course Project. John Hopkins' Data Science Specialization


## Read all data files into data sets.

* X_test <- read.table("./test/X_test.txt", header = FALSE)           # Variable to read the data set from X_test.txt
* y_test <- read.table("./test/y_test.txt", header = FALSE)           # Variable to read the data set from y_test.txt
* s_test <- read.table("./test/subject_test.txt", header = FALSE)     # Variable to read the data set from subject_test.txt

* X_train <- read.table("./train/X_train.txt", header = FALSE)        # Variable to read the data set from X_train.txt
* y_train <- read.table("./train/y_train.txt", header = FALSE)        # Variable to read the data set from y_train.txt
* s_train <- read.table("./train/subject_train.txt", header = FALSE)  # Variable to read the data set from subject_train.txt


## Combine test and train data sets.

* Xtt <- rbind(X_test, X_train)                                       # Combine the two "X" data sets by row
* ytt <- rbind(y_test, y_train)                                       # Combine the two "y" data sets by row
* stt <- rbind(s_test, s_train)                                       # Combine the two "subject" data sets by row


## Add appropriate column headers.

* alabels <- read.table("./activity_labels.txt", header = FALSE)[,2]  # Variable to read the second column of the data set from activity_labels.txt
* feat <- read.table("./features.txt")[,2]                            # Variable to read the second column of the data set from features.txt
* colnames(Xtt) = feat                                                # Set descriptive names to the activities in the Xtt data set
* ytt[,2] = alabels[ytt[,1]]                                          # Load activity labels in the ytt data set
* colnames(ytt) = c("Activity_ID", "Activity_Label")                  # Set names for the ytt data set
* colnames(stt) = "Subject"                                           # Set names for the stt data set


## Remove each and every column that did not contain the strings "mean" or "std".

* extract_feat <- grep(". * Mean. * |. * Std. * ", feat, ignore.case=TRUE)    # Variable to extract the mean and standard deviation for each measurement
* Xtt2 = Xtt[,extract_feat]                                           # Extract only the mean and standard deviation for the measurements in the Xtt data set


## Set the left 86 columns together with the subject and the two activity columns into a single data set.

* Xys <- cbind(stt, ytt, Xtt2)                                        # Combine the "X", "y" and "subject" data sets by column


## Convert the subject column from integer to factor.

* Xys$Subject <- as.factor(Xys$Subject)                               # Set Subject as a factor variable


## Create a tidy set with the average of each variable for each activity and each subject.

* tidyXys <- aggregate(. ~Subject + Activity_Label, Xys, mean)        # Create a tidy data set with average for each Activity and Subject


## Order the columns in the tidy data set by subject and activity.

* tidyXys <- tidyXys[order(tidyXys$Subject,tidyXys$Activity_Label),]  # Order the tidy data set by Subject and Activity


## Save the tidy data set to a txt file.

* write.table(tidyXys, file = "TidyXys.txt", row.names = FALSE)       # Write the tidy data into a data file that contains the processed data
