# Libraries
library(ggplot2)
library(dplyr)
# Establish work directory
setwd("C:/Localdata/CURSOS/BIG DATA/COURSERA/exploratoryDataAnalysis/")
# Read data
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
#Prepare data
total_emi <- NEI %>%
  filter(fips == 24510) %>%
  select(fips, Emissions, year) %>%
  group_by(year) %>%
  summarise(Total_Emissions = sum(Emissions, na.rm = TRUE))
# Create plot
png("plot2.png")
plot(x = total_emi$year, y = total_emi$Total_Emissions, type = "l", xlab = "Year", ylab = "Emissions (Ton)", main = "Emissions in Baltimore City, Maryland" )
dev.off()
