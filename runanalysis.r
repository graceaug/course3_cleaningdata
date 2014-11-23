# 1 merge the training and test sets to create one data set
setwd("C:/Data_wd/assignment/UCI HAR Dataset")
traindata = read.table("./train/X_train.txt")
trainlabel = read.table("./train/y_train.txt")
trainsubject = read.table("./train/subject_train.txt")
testdata = read.table("./test/X_test.txt")
testlabel = read.table("./test/y_test.txt")
testsubject = read.table("./test/subject_test.txt")
mergedata = rbind(traindata,testdata)
mergelabel = rbind(trainlabel, testlabel)
mergesubject = rbind(trainsubject,testsubject)

# 2 extract the measurements on the mean and SD for each measurement
features = read.table("./features.txt")
meansd_features = grep("mean\\(\\)|std\\(\\)",features[,2])
extractmergedata = mergedata[,meansd_features]
names(extractmergedata) = gsub("\\(\\)","",features[meansd_features,2]) 
names(extractmergedata) = gsub("-","",names(extractmergedata))
names(extractmergedata) = gsub("mean","Mean",names(extractmergedata)) 
names(extractmergedata) = gsub("std","Std",names(extractmergedata)) 

# 3 use descriptive activity names to name the activities in dataset
activity = read.table("./activity_labels.txt")
activity[,2] = tolower(gsub("_","",activity[,2]))
substr(activity[2,2],8,8) = toupper(substr(activity[2,2],8,8))
substr(activity[3,2],8,8) = toupper(substr(activity[3,2],8,8))
allactivitylabel = activity[mergelabel[,1],2]
mergelabel[,1] = allactivitylabel 
names(mergelabel) = "activity" 

# 4 label dataset with descriptive variable names
names(mergesubject) = "subject"
cleandata = cbind(mergesubject, mergelabel, extractmergedata)
write.table(cleandata,"cleandata.txt",row.names=FALSE)

# 5 create a second tidy dataset with mean of variable for each activity and subject
num_of_subject = length(table(mergesubject))
num_of_activity = nrow(activity)
num_of_col = dim(cleandata)[2]
result=matrix(NA,nrow=num_of_subject* num_of_activity,ncol=num_of_col)
resultdf=as.data.frame(result) #change to dataframe
names(resultdf) = names(cleandata)
row=1
for(i in 1:num_of_subject) {
  for(j in 1:num_of_activity) {
   resultdf[row,1]=sort(unique(mergesubject)[,1])[i]
   resultdf[row,2]=activity[j,2]
   bool1 = i==cleandata$subject
   bool2 = activity[j,2]==cleandata$activity
   resultdf[row,3:num_of_col] = colMeans(cleandata[bool1&bool2,3:num_of_col])
   row = row + 1  
  }  
}
head(resultdf)  
write.table(resultdf,"tidydata2.txt",row.names=FALSE) #second dataset
  
  
  
  
  
  
  