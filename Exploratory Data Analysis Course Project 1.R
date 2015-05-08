################################################################################################
# Download the data set
################################################################################################
u <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = u, destfile = "household_power_consumption.zip")
zip_Path <- paste(getwd(),"/", "household_power_consumption.zip", sep = "")

# the exdir should be set as working directory
unzip(zipfile = zip_Path, exdir = getwd())
epc_path <- paste(getwd(),"/", "household_power_consumption.txt", sep = "")

# read the data into R
epc <- read.table(file = epc_path, header = T, sep = ";", stringsAsFactors = F)
epc$dt <- as.Date(epc$Date, format = "%d/%m/%Y")
head(epc)

# subset the data between 2007-02-01 and 2007-02-02
epc_plot <- subset(epc, dt >= '2007-02-01' & dt <= '2007-02-02')
epc_plot$date_time <- strptime(paste(epc_plot$Date, epc_plot$Time), "%d/%m/%Y %H:%M:%S")

epc_plot$Global_active_power <- as.numeric(epc_plot$Global_active_power)

# Plot1
png(file = "Plot1.png", width = 480, height = 480, units = "px")
hist(as.numeric(epc_plot$Global_active_power), 
     col = "red"
     ,main = "Global Active Power"
     ,xlab = "Global Active Power (kilowatts)")
dev.off()


# Plot2
with(epc_plot, plot(date_time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)"))

# Plot3
with(epc_plot, plot(date_time, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(epc_plot, lines(date_time, Sub_metering_2, type = "l", col = "red"))  
with(epc_plot, lines(date_time, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty=c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


#Plot4
par(mfrow = c(2, 2))
with(epc_plot,{ 
    plot(date_time, Global_active_power, type = "l",  ylab = "Global Active Power", xlab = "")
    plot(date_time, as.numeric(Voltage), type = "l",  ylab = "Voltage", xlab = "datetime")
    plot(date_time, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
    lines(date_time, Sub_metering_2, type = "l", col = "red")
    lines(date_time, Sub_metering_3, type = "l", col = "blue")
    legend("topright", bty = 'n', lty=c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(date_time, as.numeric(Global_reactive_power), type = "l", ylab = "Global_reactive_power" )
                })

