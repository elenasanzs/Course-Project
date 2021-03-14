# Libraries
library(ggplot2)
library(dplyr)

setwd("C:/Localdata/CURSOS/BIG DATA/COURSERA/exploratoryDataAnalysis/")
# Read data
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS(file="Source_Classification_Code.rds"))



# Prepare data
vehSCC <- SCC[grepl("vehicle", SCC.Level.Two, ignore.case=TRUE), SCC]
vehNEI <- NEI[NEI[, SCC] %in% vehSCC,]
baltimoreVehNEI <- vehNEI[fips=="24510",]

# Create plot
png("plot5.png")

ggplot(baltimoreVehNEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity") +
  labs(x="Year", y="Emission (Tons)") + 
  labs(title="Emissions from motor vehicle in Baltimore over the years")

dev.off()
