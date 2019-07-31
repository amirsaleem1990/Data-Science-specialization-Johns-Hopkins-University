df = read.csv("household_power_consumption.txt", sep=";", na.strings = "?")
adf <- df[df$Date %in% c("1/2/2007","2/2/2007") ,]

adf$datetime <- strptime(paste(adf$Date, adf$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
png("plot3.png", 
    width=480, 
    height=480)
plot(adf$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(adf$Sub_metering_2, type="l", col="red")
lines(adf$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()