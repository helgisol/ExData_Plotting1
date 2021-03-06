# Plotting Time Series.

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

plot2 <- function() {

  data <- readData()
  png(filename = "plot2.png", width = 480, height = 480)
  plot(data$Time, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  dev.off()
  NULL
}
