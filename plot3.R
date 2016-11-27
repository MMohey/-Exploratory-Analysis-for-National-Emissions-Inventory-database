## plot3.R plots a graph of "Total PM2.5 Emissions in USA vs Years" using 
## ggplot2 plotting System

library(dplyr)
library(ggplot2)

# Importing relevant datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png("plot3.png",
    # creating a png file
    width = 480,
    height = 480,
    units = "px")

baltimore_data <-
    subset(NEI, fips == '24510') #Filtering Baltimore data from NEI

baltimore_emissions <- # sum of emissions by years in Baltimore
    aggregate(baltimore_data$Emissions, list(baltimore_data$year), FUN = 'sum')

# grouping Baltimore data by year and type, then sum their emissions
Baltimore_data_grouped <- baltimore_data %>%
    group_by(year, type) %>%
    summarise(value = sum(Emissions))

qplot(
    year,
    value,
    data = Baltimore_data_grouped,
    color = type,
    xlab = 'Year',
    ylab = 'Total Emissions',
    main = 'Total Emissions by Type in Baltimore vs Years'
) +
    geom_line()

dev.off()