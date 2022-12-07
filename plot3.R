# get data from the website
ZipDataDir <- "./ZipData"
ZipURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
Filename <- "ZipData.zip"
File <- paste(ZipDataDir, "/", Filename, sep = "")

if (!file.exists(ZipDataDir)) {
    dir.create(ZipDataDir)
    download.file(url = ZipURL, destfile = File)
}

# extract (unzip) data
DataDir <- "./Data"
if (!file.exists(DataDir)) {
    dir.create(DataDir)
    unzip(zipfile = File, exdir = DataDir)
}

# read data
data_complete <- read.table("./Data/household_power_consumption.txt", header=TRUE, na.strings = "?", sep = ";")
data <- data_complete[(data_complete$Date == "1/2/2007" | data_complete$Date == "2/2/2007" ), ]

# format date and time
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
DateTime <- paste(data$Date, data$Time)
data$DateTime <- as.POSIXct(DateTime)

# export file plot 3
png(file = "plot3.png", width = 480, height = 480)
plot(data$Sub_metering_1 ~ data$DateTime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(data$Sub_metering_2 ~ data$DateTime, type = "l", col = "Red")
lines(data$Sub_metering_3 ~ data$DateTime, type = "l", col = "Blue")
legend("topright", lty = 1, col = c("Black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
