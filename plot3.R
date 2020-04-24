# read data

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

data$date <- as.Date(strptime(as.character(data$Date),format = "%d/%m/%Y"))
newdata <- data[data$date >= "2007-02-01" & data$date <= "2007-02-02",]

newdata$fulldate <-  as.POSIXct(paste(newdata$date, newdata$Time, format = "%Y/%m/%d %H:%M:%S"))
newdata$Global_active_power <- as.numeric(as.character(newdata$Global_active_power))
newdata$Global_reactive_power <- as.numeric(as.character(newdata$Global_reactive_power))

# construct plot 3

newdata$Sub_metering_1 <- as.numeric(as.character(newdata$Sub_metering_1))
newdata$Sub_metering_2 <- as.numeric(as.character(newdata$Sub_metering_2))
newdata$Sub_metering_3 <- as.numeric(as.character(newdata$Sub_metering_3))

png(filename = "plot3.png")

plot(newdata$Sub_metering_1, type = "n", ylab = "Energy Sub metering", xlab = "", xaxt = "n")
lines(newdata$Sub_metering_1, col = "black", col.lab = "white")
lines(newdata$Sub_metering_2, col = "red")
lines(newdata$Sub_metering_3, col = "blue")

axis(1,at=c(1,1440, 2880), labels = c("Thu","Fri", "Sat"))

legend("topright",lty=c(1,1,1),lwd=c(2.5,2.5,2.5), col = c("black", "red", "blue"), 
       legend=(c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")))

dev.off()