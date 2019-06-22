# setwd("github/datasciencecoursera/2-R_programming/week-4/programming-assignment/")
# unzip("rprog_data_ProgAssignment3-data.zip")

library(dplyr)
best <- function(state, outcome) {
  ## Read outcome data
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  df <- dplyr::tbl_df(df)
  # convert column type 
  df[,c(11, 17, 23)][df[,c(11, 17, 23)] == "Not Available"] <- NA
  df[,c(11, 17, 23)] <- as.numeric(unlist(df[,c(11, 17, 23)]))
  names(df) <- tolower(gsub("[..]+", ".", names(df)))
  
  # replace space in <outcome> with dot <.>
  outcome <- gsub(" ", ".", tolower(outcome))
  
  ## Check that state and outcome are valid
  vars_names <- c("hospital.30.day.death.mortality.rates.from.heart.attack", 
                  "hospital.30.day.death.mortality.rates.from.heart.failure",
                  "hospital.30.day.death.mortality.rates.from.pneumonia")
  
  if (state %in% df$state && any(grep(outcome, vars_names))){
    
    bdf <<- df # here we assign value to global, and in next script i'll use it
    df <- df[df$state == state, ]
    var_name <<- grep(outcome, vars_names, value = T) # here we assign value to global, and in next script i'll use it
    minimum <- min(df[,var_name], na.rm = T)
    
    df[which(df[[var_name]] == minimum),"hospital.name"]
    
  }else stop("invalid state")
}