# https://github.com/Deizu/ExData_Plotting1
# R Code to construct Plot 1

# Include code for reading in the data
# Construct the plot 
# Save the plot to a PNG file, 480 x 480 pixels.

# Load required libraries
library(lubridate)
library(dplyr)

# Read in the data.
# if(!exists("./data/")) {dir.create("./data/")}
# if!(exists("./data/household_power_consumption.txt")) {
#   
#   dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#   
#   download.file(dataurl,destfile="./data/data.zip",mode='wb')
#   
#   unzip(zipfile="./data/data.zip", files=NULL, list=FALSE, overwrite=FALSE, 
#       junkpaths=FALSE, exdir=paste(getwd(),"/data",sep=""), unzip="internal",
#       setTimes=FALSE)
#   
#   rm(dataurl)
#   }

rawdata <- read.table("./data/household_power_consumption.txt", header=TRUE,
                      sep=";", na.strings="?")

# Subset to grab only the 2 dates of interest.

data <- rbind(subset(rawdata,Date=="1/2/2007"),subset(rawdata,Date=="2/2/2007"))

row.names(data) <- NULL

# Convert to date and time formats with lubridate functions

data$Date <- dmy(data$Date)

data$Time <- hms(data$Time)

# Plot the histogram to a PNG device

png(file="plot1.png", width=480, height=480)

hist(data$Global_active_power,main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency",col="red",)

dev.off()
