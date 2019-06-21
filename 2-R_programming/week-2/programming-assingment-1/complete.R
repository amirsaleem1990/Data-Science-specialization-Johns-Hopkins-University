# part_2

library(data.table) 
library(dplyr)

complete <- function(directory, id = 1:332){
  files <- list.files(path = directory,pattern = ".csv")
  temp <- lapply(paste0(directory, "/", files), read.csv, sep=",")
  data <- rbindlist(temp)
  a <<- data
  if (min(id) == max(id)){ # this means single digit, not a range
    filtered_data <- data %>% filter(ID == id)
  }else{
    filtered_data <- data %>% filter(ID >= min(id), ID <= max(id))
  }
  na.removed.filter <- na.omit(filtered_data[filtered_data$ID %in% id,])
  na.removed.filter <- na.removed.filter %>% group_by(ID) %>% summarise(nobs = n())
  # if (id[1] > tail(id,1)){
  #   na.removed.filter <- na.removed.filter %>% arrange(desc(ID))
  # }
  b <<- na.removed.filter
  tbl_df(b)
}

# ok, from https://rstudio-pubs-static.s3.amazonaws.com/220397_d07534a9d3de4d0d87d7df9036602296.html
# results <- data.frame(id=numeric(0), nobs=numeric(0))
# for(monitor in id){
#     path <- paste(getwd(), "/", directory, "/", sprintf("%03d", monitor), ".csv", sep = "")
#     monitor_data <- read.csv(path)
#     interested_data <- monitor_data[(!is.na(monitor_data$sulfate)), ]
#     interested_data <- interested_data[(!is.na(interested_data$nitrate)), ]
#     nobs <- nrow(interested_data)
#     results <- rbind(results, data.frame(id=monitor, nobs=nobs))
# }
# results