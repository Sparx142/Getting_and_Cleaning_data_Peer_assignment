#1 Merges the training data set and test data set in one data set
X <- rbind(train_x,test_x)
Y <- rbind(train_y,test_y)
subject <- rbind(subject_train,subject_test)
merged_data <- cbind(subject,X,Y)

#2 Extracts only measurements on the mean and standard deviation on each measurement
tidyData <- merged_data %>% select(subject,code,contains("mean"),contains("sd"))

#3 Uses descriptive activity names to name the activities on data set
tidyData$code <- actitvities[tidyData$code,2]

#4 Appropriately labels the data with descriptive names
names(tidyData)[2] = "activity"
names(tidyData)<-gsub("Acc", "Accelerometer", names(tidyData))
names(tidyData)<-gsub("Gyro", "Gyroscope", names(tidyData))
names(tidyData)<-gsub("BodyBody", "Body", names(tidyData))
names(tidyData)<-gsub("Mag", "Magnitude", names(tidyData))
names(tidyData)<-gsub("^t", "Time", names(tidyData))
names(tidyData)<-gsub("^f", "Frequency", names(tidyData))
names(tidyData)<-gsub("tBody", "TimeBody", names(tidyData))
names(tidyData)<-gsub("-mean()", "Mean", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("-std()", "STD", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("-freq()", "Frequency", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("angle", "Angle", names(tidyData))
names(tidyData)<-gsub("gravity", "Gravity", names(tidyData))

#5 From the data set in step 4, create a second, independent tidy data set with average
# of each variable with the average of each variable for each activity and each data set
finalData <- tidyData %>%
            group_by(subject,activity) %>%
            summarize_all(funs(mean))
write.table(finalData,file= "FinalData.txt", row.names = FALSE)
