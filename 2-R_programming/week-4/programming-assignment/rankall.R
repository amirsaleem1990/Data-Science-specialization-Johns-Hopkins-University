library(dplyr)
rankall <- function(outcome, num = "best") {
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  df <- dplyr::tbl_df(df)
  df[,c(11, 17, 23)][df[,c(11, 17, 23)] == "Not Available"] <- NA
  df[,c(11, 17, 23)] <- as.numeric(unlist(df[,c(11, 17, 23)]))
  
  df <- df[,c(2,7,11,17,23)]

  # all 2 or more dots <.> replaced with single dot <.>
  names(df) <- tolower(gsub("[..]+", ".", names(df)))
  
  # replace while space in <outcome> with single dot <.>
  outcome <- gsub(" ", ".", tolower(outcome))
  
  vars_names <- names(df)[3:5]
  var_name <- grep(outcome, vars_names, value = T)
  
  if (any(grep(outcome, vars_names))){
    # drop all rows that are NAs in column var_name (our column)
    df <- df[complete.cases(df[, var_name]),]

    # sorting
    df <- arrange(df, state, get(var_name), hospital.name)

    # split data by <state>
    splited = split(df, df$state)
    ans = lapply(splited, function(x){
      n = ifelse(num == "best", 1, ifelse(num == "worst", nrow(x), num))
      x[n,"hospital.name"]
    })
    data.frame(hospital=unlist(ans), state=names(ans))
  }else stop("invalid state")
  
}