# read in power consumption data
power <- read.table("household_power_consumption.txt", sep=";", header=TRUE,
                    na.strings = "?", colClasses = c("character", "character",
                                                     "numeric", "numeric", "numeric",
                                                     "numeric", "numeric", "numeric",
                                                     "numeric"))

# select only records for Feb 1 & 2, 2007
powersub <- power[power$Date == "1/2/2007" | power$Date == "2/2/2007", ]

# paste the date and time into one field
library(stringr)
powersub$datetime <- paste(powersub$Date, powersub$Time)

# convert datetime from character to date/time
powersub$datetime <- strptime(powersub$datetime, format='%d/%m/%Y %H:%M:%S')

# make a line graph of global active power and save as a png file
png(file="plot4.png")
par(mfcol = c(2,2))
with (powersub, {
          plot(datetime, Global_active_power, 
                         xlab = "",
                         ylab = "Global Active Power (kilowatts)",
                         type="n")
          lines(powersub$datetime, powersub$Global_active_power)
     
          plot(datetime, Sub_metering_1, 
                xlab = "",
                ylab = "Energy sub metering",
                type="n")
          lines(powersub$datetime, powersub$Sub_metering_1)
          lines(powersub$datetime, powersub$Sub_metering_2, col="red")
          lines(powersub$datetime, powersub$Sub_metering_3, col="blue")
          legend("topright", lwd=1, col=c("black", "red", "blue"), 
                 legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
          
          plot(datetime, Voltage, type="n")
          lines(powersub$datetime, powersub$Voltage)

          plot(datetime, Global_reactive_power, type="n")
          lines(powersub$datetime, powersub$Global_reactive_power)
     })
dev.off()
