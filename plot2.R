if (!file.exists("exdata-data-household_power_consumption.zip")) {
  f <- "exdata-data-household_power_consumption.zip"
  url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, f)
  dataFile <- unzip(f)
}

library(dplyr)
library(lubridate)

data <- read.table("household_power_consumption.txt", sep = ";", skip = 66637, nrows = 2880)
data <- data %>% mutate(V1 = as.POSIXct(dmy_hms(as.character(paste(V1, V2)))), V3 = as.numeric(as.character(V3))) %>% select(V1, V3)

with(data, plot(V1, V3, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
