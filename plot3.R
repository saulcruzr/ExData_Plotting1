##assuming that the file household_power_consumption.txt is in ./data/ directory
#Loading the data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
epc<-read.table(unz(temp,"household_power_consumption.txt"),sep=";",header=TRUE)
unlink(temp)

#Convert Date attribute to Date Data Type
epc$Date<-as.Date(as.character(epc$Date),"%d/%m/%Y")
epc$Global_active_power<-as.numeric(as.character(epc$Global_active_power))
epc$Sub_metering_1<-as.numeric(as.character(epc$Sub_metering_1))
epc$Sub_metering_2<-as.numeric(as.character(epc$Sub_metering_2))
epc$Sub_metering_3<-as.numeric(as.character(epc$Sub_metering_3))

#For performance purposes we filter data by dates: 2007-02-01 and 2007-02-02
epc<-epc[epc$Date==as.Date("2007-02-01")|epc$Date==as.Date("2007-02-02"),]

#Plotting histogram
plot(epc$datetime,epc$Sub_metering_1,type="l",xlab="",ylab="Global Active Power (Kilowatts)")
lines(epc$datetime,epc$Sub_metering_2,col="red")
lines(epc$datetime,epc$Sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1))

#Alternative using ggplot2
#ggplot(epc.long, aes(datetime, value, colour = variable)) + geom_line() +xlab("")+ylab("Energy sub metering")+scale_color_manual(values=c("black", "red","blue"))+theme(legend.title=element_blank())

#Saving Plot 1 as PNG
dev.copy(png,file="plot3.png",width=480,height=480)
dev.off() ##Don't forget to close the PNG device