# Assignment1 - Plot 1

setwd("Z:/Dokumente/Arbeit/Fortbildungen/DataScience-Specialization/coursera-exploratorydataanalysis/assignment1")

# read data and filter according to the correct dates

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

data$date <- as.Date(strptime(as.character(data$Date),format = "%d/%m/%Y"))
newdata <- data[data$date >= "2007-02-01" & data$date <= "2007-02-02",]

newdata$fulldate <-  as.POSIXct(paste(newdata$date, newdata$Time, format = "%Y/%m/%d %H:%M:%S"))
newdata$Global_active_power <- as.numeric(as.character(newdata$Global_active_power))
newdata$Global_reactive_power <- as.numeric(as.character(newdata$Global_reactive_power))

# construct plot 1 
png(filename = "plot1.png")

hist(newdata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",main = "Global Active Power")

dev.off()

# construct plot 2
png(filename = "plot2.png")

plot(newdata$Global_active_power, type = "n", xaxt = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(newdata$Global_active_power)
axis(1,at=c(1,1440, 2880), labels = c("Thu","Fri", "Sat"))

dev.off()

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
