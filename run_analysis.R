#1. Merge the training and the test sets to create one data set
library(plyr)
setwd('C:\\Users\\Anastasia\\Documents\\Working_directory\\Get&CleanDataPrAssign\\UCI HAR Dataset')

#read the data sets
  #read test
x_test <- read.table('.\\test\\X_test.txt')
y_test <- read.table('.\\test\\y_test.txt')
subject_test <- read.table('.\\test\\subject_test.txt')

  #read train
x_train <- read.table('.\\train\\X_train.txt')
y_train <- read.table('.\\train\\y_train.txt')
subject_train <- read.table('.\\train\\subject_train.txt')


#create new data sets
  # x data set
x_dataset <- rbind(x_test, x_train)

  #y data set
y_dataset <- rbind(y_test, y_train)

  #subject data set
subject_dataset <- rbind(subject_test, subject_train)



# 2. Extract only the measurements on the mean and standard deviation for each measurement.
read_features <- read.table('.\\features.txt')
head(read_features)
grep('.(mean|std)[(]', read_features$V2, value = TRUE)


#3. Use descriptive activity names to name the activities in the data set
read_activities <- read.table('.\\activity_labels.txt')
merged_data <- merge(y_dataset, read_activities, by = 'V1', all = TRUE)
y_dataset <- merged_data[,2] 
names(y_dataset)[1] <- 'activity'


#4. Appropriately label the data set with descriptive variable names
names(subject_dataset) <- 'subject'
all_data <- cbind(x_dataset, y_dataset, subject_dataset)


#5. From the data set in step 4, create a second, independent tidy data set with the average
#of each variable for each activity and each subject
av_var <- ddply(all_data, .(subject, y_dataset), function(x) colMeans(x[, 1:561]))
str(av_var)
write.table(av_var, 'av.var.txt', row.names = FALSE)
