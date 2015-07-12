#last update
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

#create histogram 
par(cex=0.75)
hist(as.numeric(as.character(data$Global_active_power)),col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

#copy plot to png file
dev.copy(png,width=480, height=480, file="plot1.png")     

#close PNG device
dev.off()
