library(dplyr)
library(lubridate)

datax <- read.table("household_power_consumption.txt",skip=66637,nrow=2879)
datax.sorted <- separate(datax,col=V1,into=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),sep=";")

#Convert the Date column into PoSIXlt/ct format
datax.sorted$Date <- dmy(datax.sorted$Date)
datax.sorted$Time <- hms(datax.sorted$Time)

#Convert the charachter strings into numeric
datax.sorted[,3:9] <- sapply(datax.sorted[,3:9],as.numeric)

#Merge the date and time columns
datax.sorted$Complete.Date <- datax.sorted$Date + datax.sorted$Time

par(mfrow=c(2,2),mar=c(2,4,2,1))

#Plot the data
plot(datax.sorted$Complete.Date,datax.sorted$Global_active_power,type="l",xlab="",ylab="Global Active Power") #Graph 1
plot(datax.sorted$Complete.Date,datax.sorted$Voltage,type="l",xlab="datetime",ylab="Voltage") #Graph 2
with(datax.sorted, plot(Complete.Date,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=""))
lines(datax.sorted$Complete.Date,datax.sorted$Sub_metering_2,type="l",col="red")   #Graph 3
lines(datax.sorted$Complete.Date,datax.sorted$Sub_metering_3,type="l",col="blue")
legend("topright",lty = 1,lwd=3,col=c("black","blue","red"),legend=c("Sub metering 1","Sub metering 2","Sub metering 3"),bty="n")
plot(datax.sorted$Complete.Date,datax.sorted$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l") #Graph 4

#Export the plot
dev.copy(png,"plot4.png")
dev.off()
print("The plot generated is saved as plot4.png in the working directory")