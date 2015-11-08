readData <- function() {
  
  data <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))  
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
