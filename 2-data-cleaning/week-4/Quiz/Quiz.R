library(dplyr)
# Q1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url = url, destfile = "American_Community_Survey.csv")
df = read.csv("American_Community_Survey.csv")
strsplit(names(df), "wgtp")[123]

# Q2
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url = url, destfile = "Gross_Domestic_Product.csv")
df = read.csv("Gross_Domestic_Product.csv",header = T, skip = 3)
df = df[-c(1, 192:327),]
df["US.dollars."] <- gsub(" ", "", gsub(",", "", df$`US.dollars.`))
df$US.dollars. <- as.integer(df$US.dollars.)
mean(df$US.dollars.)


# Q3
grep("^United", df$Economy, value = T) #3

# Q4
Gross_Domestic_Product = read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",header = T, skip = 3)
Gross_Domestic_Product = Gross_Domestic_Product[-c(1, 192:327),]
Gross_Domestic_Product <- Gross_Domestic_Product[,c(1,2,4,5,6)]
colnames(Gross_Domestic_Product)[1] <- "CountryCode"

educational= read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")

m <- merge(Gross_Domestic_Product, educational, by = "CountryCode")
a = as.vector(grep("Fiscal year end: ", m$Special.Notes, value = T))
length(grep("June", a))


# Q5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)