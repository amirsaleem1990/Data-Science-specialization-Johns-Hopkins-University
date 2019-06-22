rankall <- function(outcome, num = "best") {
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  df <- dplyr::tbl_df(df)
  df[,c(11, 17, 23)][df[,c(11, 17, 23)] == "Not Available"] <- NA
  df[,c(11, 17, 23)] <- as.numeric(unlist(df[,c(11, 17, 23)]))
  names(df) <- tolower(gsub("[..]+", ".", names(df)))
  
  outcome <- gsub(" ", ".", tolower(outcome))
  
  ## Check that state and outcome are valid
  vars_names <- c("hospital.30.day.death.mortality.rates.from.heart.attack", 
                  "hospital.30.day.death.mortality.rates.from.heart.failure",
                  "hospital.30.day.death.mortality.rates.from.pneumonia")
  
  if (any(grep(outcome, vars_names))){

    var_name <- grep(outcome, vars_names, value = T)
    splited = split(df, df$state)
    ans = lapply(splited, function(x){
      adf <- x[order(x[var_name], x["hospital.name"]),]
      n = ifelse(num == "best", 1, ifelse(num == "worst", nrow(x), num))
      adf[n,"hospital.name"]
    })
    data.frame(hospital=unlist(ans), state=names(ans))
  }else stop("invalid state")
  
}
tail(rankall("pneumonia", "worst"), 3)
# outcome <- "pneumonia"
# num <- "worst"
