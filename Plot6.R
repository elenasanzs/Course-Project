# Libraries
library(ggplot2)
library(dplyr)

setwd("C:/Localdata/CURSOS/BIG DATA/COURSERA/exploratoryDataAnalysis/")
# Read data
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS(file="Source_Classification_Code.rds"))

# Prepare data
condit <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case=TRUE)
vehSCC <- SCC[condit, SCC]
vehNEI <- NEI[NEI[, SCC] %in% vehSCC,]
vehBaltimoreNEI <- vehNEI[fips == "24510",]
vehBaltimoreNEI[, city := c("Baltimore City")]
vehLANEI <- vehNEI[fips == "06037",]
vehLANEI[, city := c("Los Angeles")]
bothNEI <- rbind(vehBaltimoreNEI,vehLANEI)

#Create plot
png("plot6.png")

ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  labs(x="Year", y="Emission") + 
  labs(title="Emissions in Baltimore & LA over the years")

dev.off()
