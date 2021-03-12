# This script creates a plot for Energy Sub Meters from Feb 1, 2007 to Feb 2, 2007

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

# Convert the submeter columns to numerics so they can be plotted
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Create png file, add plot to it, close png file
png(filename="plot3.png")
plot(x=data$DateTime, y=data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", col="black")
points(x=data$DateTime, y=data$Sub_metering_2, type="l", col="red")
points(x=data$DateTime, y=data$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()