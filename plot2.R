library(tidyr)
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

#Plot the data
plot(datax.sorted$Complete.Date,datax.sorted$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

#Export the plot
dev.copy(png,"plot2.png")
dev.off()
print("The plot generated is saved as plot2.png in the working directory")
