# Libraries
library(ggplot2)
library(dplyr)
# Establish work directory
setwd("C:/Localdata/CURSOS/BIG DATA/COURSERA/exploratoryDataAnalysis/")
# Read data
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
# Prepare data
data <- NEI %>% group_by(year) %>% summarize(totalPM2.5 = sum(Emissions, na.rm = TRUE))
# Create the plot
png(file = "plot1.png")
with(data, plot(year, totalPM2.5))
lines(data$year, data$totalPM2.5)
title(main = "Total Emission over years 1999-2008")
dev.off()
