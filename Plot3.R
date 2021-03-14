# Libraries
library(ggplot2)
library(dplyr)

setwd("C:/Localdata/CURSOS/BIG DATA/COURSERA/exploratoryDataAnalysis/")
# Reading data
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

total_emi_byType <- NEI %>%
  filter(fips == 24510) %>%
  select(fips, type, Emissions, year) %>%
  group_by(year, type) %>%
  summarise(Total_Emissions = sum(Emissions, na.rm = TRUE))
png("plot3.png")
 ggplot(total_emi_byType, aes(x = factor(year), y = Total_Emissions, fill = type)) +
  geom_bar(stat = "identity") +
  facet_grid(.~type) + 
  labs(x = "Year", y = "Emissions (Tons)", title = "Emissions By Type In Baltimore City, Maryland") 
dev.off()
