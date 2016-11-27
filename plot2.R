## plot2.R plots a graph of "Total PM2.5 Emissions in Baltimore vs Years" using
## Base plotting System

library(dplyr)

# Importing relevant datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png("plot2.png",
    # creating a png file
    width = 480,
    height = 480,
    units = "px")

baltimore_data <-
    subset(NEI, fips == '24510') #Filtering Baltimore data from NEI

baltimore_emissions <- # sum of emissions by years in Baltimore
    aggregate(baltimore_data$Emissions, list(baltimore_data$year), FUN = 'sum')

plot(
    baltimore_emissions,
    type = 'l',
    xlab = 'Year',
    ylab = 'Total PM2.5 Emissions in Baltimore',
    main = 'Total PM2.5 Emissions in Baltimore vs Years'
)

dev.off()