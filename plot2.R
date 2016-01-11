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
powersub$datetime2 <- strptime(powersub$datetime, format='%d/%m/%Y %H:%M:%S')

# make a line graph of global active power and save as a png file
png(file="plot2.png")
with(powersub, plot(datetime2, Global_active_power, 
                    xlab = "",
                    ylab = "Global Active Power (kilowatts)",
                    mar = c(1, 3, 2, 1),
                    type="n"))
lines(powersub$datetime2, powersub$Global_active_power)
dev.off()
