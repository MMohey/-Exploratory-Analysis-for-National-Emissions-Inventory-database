## plot6.R plots a graph of "Total Emissions from Motor vehicles sources in USA
## vs Years" using Base plotting System

library(dplyr)
library(ggplot2)

# Importing relevant datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png("plot6.png",
    # creating a png file
    width = 480,
    height = 480,
    units = "px")

baltimore_data <-
    subset(NEI, fips == '24510') #Filtering Baltimore data from NEI

# Locating 'Motor' sources of in SSC, then selecting those only in Baltimore
motor_vehicles <- grep('motor', SCC$Short.Name, ignore.case = T)
motor_vehicles <- SCC[motor_vehicles, ]
motor_vehicles <-
    baltimore_data[baltimore_data$SCC %in% motor_vehicles$SCC, ]

motor_vehicles_emissions <- # sum of motor emissions by years in US
    aggregate(motor_vehicles$Emissions, list(motor_vehicles$year), FUN = 'sum')

LA_data <-
    subset(NEI, fips == '06037') #Filtering Los Angeles data from NEI

# Locating 'Motor' sources of in SSC, then selecting those only in Los Angeles
LA_motor_vehicles <- grep('motor', SCC$Short.Name, ignore.case = T)
LA_motor_vehicles <- SCC[LA_motor_vehicles, ]
LA_motor_vehicles <-
    LA_data[LA_data$SCC %in% LA_motor_vehicles$SCC, ]

LA_motor_vehicles_emissions <-
    # sum of motor emissions by years in US
    aggregate(LA_motor_vehicles$Emissions,
              list(LA_motor_vehicles$year),
              FUN = 'sum')


ggplot(# plotting motor emissions in Baltimore & LA
    motor_vehicles_emissions,
    aes(Group.1,
        y = value,
        color = variable)) +
    geom_line(aes(y = motor_vehicles_emissions$x, col = "Baltimore")) +
    geom_line(aes(y = LA_motor_vehicles_emissions$x, col = "Los Angeles")) +
    ggtitle("Total Motor Emissions from Baltimore and Los Angeles vs Years") +
    xlab("Year") +
    ylab("Total Emissions from Motor vehicles sources")


dev.off()
