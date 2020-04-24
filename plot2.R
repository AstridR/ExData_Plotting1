# read data

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

data$date <- as.Date(strptime(as.character(data$Date),format = "%d/%m/%Y"))
newdata <- data[data$date >= "2007-02-01" & data$date <= "2007-02-02",]

newdata$fulldate <-  as.POSIXct(paste(newdata$date, newdata$Time, format = "%Y/%m/%d %H:%M:%S"))
newdata$Global_active_power <- as.numeric(as.character(newdata$Global_active_power))
newdata$Global_reactive_power <- as.numeric(as.character(newdata$Global_reactive_power))

# construct plot 2

png(filename = "plot2.png")

plot(newdata$Global_active_power, type = "n", xaxt = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(newdata$Global_active_power)
axis(1,at=c(1,1440, 2880), labels = c("Thu","Fri", "Sat"))

dev.off()

