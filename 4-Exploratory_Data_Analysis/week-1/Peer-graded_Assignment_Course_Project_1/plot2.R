df = read.csv("household_power_consumption.txt", sep=";", na.strings = "?")
adf <- df[df$Date %in% c("1/2/2007","2/2/2007") ,]
adf$datetime <- datetime <- strptime(paste(adf$Date, adf$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
png(filename = "plot2.png",
    width = 480,
    height = 480)
plot(adf$datetime, adf$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
