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

#Converting values
epc$Global_active_power<-as.numeric(as.character(epc$Global_active_power))
epc$Sub_metering_1<-as.numeric(as.character(epc$Sub_metering_1))
epc$Sub_metering_2<-as.numeric(as.character(epc$Sub_metering_2))
epc$Sub_metering_3<-as.numeric(as.character(epc$Sub_metering_3))
#adding  columns
epc$datetime<-as.POSIXct(paste(epc$Date, epc$Time), format="%Y-%m-%d %H:%M:%S")
epcdf<-epc[order(epc[,10]),]

#Plot 4
par(mfrow=c(2,2),oma=c(0,0,2,0)) 
        #Top Left#
        plot(epcdf$datetime,epcdf$Global_active_power,type="l",xlab="",ylab="Global Active Power (Kilowatts)")
        #Top Right#
        plot(epcdf$datetime,as.numeric(as.character(epcdf$Voltage)),type="l",xlab="",ylab = "Voltage")
        #Bottom Left#
        plot(epc$datetime,epc$Sub_metering_1,type="l",xlab="",ylab="Global Active Power (Kilowatts)")
        lines(epc$datetime,epc$Sub_metering_2,col="red")
        lines(epc$datetime,epc$Sub_metering_3,col="blue")
        legend("topright",col=c("black","red","blue"),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1))
        #Bottom Right#
        plot(epcdf$datetime,as.numeric(as.character(epcdf$Global_reactive_power)),type="l",xlab="",ylab="Global_reactive_power")

        #Saving Plot  as PNG
        dev.copy(png,file="plot4.png",width=480,height=480)
        dev.off() ##Don't forget to close the PNG device
      