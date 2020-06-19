## script assumes diplr package has been installed and called
## Step 1 :Merge (append) two data sets
fileURLZip <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURLZip, destfile= "temp.zip", method = "curl")
unzip("temp.zip")
## read txt files into data frame
testX <- read.table("UCI HAR Dataset/test/X_test.txt") ## 2947 obs from 561 variables
testS <- read.table("UCI HAR Dataset/test/y_test.txt") ## 2947 obs Subject ID records
testA <- read.table("UCI HAR Dataset/test/subject_test.txt") ## 2947 obs activity records
Varnames <- read.table("UCI HAR Dataset/features.txt") ## 2 columns,  V1 number counter V2 561 variables names
colnames(testX) <- Varnames$V2 ## assign V2 to variables
testX[c("SubjectID","Activity")] <- c(testA, testS) ## add 2 cols to testX
trainX <- read.table("UCI HAR Dataset/train/X_train.txt") ## 7352 obs 561 variable
trainS <- read.table("UCI HAR Dataset/train/Y_train.txt") ## 7352 Subject ID
trainA <- read.table("UCI HAR Dataset/train/subject_train.txt") ## 7352 Activity records
colnames(trainX) <- Varnames$V2 ## assign V2 to variables
trainX[c("SubjectID","Activity")] <- c(trainA, trainS) ## add 2 cols to trainX
## Appened test and traning data sets with rbind
mergeDS <- rbind(testX, trainX) ## output from Step 1
## tidy up
unlink("temp.zip")
unlink("UCI HAR Dataset", recursive = TRUE) ## removes sub-directories
rm(fileURLZip,testX,testS,testA,trainX,trainS,trainA,Varnames)
## Step 2 
## use grep to extract mean and std variables by subsetting, SubjectID and Activity included in extracted df
## returns 33 mean and 33 corresponding std results, mean Freq excluded as based on weighted average in raw data
## mean's used in context of angle excldued as they relate only to the angle variable. 
meancols <- grep("\\bmean()\\b",names(mergeDS))
## value = TRUE to check variable 53 variables, includes "Meanfreq" and 3 XYZ arrays not in 33 std variables
stdcols <- grep("[Ss]td",names(mergeDS))
summary_col <- c(562,563,meancols, stdcols) ## add SubjectID and Activity to extracted data set
xtractDS <- mergeDS[ , summary_col] ## mean and std measurements with Activiy and subject ID
rm( mergeDS, meancols, stdcols, summary_col)

## step 3
## assign activites to observations
## tried lapply with gsub but failed
xtractDS$Activity[xtractDS$Activity==1] <- "Walking"
xtractDS$Activity[xtractDS$Activity==2] <- "Walking Up"
xtractDS$Activity[xtractDS$Activity==3] <- "Walking Down"
xtractDS$Activity[xtractDS$Activity==4] <- "Sitting"
xtractDS$Activity[xtractDS$Activity==5] <- "Standing"
xtractDS$Activity[xtractDS$Activity==6] <- "Laying"
  
## step 4
## using variable names consistent with "features.txt"
## tidy variable names remove parenthesis,commas and dashes
## keep capitislation per raw data for idnetification
names(xtractDS)<-gsub("[()]", "",names(xtractDS))
names(xtractDS)<-gsub("-", "", names(xtractDS))
names(xtractDS)<-gsub(",", "", names(xtractDS))

## step 5 
## group by activity and by subject then summarise mean
## library(dplyr)
result <-
  xtractDS %>%
  group_by(Activity, SubjectID) %>%
  summarise_all(mean) 
write.table(result, file ="tidyAssignment.txt", row.name = FALSE)
rm(xtractDS,result)
