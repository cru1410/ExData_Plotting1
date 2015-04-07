# As part of goal to examine how household energy usage varies
# over a 2-day period in February, 2007 using the "Individual
# household electric power consumption Data Set" from the 
# UC Irvine Machine Learning Repository.
#
# This script constructs the plot1.png plot.
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

## plot1.png
png(filename="plot1.png", width=480, height=480)
hist(df.sub$Global_active_power, col = "red", 
      main="Global Active Power", 
      xlab="Global Active Power (kilowatts)")
dev.off() ## Don't forget to close the PNG device!

