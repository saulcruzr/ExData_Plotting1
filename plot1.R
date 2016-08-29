
#Loading the data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
epc<-read.table(unz(temp,"household_power_consumption.txt"),sep=";",header=TRUE)
unlink(temp)

#Convert Date attribute to Date Data Type
epc$Date<-as.Date(as.character(epc$Date),"%d/%m/%Y")
epc$Global_active_power<-as.numeric(as.character(epc$Global_active_power))

#For performance purposes we filter data by dates: 2007-02-01 and 2007-02-02
epc<-epc[epc$Date==as.Date("2007-02-01")|epc$Date==as.Date("2007-02-02"),]

#Global Active Power Plot, Frequency vs Global Active Power(kilowatts)
#Global_active_power: household global minute-averaged active power (in kilowatt)
#Active power is measured in watts (W) and is the power drawn by the electrical resistance of a system doing useful work.
#Reactive power is the power not used to do work on the load.

#Plotting histogram
hist(epc$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")

#Saving Plot 1 as PNG
dev.copy(png,file="plot1.png")
dev.off() ##Don't forget to close the PNG device
