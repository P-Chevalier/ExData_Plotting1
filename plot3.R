# plot3.R

# Usage: source plot3.R

# This script expects the data file household_power_consumption.txt to be in the 
# current working directory.
# This script requires the data.table library.

# The data file should downloaded and then unzip'ed from the following location:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# Load table package needed by plot3.R
library("data.table")

# Check to see if household_power_consumption.txt exists in the current working directory
if ((!file.exists("./household_power_consumption.txt"))) {
        stop("household_power_consumption.txt file is missing - please download file to continue")
}

# Read in only the 1/2/2007 data
df<-fread("grep ^1\\/2\\/2007 household_power_consumption.txt")

# Read in only the 2/2/2007 data
df2<-fread("grep ^2\\/2\\/2007 household_power_consumption.txt")

# Combine both day's data together
alldf<-rbind(df,df2)

# Combine date and time and format to date_time
date_time<-strptime(paste(alldf$V1, alldf$V2, sep=" "),"%d/%m/%Y %H:%M:%S")

# Create the png file
png("plot3.png", width=480, height=480, units="px")

# Create the plot
plot(date_time, alldf$V7, type="l", xlab=NA, ylab="Energy sub metering")
points(date_time, alldf$V8, type="l", col="red")
points(date_time, alldf$V9, type="l", col="blue")
legend("topright", lty=c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()