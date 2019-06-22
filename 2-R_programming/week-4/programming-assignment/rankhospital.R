rm(list=ls())
library(dplyr)

state <- "TX"
outcome <- "heart failure"
num = 4
rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  df <- df[df$State == state, c(2,7,11,17,23)]
  df <- dplyr::tbl_df(df)
  # convert column type 
  df[,c(3, 4, 5)][df[,c(3, 4, 5)] == "Not Available"] <- NA
  df[,c(3, 4, 5)] <- as.numeric(unlist(df[,c(3, 4, 5)]))
  names(df) <- tolower(gsub("[..]+", ".", names(df)))
  
  # replace space in <outcome> with dot <.>
  outcome <- gsub(" ", ".", tolower(outcome))
  
  ## Check that state and outcome are valid
  vars_names <- c("hospital.30.day.death.mortality.rates.from.heart.attack", 
                  "hospital.30.day.death.mortality.rates.from.heart.failure",
                  "hospital.30.day.death.mortality.rates.from.pneumonia")
  var_name <- grep(outcome, vars_names, value = T)
  if (state %in% df$state && any(grep(outcome, vars_names))){
    df <- df[complete.cases(df[, var_name]),]
    # sorting
    df <- arrange(df, state, get(var_name), hospital.name)
    num <- ifelse(num == "best", 1, ifelse(num == "worst", nrow(df) ,num))
    df[num, "hospital.name"]
  }
}
