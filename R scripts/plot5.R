## plot6.R plots a graph of "Total Emissions from Motor vehicles sources in USA
## vs Years" using Base plotting System

library(dplyr)
library(ggplot2)

# Importing relevant datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png("plot5.png",
    # creating a png file
    width = 480,
    height = 480,
    units = "px")

baltimore_data <-
    subset(NEI, fips == '24510') #Filtering Baltimore data from NEI

# Locating 'Motor' sources in SSC dataset, then mapping their indices in NEI
motor_vehicles <- grep('motor', SCC$Short.Name, ignore.case = T)
motor_vehicles <- SCC[motor_vehicles, ]
motor_vehicles <-
    baltimore_data[baltimore_data$SCC %in% motor_vehicles$SCC, ]

motor_vehicles_emissions <- # sum of motor emissions by years in US
    aggregate(motor_vehicles$Emissions, list(motor_vehicles$year), FUN = 'sum')

plot(
    motor_vehicles_emissions,
    type = 'l',
    xlab = 'Year',
    ylab = 'Total Motor Vehicles PM2.5 Emissions',
    main = 'Total Emissions from Motor vehicles sources in USA vs Years'
)

dev.off()
