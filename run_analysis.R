## Create run_analysis.R:

## 1. Merge the training and the test sets to create one data set
## 2. Extract only the measurements on the mean and standard deviation for each measurement
## 3. Use descriptive activity names to name the activities in the data set
## 4. Appropiately label the data set with descriptive variable names
## 5. From the data set in step 4, create a second, independent tidy data set with the average of each
## activity and each subject


X_test <- read.table("./test/X_test.txt", header = FALSE)           # Variable to read the data set from X_test.txt
y_test <- read.table("./test/y_test.txt", header = FALSE)           # Variable to read the data set from y_test.txt
s_test <- read.table("./test/subject_test.txt", header = FALSE)     # Variable to read the data set from subject_test.txt

X_train <- read.table("./train/X_train.txt", header = FALSE)        # Variable to read the data set from X_train.txt
y_train <- read.table("./train/y_train.txt", header = FALSE)        # Variable to read the data set from y_train.txt
s_train <- read.table("./train/subject_train.txt", header = FALSE)  # Variable to read the data set from subject_train.txt

Xtt <- rbind(X_test, X_train)                                       # Combine the two "X" data sets by row
ytt <- rbind(y_test, y_train)                                       # Combine the two "y" data sets by row
stt <- rbind(s_test, s_train)                                       # Combine the two "subject" data sets by row

alabels <- read.table("./activity_labels.txt", header = FALSE)[,2]  # Variable to read the second column of the data set from activity_labels.txt
feat <- read.table("./features.txt")[,2]                            # Variable to read the second column of the data set from features.txt
extract_feat <- grep(".*Mean.*|.*Std.*", feat, ignore.case=TRUE)    # Variable to extract the mean and standard deviation for each measurement

colnames(Xtt) = feat                                                # Set descriptive names to the activities in the Xtt data set
Xtt2 = Xtt[,extract_feat]                                           # Extract only the mean and standard deviation for the measurements in the Xtt data set
ytt[,2] = alabels[ytt[,1]]                                          # Load activity labels in the ytt data set
colnames(ytt) = c("Activity_ID", "Activity_Label")                  # Set names for the ytt data set
colnames(stt) = "Subject"                                           # Set names for the stt data set

Xys <- cbind(stt, ytt, Xtt2)                                        # Combine the "X", "y" and "subject" data sets by column
Xys$Subject <- as.factor(Xys$Subject)                               # Set Subject as a factor variable
tidyXys <- aggregate(. ~Subject + Activity_Label, Xys, mean)        # Create a tidy data set with average for each Activity and Subject
tidyXys <- tidyXys[order(tidyXys$Subject,tidyXys$Activity_Label),]  # Order the tidy data set by Subject and Activity
write.table(tidyXys, file = "TidyXys.txt", row.names = FALSE)       # Write the tidy data into a data file that contains the processed data
