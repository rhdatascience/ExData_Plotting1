library(httr)
if(!file.exists("data")) { dir.create("data") }

zipFile = ".\\data\\exdata_data_household_power_consumption.zip"
if(!file.exists(zipFile)) { 
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = zipFile, method = "curl")
        unzip(zipFile, exdir = "data")
}
dataFile = ".\\data\\household_power_consumption.txt"
data <- read.table(dataFile, sep = ";", na.strings = "?", header = TRUE)

subData <- data[which(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]
subData$NewDate <- strptime(paste(subData$Date,subData$Time), "%d/%m/%Y %H:%M:%S")

#plot2
png(filename = "plot2.png", width = 480, height = 480)
with(subData, plot(subData$NewDate,subData$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)"))
points(subData$NewDate,subData$Global_active_power, type = "l")
dev.off()