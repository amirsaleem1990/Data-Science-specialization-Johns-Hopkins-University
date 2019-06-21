# part_1
library(data.table) 
library(dplyr)
pollutantmean <- function(directory, pollutant, id = 1:332){
  files <- list.files(path = directory,pattern = ".csv")
  temp <- lapply(paste0(directory, "/", files), read.csv, sep=",")
  data <- rbindlist(temp)
  if (class(id) == "numeric"){ # this means the <id> is single digit, not a range
    filtered.data <- data %>% filter(ID == id)
  }else if(class(id) == "integer"){# this means the <id> is range
    filtered.data <- data %>% filter(ID >= range(id)[1], ID <= range(id)[2])
  }
  
  mean(filtered.data[[pollutant]], na.rm = T)
}