# Plotting Multiple Time Series.

# Obtaining raw data.
obtainRawData <- function(dataFileName) {
  
  if (!file.exists(dataFileName)) {
    
    dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    zipFileName <- "exdata-data-household_power_consumption.zip"
    download.file(dataUrl, zipFileName, mode="wb")
    unzip(zipFileName)
    unlink(zipFileName)
    TRUE
  }
  else {
    
    FALSE
  }
}

# Read source data.
readData <- function() {
  
  dataFileName <- "household_power_consumption.txt"
  obtainRawData(dataFileName)
  data <- read.csv(dataFileName, sep=";", na.strings="?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))  
  data$Date <- as.Date(data$Date,"%d/%m/%Y")
  data <- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"),]
  data$Time <- strptime(paste(as.character(data$Date),data$Time), format="%Y-%m-%d %H:%M:%S")
  data
}

plot3 <- function() {

  data <- readData()
  png(filename = "plot3.png", width = 480, height = 480)
  plot(data$Time, data$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
  lines(data$Time, data$Sub_metering_2, col="red")
  lines(data$Time, data$Sub_metering_3, col="blue")
  legend("topright", lwd=1, col=c("black","red","blue"),legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  dev.off()
  NULL
}
