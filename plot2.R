##assuming that the file household_power_consumption.txt is in ./data/ directory
#Loading the data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
epc<-read.table(unz(temp,"household_power_consumption.txt"),sep=";",header=TRUE)
unlink(temp)

#Convert Date attribute to Date Data Type
epc$Date<-as.Date(as.character(epc$Date),"%d/%m/%Y")

#For performance purposes we filter data by dates: 2007-02-01 and 2007-02-02
epc<-epc[epc$Date==as.Date("2007-02-01")|epc$Date==as.Date("2007-02-02"),]
epc$Global_active_power<-as.numeric(as.character(epc$Global_active_power))
#add  column
epc$weekday<-as.factor(weekdays(epc$Date))
epc$weekdayn<-as.POSIXlt(epc$Date)$wday
epc$datetime<-as.POSIXct(paste(epc$Date, epc$Time), format="%Y-%m-%d %H:%M:%S")
epcdf<-epc[order(epc[,10]),]
#Plotting 
##ggplot(epcdf,aes(y=Global_active_power,x=datetime)) + geom_line() +xlab("")+ylab("Global Active Power (Kilowatts)")
plot(epc$datetime,epc$Global_active_power,type="l",xlab="",ylab="Global Active Power (Kilowatts)")
#Saving Plot 1 as PNG
dev.copy(png,file="plot2.png")
dev.off() ##Don't forget to close the PNG device

