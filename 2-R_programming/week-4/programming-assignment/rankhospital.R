rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  source("best.R")
  best(state, outcome)
  adf <- bdf
  adf <- na.omit(adf)
  adf <- arrange(adf, UQ(sym(var_name)), UQ(sym("hospital.name")))
  num = ifelse(num == "best", 1, ifelse(num == "worst", nrow(adf), num))
  adf[num,"hospital.name"]
}