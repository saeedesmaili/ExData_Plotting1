if (!file.exists("exdata-data-household_power_consumption.zip")) {
  f <- "exdata-data-household_power_consumption.zip"
  url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, f)
  dataFile <- unzip(f)
}

library(dplyr)
library(lubridate)

data <- read.table("household_power_consumption.txt", sep = ";", skip = 66637, nrows = 2880)
data <- data %>% select(V3) %>% mutate(V3 = as.numeric(as.character(V3)))

hist(data$V3, col = "red", main = "Global Active Power", xlab = "Global Active Power (killowatts)", ylab = "Frequency")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
