official_help <- "https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "Dataset.zip")
library(utils)
utils::unzip("Dataset.zip")
# 1- Merges the training and the test sets to create one data set.
features_names <- read.table("UCI HAR Dataset/features.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features_names$V2)
X_train['train/test'] <- "train"
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("target"))

X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features_names$V2)
X_test['train/test'] <- "test"
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("target"))

df <- rbind(cbind(X_train, y_train), cbind(X_test, y_test))
rm(features_names, X_train, y_train, X_test, y_test)
# 2- Extracts only the measurements on the mean and standard deviation for each measurement.
length(grep("mean|std", names(df)))
# 3- Uses descriptive activity names to name the activities in the data set
a <- sub("^f", "frequency.", names(df)) # every leading <F> replaced with <frequency.>
b <- sub("^tB", "time.B", a)            # every leading <tB> replaced with <time.B>
b2 <- sub("^tG", "time.G", b)           # every leading <tG> replaced with <time.G>
c <- sub("Acc", ".acceleration.", b2)   # every <Acc> replaced with <.acceleration.>
d <- sub("BodyG", "Body.G", c)          # every <BodyG> replaced with <Body.G>
e <- sub("GyroJerk", "Gyro.Jerk",d)     # added dot btween <Gyro> and <Jerk> if dot is not exist 
f <- sub("JerkMag", "Jerk.Mag", e)      # added dot between <Jerk> and <Mag> if dot isnot exist
g <- tolower(gsub("\\.$", "", gsub("\\.[.]+", ".", f))) # every one or more dot/s with single dot, and lower all the list
h <- sub("std", "Standard.deviation", g) # every <std> replaced with <Standard.deviation>
i <- gsub("[^?.]mean", "y.mean",  h) # every gravitymean to gravity.mean (once or more in each record)
j <- gsub("sma", "signal.magnitude.area", i) # <sma> ==> signal.magnitude.area
k <- gsub("mag", "magnitude", j) # every <mag> replaced with <magnitude>
l <- sub("gyromagnitude", "gyro.magnitude", k) #every <gyromagnitude> replaced with <gyro.magnitude>
names(df) <- l
# 4- Appropriately labels the data set with descriptive variable names.
# 5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
