# https://github.com/Deizu/ExData_Plotting1
# R Code to construct Plot 4

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

data$datetime <- paste(data$Date, data$Time)

data$datetime <- strptime(data$datetime,format="%d/%m/%Y %H:%M:%S")

# Convert to date and time formats with lubridate functions

data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)

# Plot the graph

png(file="plot4.png", width=480, height=480)

par(mfrow = c(2,2), pty="s", mar=c(4,4,1,1))

with(data, {
  
  plot(datetime, Global_active_power, typ="l", sub="",
       xlab="", ylab="Global Active Power")
  
  plot(datetime, Voltage, typ="l", sub="",
       xlab="datetime", ylab="Voltage")
  
  plot(datetime, Sub_metering_1, type="l", xlab="", 
                   ylab="Energy sub metering") 
  lines(datetime, Sub_metering_2, col="red")
  lines(datetime, Sub_metering_3, col="blue")
  legend("topright", lty=1, bty="n", col=c("black","blue","red"), 
                     legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

  plot(datetime, Global_reactive_power, typ="l", xlab="datetime",
       ylab="Global_reactive_power")
  }
)

dev.off()
