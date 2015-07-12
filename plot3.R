## download household power consumption data file, unzip it 
## and load data to all_data variable

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip", method="curl")
unzip("household_power_consumption.zip", "household_power_consumption.txt")
allData<-read.table("household_power_consumption.txt",header=TRUE, sep=";")

## convert Date column to date format for all data read from data source
allData$Date<-as.Date(allData$Date, "%d/%m/%Y")

#subset to dates between 2007-02-01 and 2007-02-02
data <-subset(allData,allData$Date=="2007-02-01" | allData$Date=="2007-02-02" )

#add new DateTime column
data$DateTime<-strptime(paste(data$Date,data$Time), "%Y-%m-%d %H:%M:%S")   

#create plot 3

png("plot3.png", width=480, height=480)

yrange<-range(c(data$Sub_metering_1,data$Sub_metering_2,data$Sub_metering_3))
yrange<-c(0,40)
#par(cex=0.75)
plot(data$DateTime, as.numeric(as.character(data$Sub_metering_1)),type="l",
     xlab="",ylab="Energy sub metering", col="Black", ylim=yrange, yaxt="n")
axis(2, at=c(0,10,20,30),labels=c("0","10","20","30"), col.axis="black", las=0)
par(new=T)
plot(data$DateTime, as.numeric(as.character(data$Sub_metering_2)),type="l",
     xlab="",ylab="", col="red", ylim=yrange,yaxt="n")
par(new=T)
plot(data$DateTime, as.numeric(as.character(data$Sub_metering_3)),type="l",
     xlab="",ylab="", col="blue", ylim=yrange,yaxt="n")
legend("topright", inset=0,
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
          horiz=FALSE, 
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
        lwd=c(2.5,2.5,2.5),col=c("black","red","blue")
       
       )      
par(new=F)
   

#close PNG device
dev.off()
