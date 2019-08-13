if(!file.exists('household_power_consumption.txt')){
  unzip('exdata_data_household_power_consumption.zip')
}
data <- read.table('household_power_consumption.txt',sep=';',header = TRUE)

subsetData <- subset(data,data$Date=="1/2/2007" | data$Date =="2/2/2007")

subsetData$Date <- as.Date(subsetData$Date, format="%d/%m/%Y")
subsetData$Time <- strptime(subsetData$Time, format="%H:%M:%S")
subsetData[1:1440,"Time"] <- format(subsetData[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subsetData[1441:2880,"Time"] <- format(subsetData[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

png("plot4.png", width=480, height=480)

# initiating a composite plot with many graphs
par(mfrow=c(2,2))

# calling the basic plot function that calls different plot functions to build the 4 plots that form the graph
with(subsetData,{
  plot(subsetData$Time,as.numeric(as.character(subsetData$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(subsetData$Time,as.numeric(as.character(subsetData$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(subsetData$Time,subsetData$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(subsetData,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(subsetData,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(subsetData,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(subsetData$Time,as.numeric(as.character(subsetData$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})

dev.off()