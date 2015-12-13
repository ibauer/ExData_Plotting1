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
#Plot1
png(filename="plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col = "red", 
              main = "Global Active Power", 
              xlab = "Global Active Power (kilowatts)" )
dev.off()
