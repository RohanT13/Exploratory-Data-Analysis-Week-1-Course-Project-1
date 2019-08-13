if(!file.exists('household_power_consumption.txt')){
  unzip('exdata_data_household_power_consumption.zip')
}
data <- read.table('household_power_consumption.txt',sep=';',header = TRUE)

subsetData <- subset(data,data$Date=="1/2/2007" | data$Date =="2/2/2007")

subsetData$Date <- as.Date(subsetData$Date, format="%d/%m/%Y")
subsetData$Time <- strptime(subsetData$Time, format="%H:%M:%S")
subsetData[1:1440,"Time"] <- format(subsetData[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subsetData[1441:2880,"Time"] <- format(subsetData[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


png("plot2.png", width=480, height=480)

plot(subsetData$Time,subsetData$Global_active_power,type = 'l',xlab='',ylab = 'Global Active Power(kilowatts)')

dev.off()