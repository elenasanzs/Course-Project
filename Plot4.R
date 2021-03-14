# Libraries
library(ggplot2)
library(dplyr)

setwd("C:/Localdata/CURSOS/BIG DATA/COURSERA/exploratoryDataAnalysis/")
# Read data
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS(file="Source_Classification_Code.rds"))

# Prepare data
comb <- grepl("comb", SCC[, SCC.Level.One], ignore.case=TRUE)
coal <- grepl("coal", SCC[, SCC.Level.Four], ignore.case=TRUE) 
combSCC <- SCC[comb & coal, SCC]
combNEI <- NEI[NEI[,SCC] %in% combSCC]
#Create plot
png("plot4.png")

ggplot(combNEI,aes(x = factor(year),y = Emissions)) +
  geom_bar(stat="identity") +
  labs(x="Year", y="Emission (Tons)") + 
  labs(title="Emissions from coal combustion-related over the years")

dev.off()
