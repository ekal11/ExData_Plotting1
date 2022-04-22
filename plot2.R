

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


        


# plot2
png("plot2.png", width=480, height=480)
plot(x = datetime ,y = data$Global_active_power,  type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

