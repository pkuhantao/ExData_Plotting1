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
par(mar = c(12, 6, 4, 2)) ## set up margin sizes
with(data, plot(DateTime, Global_active_power, type="l", xlab="", 
                ylab="Global Active Power (kilowatts)"))
## copy into PNG file
dev.copy(device = png, file="plot2.png", width = 480, height = 480, units = "px")
## close the file
dev.off()


