
##Read in needed libraries
##Read in data, note that ? = NA, add names of columns 
memory_needed <- 2075259*9*8 /(1*10^9)
library(dplyr)
library(lubridate)

names_data <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

dataset <- read.table("/Users/mikekelly/Documents/R_files/Coursera_R_Projects/Exploratory_Data_Analysis/household_power_consumption.txt", sep = ";", skip = 1, col.names = names_data, na.strings = "?")

##Convert character variable Date to a POSIXlt format, add it to 'dataset'
date_time <- paste(dataset$Date, dataset$Time, sep = " ")
date_time_formated <- strptime(date_time, tz = "", format = "%d/%m/%Y %H:%M:%S")
date <- strptime(dataset$Date, tz = "", format = "%d/%m/%Y")
time <- format(hms(dataset$Time), "%A %H:%M:%S") 

dataset_edited <- mutate(dataset,
                         date = date_time_formated,
                         Date = date,
                         Time = NULL,
                         .keep = "unused")

##Pull out only two days in February 2007 requested
dataset_date <- dataset_edited[(dataset_edited$Date > "2007-02-01 00:00:00" & dataset_edited$Date < "2007-02-03 00:00:00"), ]

###Plot 4
par(mfrow = c(2, 2))

####Top Left
plot(x = dataset_date$date, y = dataset_date$Global_active_power, 
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = NA,
     cex.lab = 0.7,
     cex.axis = 0.7,
     cex.main = 0.9)

####Top Right
plot(x = dataset_date$date, y = dataset_date$Voltage, 
     type = "l",
     ylab = "Voltage",
     xlab = "datetime",
     cex.lab = 0.7,
     cex.axis = 0.7,
     cex.main = 0.9)

####Bottom Left
plot(dataset_date$date, dataset_date$Sub_metering_1, type = "n",
     ylab = "Energy sub metering",
     xlab = NA,
     cex.lab = 0.7,
     cex.axis = 0.7,
     cex.main = 0.9)
points(dataset_date$date, dataset_date$Sub_metering_1,
       type = "s",
       ylab = "Energy sub metering",
       xlab = NA,
       col = "black")
points(dataset_date$date, dataset_date$Sub_metering_2,
       type = "s",
       col = "red")
points(dataset_date$date, dataset_date$Sub_metering_3,
       type = "s",
       col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", cex = 0.7, lty = c(1, 1, 1), col = c("black", "red", "blue"))


####Bottom Right
plot(x = dataset_date$date, y = dataset_date$Global_reactive_power, 
     type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime",
     cex.lab = 0.7,
     cex.axis = 0.7,
     cex.main = 0.9)

