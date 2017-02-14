library("data.table")
library("dplyr")

#source files getting
#download zip files if data doesn't exists
if(!file.exists("./UCI HAR Dataset"))
{
  if (!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="./getdata_projectfiles_UCI HAR Dataset.zip")
  }
  # Unzip dataSet to data directory
  unzip(zipfile="./getdata_projectfiles_UCI HAR Dataset.zip")
}

#read source files
y_train<-fread("./UCI HAR Dataset/train/y_train.txt")
x_train<-fread("./UCI HAR Dataset/train/x_train.txt")
ftr<-fread("./UCI HAR Dataset/features.txt")
sub_train<-fread("./UCI HAR Dataset/train/subject_train.txt")
x_test<-fread("./UCI HAR Dataset/test/x_test.txt")
y_test<-fread("./UCI HAR Dataset/test/y_test.txt")
sub_test<-fread("./UCI HAR Dataset/test/subject_test.txt")
act_lbl<-fread("./UCI HAR Dataset/activity_labels.txt")


#merge train and test sets (x, y and subjects)
x_train<-x_train[,grepl("mean|std",ftr$V2),with=FALSE]
names(x_train)<-ftr$V2[grepl("mean|std",ftr$V2)]
names(y_train)<-"Activity class"
x_test<-x_test[,grepl("mean|std",ftr$V2),with=FALSE]
names(x_test)<-ftr$V2[grepl("mean|std",ftr$V2)]
names(y_test)<-"Activity class"
train<-cbind(x_train,y_train,sub_train)
test<-cbind(x_test,y_test,sub_test)
dataSet<-rbind(train,test)

#merging activity labels
dataSet[order(dataSet$`Activity class`),]
names(act_lbl)[1]<-"Activity class"
dataSet<-merge(dataSet,act_lbl,by="Activity class",all=TRUE)

#add data labels
names(dataSet)[82]="Activity label"
names(dataSet)[81]="Subject"

#create output file with summary
write.table(aggregate(dataSet[,2:80],dataSet[,81:82],mean),"tidySet.txt", row.name=FALSE)