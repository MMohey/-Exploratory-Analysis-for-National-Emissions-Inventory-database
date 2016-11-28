## plot4.R plots a graph of "Emissions from coal combustion-related sources 
## in USA vs Years" using Base plotting System

library(dplyr)
library(ggplot2)

# Importing relevant datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png("plot4.png",
    # creating a png file
    width = 480,
    height = 480,
    units = "px")

# Locating 'Coal' sources in SSC dataset, then mapping their indices in NEI
coal_sources <- grep('coal', SCC$Short.Name, ignore.case = T)
coal_sources <- SCC[coal_sources, ]
coal_sources <- NEI[NEI$SCC %in% coal_sources$SCC, ]

coal_emissions <- # sum of coal emissions by years in US
    aggregate(coal_sources$Emissions, list(coal_sources$year),
              FUN = 'sum')

plot(
    coal_emissions,
    type = 'l',
    xlab = 'Year',
    ylab = 'Total Coal PM2.5 Emissions',
    main = 'Emissions from coal combustion-related sources in USA vs Years'
)

dev.off()
