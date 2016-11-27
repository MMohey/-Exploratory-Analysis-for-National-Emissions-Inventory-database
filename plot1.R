## plot1.R plots a graph of "Total PM2.5 Emissions in USA vs Years" using Base
## plotting System

# Importing relevant datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

emissions_per_year <- # sum of emissions by years
    aggregate(NEI$Emissions, list(NEI$year), FUN = 'sum')

png("plot1.png",
    # creating a png file
    width = 480,
    height = 480,
    units = "px")

plot(
    emissions_per_year,
    type = 'l',
    xlab = 'Year',
    ylab = 'Total PM2.5 Emissions in USA',
    main = 'Total PM2.5 Emissions in USA vs Years'
)

dev.off()