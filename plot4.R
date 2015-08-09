## plot4.R
## Download data from the web
##library(foreign)

#setwd('~/Downloads')
#unzdir <- getwd() 

## download the file
fileUrl1 = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl1,destfile="household_power_consumption.zip",method="curl")

### Unzip the file 
unzip("household_power_consumption.zip", files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = unzdir, unzip = "internal",
      setTimes = FALSE)

## read the data into a data frame
dd1 <- as.Date("2007-02-01")
dd2 <- as.Date("2007-02-03")

tempdata <- read.table("household_power_consumption.txt", header=T, sep=";")
cleandata <- na.omit(tempdata)
cleandata$new_date <- as.Date(as.character(cleandata$Date), format("%d/%m/%Y"))
mydata <-subset(cleandata, new_date >= dd1 & new_date < dd2 )
rm(tempdata, cleandata)
par (mfrow = c(2,2))
##plot (x, y, type = "n")

# Plot 1 Global Active Power
gap <- as.numeric (mydata$Global_active_power) /1000
dt <- as.POSIXct(paste(mydata$new_date, mydata$Time), format="%Y-%m-%d %H:%M:%S")
plot (dt,gap, type = "l", ylab = "Global Active Power (Kilowatts)", xlab= "" )

# Plot 2 Voltage
volt <- as.numeric (mydata$Voltage) 
dt <- as.POSIXct(paste(mydata$new_date, mydata$Time), format="%Y-%m-%d %H:%M:%S")
plot (dt,volt, type = "l", ylab = "Voltage", xlab= "" )

## Plot 3  Sub Metering
y <- as.numeric (mydata$Sub_metering_1) 
y2 <- as.numeric (mydata$Sub_metering_2) 
y3 <- as.numeric (mydata$Sub_metering_3) 
x <- as.POSIXct(paste(mydata$new_date, mydata$Time), format="%Y-%m-%d %H:%M:%S")
plot (x, y, type = "n", ylab = "Energy Sub Metering", xlab = "",  ylim= c(0,35))
points( x, y, type = "l")
points( x, y2, type = "l", col = "blue")
points( x, y3, type = "l", col = "red")
legend("topright", lty = 1, col= c("black", "blue", "red"),legend = c("Sub_metering_1" , "Sub_metering_2", "Sub_metering_2"), cex = 0.3 ,bty = "n")

# Plot 4 Global Reactive Power
grp <- as.numeric (mydata$Global_reactive_power) 
dt <- as.POSIXct(paste(mydata$new_date, mydata$Time), format="%Y-%m-%d %H:%M:%S")
plot (dt,grp, type = "l", ylab = "Global Reactive Power", xlab= "" )

dev.copy(png, file = "plot4.png")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!


