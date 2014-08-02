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

#plot4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

with(subData, plot(subData$NewDate,subData$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power"))
points(subData$NewDate,subData$Global_active_power, type = "l")

with(subData, plot(subData$NewDate,subData$Voltage, type = "n", xlab = "datetime", ylab = "Voltage"))
points(subData$NewDate,subData$Voltage, type = "l")

with(subData, plot(subData$NewDate,subData$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", cex = 0.8)
points(subData$NewDate,subData$Sub_metering_1, type = "l")
points(subData$NewDate,subData$Sub_metering_2, type = "l", col = "red")
points(subData$NewDate,subData$Sub_metering_3, type = "l", col = "blue")

with(subData, plot(subData$NewDate,subData$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power"))
points(subData$NewDate,subData$Global_reactive_power, type = "l")
dev.off()



