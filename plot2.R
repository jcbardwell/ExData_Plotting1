# This script creates a plot for Global Active Power from Feb 1, 2007 to Feb 2, 2007

# Download and unzip file to working directory
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
unzip("household_power_consumption.zip")

# Only using Date = Feb 1, 2007 and Feb 2, 2007
# Date data is formatted dd/mm/yyyy i.e. use 1/2/2007 and 2/2/2007
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
library(dplyr)
data <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

# Combine Date and Time into a new "DateTime" column that will be used for plotting
data <- mutate(data, DateTime = paste(data$Date, data$Time))
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

# Convert "Global_active_power" column to a numeric so it can be plotted
data$Global_active_power <- as.numeric(data$Global_active_power)

# Create png file, add plot to it, close png file
png(filename="plot2.png")
plot(x=data$DateTime, y=data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()