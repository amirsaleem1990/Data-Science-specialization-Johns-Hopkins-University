library(data.table) 
library(dplyr)
# part 3
corr <- function(directory, threshold = 0){
  files <- list.files(path = directory,pattern = ".csv")
  temp <- lapply(paste0(directory, "/", files), read.csv, sep=",")
  data <- na.omit(rbindlist(temp))
  ids.counts.above.threshold.df <- data %>% 
    dplyr::group_by(ID) %>% 
    dplyr::summarise(count = n()) %>% 
    dplyr::filter(count > threshold)
  ids.counts.above.threshold.IDs.list <- ids.counts.above.threshold.df[["ID"]]
  for.correlaction <- data %>% filter(ID %in% ids.counts.above.threshold.IDs.list)
  dt <- data.table(for.correlaction)
  dt[, .(cor = cor(nitrate,sulfate)), by=ID][["cor"]]
}

# ok https://rstudio-pubs-static.s3.amazonaws.com/220397_d07534a9d3de4d0d87d7df9036602296.html
#     cor_results <- numeric(0)
    
#     complete_cases <- complete(directory)
#     complete_cases <- complete_cases[complete_cases$nobs>=threshold, ]
#     #print(complete_cases["id"])
#     #print(unlist(complete_cases["id"]))
#     #print(complete_cases$id)
    
#     if(nrow(complete_cases)>0){
#         for(monitor in complete_cases$id){
#             path <- paste(getwd(), "/", directory, "/", sprintf("%03d", monitor), ".csv", sep = "")
#             #print(path)
#             monitor_data <- read.csv(path)
#             #print(monitor_data)
#             interested_data <- monitor_data[(!is.na(monitor_data$sulfate)), ]
#             interested_data <- interested_data[(!is.na(interested_data$nitrate)), ]
#             sulfate_data <- interested_data["sulfate"]
#             nitrate_data <- interested_data["nitrate"]
#             cor_results <- c(cor_results, cor(sulfate_data, nitrate_data))
#         }
#     }
#     cor_results
# }