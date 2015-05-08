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
epc <- read.table(file = epc_path, sep = ";", stringsAsFactors = F)
