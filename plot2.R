# As part of goal to examine how household energy usage varies
# over a 2-day period in February, 2007 using the "Individual
# household electric power consumption Data Set" from the 
# UC Irvine Machine Learning Repository.
#
# This script constructs the plot2.png plot.
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

## plot2.png
png(filename="plot2.png", width=480, height=480)
with(df.sub, 
  plot(Time, Global_active_power, type="l", 
          xlab="", ylab="Global Active Power (kilowatts)"))
dev.off() ## Don't forget to close the PNG device!
