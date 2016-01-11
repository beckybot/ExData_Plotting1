# read in power consumption data
power <- read.table("household_power_consumption.txt", sep=";", header=TRUE,
                    na.strings = "?", colClasses = c("character", "character",
                                                     "numeric", "numeric", "numeric",
                                                     "numeric", "numeric", "numeric",
                                                     "numeric"))

# select only records for Feb 1 & 2, 2007
powersub <- power[power$Date == "1/2/2007" | power$Date == "2/2/2007", ]

# make a histogram of global active power and save as a png file
png(file="plot1.png")
hist(powersub$Global_active_power, col="red", main="Global Active Power",
  xlab = "Global Active Power (kilowatts)")
dev.off()