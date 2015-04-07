# As part of goal to examine how household energy usage varies
# over a 2-day period in February, 2007 using the "Individual
# household electric power consumption Data Set" from the 
# UC Irvine Machine Learning Repository.
#
# This script constructs the plot4.png plot.
#
## Read data header and first 10 rows
dfHead <- read.csv("household_power_consumption.txt",
    nrows=10, sep=";",
    na.strings="?", stringsAsFactor=FALSE)
classes <- sapply(dfHead, class)

## Read actual data
df <- read.csv("household_power_consumption.txt",
    skip=65536, nrows=7200, sep=";",
    colClasses = classes,
    na.strings="?", stringsAsFactor=FALSE)
colnames(df) <- colnames(dfHead)  ## copy across the header

df$Date <- as.Date(df$Date,"%d/%m/%Y")  ## as Date
df$Time <- strptime(paste(df$Date, df$Time),
              "%Y-%m-%d %H:%M:%S")  ## as POSIXlt

df.sub <- df[which( (df$Date >= "2007-02-01") 
                & (df$Date <= "2007-02-02")), ]
rm("df","dfHead")

## plot4.png
png(filename="plot4.png", width=480, height=480)
op <- par(mfrow=c(2, 2), mar=c(4,4,4,2), 
        oma=c(2,0,0,0), cex=0.8)

with(df.sub, plot(Time, Global_active_power, type="l", 
        xlab="", ylab="Global Active Power"))

with(df.sub, plot(Time, Voltage, type="l", 
        xlab="datetime", ylab="Voltage"))

with(df.sub, {
  plot(Time, Sub_metering_1, type="l", xlab="", 
        ylab="Energy sub metering")
  points(Time, Sub_metering_2, type="l", col="red")
  points(Time, Sub_metering_3, type="l", col="blue")
})
legend("topright", col=c("black","red","blue"), 
    legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
    lwd=2, bty="n", cex=0.9)

with(df.sub, 
  plot(Time, Global_reactive_power, type="l", xlab="datetime"), 
        lwd=0.5)

dev.off() ## Don't forget to close the PNG device!
