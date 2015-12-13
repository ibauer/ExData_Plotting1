Sys.setlocale("LC_TIME", "en_US")
library("data.table")
head <- read.table("household_power_consumption.txt", nrows=10, sep=";", 
                   header = T)
names <- colnames(head)
data <- fread ("grep ^[12]/2/2007 household_power_consumption.txt", 
               na.strings = "?", nrows = 2*24*60)
setnames(data, names)

data$Date <- as.IDate(strptime(data$Date, format = "%d/%m/%Y", tz="GMT"))

data$Time <- as.ITime(data$Time)
data$Date_time <- as.POSIXct (data$Date, data$Time, tz="GMT")

#Plot4
png(filename="plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

#Plot4.1
plot(data$Date_time, data$Global_active_power, type="l", 
     ylab="Global Active Power",
     xlab="")

#Plot4.2
plot(data$Date_time, data$Voltage, type="l", 
     ylab="Voltage",
     xlab="datetime")


#Plot4.3
plot(data$Date_time, data$Sub_metering_1, type = "l", 
     xlab="",ylab = "Energy sub metering")
lines(data$Date_time,data$Sub_metering_2, col = "red")
lines(data$Date_time,data$Sub_metering_3, col = "blue")
legend("topright", names[7:9], lwd = 1, col = c("black", "red", "blue"),
       bty = "n", y.intersp = 1)

#Plot4.4
plot(data$Date_time, data$Global_reactive_power, type="l", 
     ylab=names[4],
     xlab="datetime")

dev.off()