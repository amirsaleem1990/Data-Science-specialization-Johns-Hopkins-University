df = read.csv("household_power_consumption.txt", sep=";", na.strings = "?")
adf <- df[df$Date %in% c("1/2/2007","2/2/2007") ,]

adf$datetime <- strptime(paste(adf$Date, adf$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
png("plot4.png", 
    width=480, 
    height=480)
par(mfrow = c(2, 2)) 

plot(adf$datetime, adf$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(adf$datetime, adf$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(adf$datetime, adf$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(adf$datetime, adf$Sub_metering_2, type="l", col="red")
lines(adf$datetime, adf$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
plot(adf$datetime, adf$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()



