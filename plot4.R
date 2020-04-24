# read data

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

data$date <- as.Date(strptime(as.character(data$Date),format = "%d/%m/%Y"))
newdata <- data[data$date >= "2007-02-01" & data$date <= "2007-02-02",]

newdata$fulldate <-  as.POSIXct(paste(newdata$date, newdata$Time, format = "%Y/%m/%d %H:%M:%S"))
newdata$Global_active_power <- as.numeric(as.character(newdata$Global_active_power))
newdata$Global_reactive_power <- as.numeric(as.character(newdata$Global_reactive_power))


# construct plot 4

png(filename = "plot4.png")

par(mfrow=c(2,2))

#add plot1
hist(newdata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",main = "Global Active Power")

#add plot2
plot(newdata$Global_active_power, type = "n", xaxt = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(newdata$Global_active_power)
axis(1,at=c(1,1440, 2880), labels = c("Thu","Fri", "Sat"))

#add plot3
plot(newdata$Sub_metering_1, type = "n", ylab = "Energy Sub metering",xaxt = "n", xlab = "")
lines(newdata$Sub_metering_1, col = "black")
lines(newdata$Sub_metering_2, col = "red")
lines(newdata$Sub_metering_3, col = "blue")

legend("topright",lty=c(1,1,1),lwd=c(2.5,2.5,2.5), col = c("black", "red", "blue"), 
       legend=(c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")))
axis(1,at=c(1,1440, 2880), labels = c("Thu","Fri", "Sat"))

#add plot 4

plot(newdata$Global_reactive_power, type = "n", xaxt = "n", xlab = "datetime", ylab = "global_reactive_power")
lines(newdata$Global_reactive_power, col = "black")
axis(1,at=c(1,1440, 2880), labels = c("Thu","Fri", "Sat"))

dev.off()
