# https://github.com/Deizu/ExData_Plotting1
# R Code to construct Plot 2

# Load required libraries

require(lubridate)

#Check for data and download it if needed

# if(!file.exists("./data")) {dir.create("./data")}
# if(!file.exists("./data/household_power_consumption.txt")) {
#   
#   dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#   
#   download.file(dataurl,destfile="./data/data.zip",mode='wb')
#   
#   unzip(zipfile="./data/data.zip", files=NULL, list=FALSE, overwrite=FALSE, 
#         junkpaths=FALSE, exdir=paste(getwd(),"/data",sep=""), unzip="internal",
#         setTimes=FALSE)
#   
#   rm(dataurl)
# }

# Read data into environment

cc <- c("character", "character", "numeric", "numeric", "numeric", "numeric",
        "numeric", "numeric", "numeric")

rawdata <- read.table("./data/household_power_consumption.txt", header=TRUE,
                      sep=";", na.strings="?", colClasses=cc)

# Subset to grab only the 2 dates of interest.

data <- rbind(subset(rawdata,Date=="1/2/2007"),subset(rawdata,Date=="2/2/2007"))

row.names(data) <- NULL

data$DT <- paste(data$Date, data$Time)

data$DT <- strptime(data$DT,format="%d/%m/%Y %H:%M:%S")

# Convert to date and time formats with lubridate functions

data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)

# Plot the graph

png(file="plot2.png", width=480, height=480)

plot(x=data$DT, y=data$Global_active_power, typ="l", sub="",
     xlab="", ylab="Global Active Power (kilowatts)")

dev.off()