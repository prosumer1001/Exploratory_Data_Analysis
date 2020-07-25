## Coursera, Course.  Exploratory Data Analysis
## Coursera (https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2)

## Question 6, plot6
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
## vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

## Answer to Question 6.
## The Los Angeles data indicates there was a steady increase from 1999 to 2005
## followed by a reduction close to the 1999 levels.  This indicates there was
## not a significant overall reduction or increase from 1999 to 2008 when 
## comparing the first and last years in quesiton.
## Comparatively, Baltimore city saw a steady decrease from 1999 to 2008 from 
## approximately 400 tons in 1999 to less than 150 tons in 2008.

## Import Data
## PM2.5
#install.packages("rio")
#install.packages("ggplot2")
#install.packages("ggpubr")
library(rio)
library(ggplot2)
library(ggpubr)
data01 <- import("summarySCC_PM25.rds")

## Emissions source classification
data02 <- import("Source_Classification_Code.rds")

# Subset data01 for vehicles
vehicles <- grepl("vehicle", data02$SCC.Level.Two, ignore.case=TRUE)
data02Vehicles <- data02[vehicles,]$SCC
data01Vehicles <- data01[data01$SCC %in% data02Vehicles,]

## Subset for Baltimore and Los Angeles
data01VehiclesBaltimore <- data01Vehicles[data01Vehicles$fips=="24510",]
data01VehiclesBaltimore$city <- "Baltimore City"

data01VehiclesLosAng <- data01Vehicles[data01Vehicles$fips=="06037",]
data01VehiclesLosAng$city <- "Los Angeles County"

# Combine the two subsets with city name into one data frame
data01Combined <- rbind(data01VehiclesBaltimore,data01VehiclesLosAng)

## Open png machine to create plot1.png
png(filename = "plot6.png", width = 540, height = 540, units = "px")

## Create plot

plot6 <- ggplot(data01Combined, aes(factor(year), 
                                   Emissions, 
                                   fill = city)) +
        geom_bar(aes(fill = year), 
                 stat = "identity", 
                 fill = "grey", 
                 width = 0.65) +
        facet_grid(scales = "free", 
                   space = "free", 
                   .~city) +
        theme_bw() +  
        guides(fill = FALSE) +
        labs(x = "year", 
             y = expression("Total PM"[2.5]*" Emissions (Tons)")) + 
        labs(title = expression("Motor Vehicle Emissions in Baltimore and Los Angeles (1999-2008)," * " PM"[2.5]))

plot6 <- plot6 + facet_wrap(~city, scales = "free_y")
print(plot6)

## Close png machine
dev.off()

