readData <- function() {
  
  data <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))  
  data$Date <- as.Date(data$Date,"%d/%m/%Y")
  data <- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"),]
  data$Time <- strptime(paste(as.character(data$Date),data$Time), format="%Y-%m-%d %H:%M:%S")
  data
}

plot4 <- function() {

  data <- readData()
  png(filename = "plot4.png", width = 480, height = 480)
  par(mfrow=c(2,2))
  
  plot(data$Time, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  
  plot(data$Time, data$Voltage, type="l", xlab="datetime", ylab="Voltage")

  plot(data$Time, data$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
  lines(data$Time, data$Sub_metering_2, col="red")
  lines(data$Time, data$Sub_metering_3, col="blue")
  legend("topright", lwd=1, col=c("black","red","blue"),legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
  
  plot(data$Time, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  dev.off()
  NULL
}
