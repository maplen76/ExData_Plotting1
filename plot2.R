################################################################################################
# Download the data set
################################################################################################
u <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = u, destfile = "household_power_consumption.zip")
zip_Path <- paste(getwd(),"/", "household_power_consumption.zip", sep = "")

# the exdir should be set as working directory
unzip(zipfile = zip_Path, exdir = getwd())
epc_path <- paste(getwd(),"/", "household_power_consumption.txt", sep = "")

################################################################################################
# loading data into R
################################################################################################
epc <- read.table(file = epc_path, header = T, sep = ";", stringsAsFactors = F)
epc$dt <- as.Date(epc$Date, format = "%d/%m/%Y")

# subset the data between 2007-02-01 and 2007-02-02
epc_plot <- subset(epc, dt >= '2007-02-01' & dt <= '2007-02-02')
epc_plot$date_time <- strptime(paste(epc_plot$Date, epc_plot$Time), "%d/%m/%Y %H:%M:%S")

epc_plot$Global_active_power <- as.numeric(epc_plot$Global_active_power)
epc_plot$Global_reactive_power <- as.numeric(epc_plot$Global_reactive_power)

################################################################################################
# Making Plot
################################################################################################

# Plot2
png(file = "plot2.png", width = 480, height = 480, units = "px")
with(epc_plot, plot(date_time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)"))
dev.off()
