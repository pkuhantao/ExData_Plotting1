## required data file: "household_power_consumption.txt"
## required package: "sqldf"

## clear all at first
rm(list=ls())
## load the library "sqldf" to do sql query to extract certain data
library(sqldf)
## read the particular data for 2007-02-01 and 2007-02-02
filename <- "household_power_consumption.txt"
sqlQuery <- "select * from file where Date = '1/2/2007' or Date = '2/2/2007'"
data <- read.csv2.sql(filename, sql = sqlQuery)
## combine Date and Time together, then convert to Time class
data$DateTime <- paste(data$Date, data$Time, sep = " ")
data$DateTime <- strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")
## generate the plot in screen device
quartz()  ## open the device
par(mfrow=c(2,2), mar = c(4, 4, 2, 1), oma = c(8, 2, 2, 0)) 
## sub-plot1
with(data, plot(DateTime, Global_active_power, type="l", xlab="", 
                ylab="Global Active Power"))
## sub-plot2
with(data, plot(DateTime, Voltage, type="l", xlab="datetime", 
                ylab="Voltage"))
## sub-plot3
with(data, plot(DateTime, Sub_metering_1, type="l", col="Black", xlab="", ylab="Energy sub metering"))
with(data, lines(DateTime, Sub_metering_2, col="Red", xlab="", ylab="Energy sub metering"))
with(data, lines(DateTime, Sub_metering_3, col="Blue", xlab="", ylab="Energy sub metering"))
legend("topright", lty=1, col=c("Black", "Red", "Blue"), bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## sub-plot4
with(data, plot(DateTime, Global_reactive_power, type="l", xlab="datetime", 
                ylab="Global_reactive_power"))

## copy into PNG file
dev.copy(device = png, file="plot4.png", width = 480, height = 480, units = "px")
## close the file
dev.off()


