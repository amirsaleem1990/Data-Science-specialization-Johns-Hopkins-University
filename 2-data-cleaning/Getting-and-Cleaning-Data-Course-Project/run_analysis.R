library(utils)
library(dplyr)

# official.help <- "https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "Dataset.zip")
utils::unzip("Dataset.zip")
# 1- Merges the training and the test sets to create one data set.
features.names <- read.table("UCI HAR Dataset/features.txt")
X.train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features.names$V2)
y.train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("target"))
subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

X.test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features.names$V2)
y.test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("target"))
subject.test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

df <- rbind(cbind(X.train, y.train, subject.train), cbind(X.test, y.test, subject.test))
# 2- Extracts only the measurements on the mean and standard deviation for each measurement.
length(grep("mean|std", names(df)))
# 3- Uses descriptive activity names to name the activities in the data set
activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt")
df$target <- activity.labels$V2[ match(df$target, activity.labels$V1)]
# 4- Appropriately labels the data set with descriptive variable names.
names(df) <- names(df) %>% 
  tolower() %>% 
  sub("^f", "frequency.", .) %>%  # every leading <F> replaced with <frequency.>
  sub("^tb", "time.b", .) %>%            # every leading <tB> replaced with <time.B>
  sub("^tg", "time.g", .) %>%          # every leading <tG> replaced with <time.G>
  sub("acc", ".acceleration.",. ) %>%   # every <Acc> replaced with <.acceleration.>
  sub("bodyg", "body.g", .) %>%          # every <BodyG> replaced with <Body.G>
  sub("gyrojerk", "gyro.jerk", .) %>%     # added dot btween <Gyro> and <Jerk> if dot is not exist 
  sub("jerkmag", "jerk.mag", .) %>%      # added dot between <Jerk> and <Mag> if dot isnot exist
  gsub("\\.[.]+", ".", .) %>% # every one or more dot/s with single dot, and lower all the list
  gsub("\\.$", "", .) %>% 
  sub("std", "standard.deviation", .) %>% # every <std> replaced with <Standard.deviation
  gsub("ymean", "y.mean",  .) %>% # every gravitymean to gravity.mean (once or more in each record)
  gsub("kmean", "k.mean", .) %>% 
  gsub("omean", "o.mean", .) %>% 
  gsub("sma", "signal.magnitude.area", .) %>% # <sma> ==> signal.magnitude.area
  gsub("mag", "magnitude", .) %>% # every <mag> replaced with <magnitude>
  sub("gyromagnitude", "gyro.magnitude", .) %>% #every <gyromagnitude> replaced with <gyro.magnitude>
  sub("\\.x", "\\.x.axis", .) %>%
  sub("\\.y", "\\.y.axis", .) %>% 
  sub("\\.z", "\\.z.axis", .) %>%
  sub("gyro", "gyroscope", .) %>% 
  sub("mad", "median.absolute.deviation", .) %>%
  sub("iqr", "interquartile.range", .) %>%
  sub("bodybody", "body", .)

# View(data.frame(orignal.names, names(df)))
# 5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
adf <- aggregate(df[, 1:561], list(df$target, df$subject), mean)
View(adf)