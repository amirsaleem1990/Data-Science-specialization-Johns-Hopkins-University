df = read.csv("household_power_consumption.txt", sep=";", na.strings = "?")
library(lubridate)
df$Date <- dmy(df$Date)
df$Time <- hms(df$Time)
adf = subset(df, Date >= "2007-02-01" & Date <= "2007-02-02")
png(filename = "plot1.png", 
    width = 480, 
    height = 480)
hist(adf$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()