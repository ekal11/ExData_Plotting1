

# load libraries
library(data.table)
library(ggplot2)
library(dplyr)

# load data
data <- read.delim2("~/Training/Coursera/ExploratoryDataAnalysis/Project1/household_power_consumption.txt", sep = ';') %>%
        as.data.table()

# missing values were coded as "?" or missing, change to NA
data[data == "?" | data == ""] <- NA


# subset the data only be using data from the dates 2007-02-01 and 2007-02-02
data <- data[Date == "1/2/2007" | Date == "2/2/2007"]
datetime <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

# format date column to dd/mm/tt
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# format rest to be numeric
data <- data %>% mutate_if(is.character, as.numeric)


        


# plot4
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, data$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, data$Sub_metering_2, type="l", col="red")
lines(datetime, data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
