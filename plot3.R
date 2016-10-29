if (!file.exists("exdata-data-household_power_consumption.zip")) {
  f <- "exdata-data-household_power_consumption.zip"
  url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, f)
  dataFile <- unzip(f)
}

library(dplyr)
library(lubridate)

data <- read.table("household_power_consumption.txt", sep = ";", skip = 66637, nrows = 2880)
data <- data %>% mutate(V1 = as.POSIXct(dmy_hms(as.character(paste(V1, V2)))),
                        V7 = as.numeric(as.character(V7)),
                        V8 = as.numeric(as.character(V8)),
                        V9 = as.numeric(as.character(V9))) %>% select(V1, V7:V9)

with(data, plot(V1, V7, type = "n", xlab = "", ylab = "Energy Sub Metering"))
with(data, points(V1, V7, col = "black", type = "l"))
with(data, points(V1, V8, col = "red", type = "l"))
with(data, points(V1, V9, col = "blue", type = "l"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"))

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
