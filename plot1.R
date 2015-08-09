## plot1.R
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
par (mfrow = c(1,1))
with(mydata, hist(as.numeric(mydata$Global_active_power), xlab= "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col= "red"))
hist(as.numeric(mydata$Global_active_power), xlab= "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col= "red",  ylim= c(0,1200))

#hist (ap, xlab= "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col= "red") # change plot char from default
dev.copy(png, file = "plot1.png")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!

