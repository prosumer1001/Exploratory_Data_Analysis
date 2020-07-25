## Coursera, Course.  Exploratory Data Analysis
## Coursera (https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2)

## Question 5, plot5
## How have emissions from motor vehicle sources changed from 1999–2008 in 
## Baltimore City?

## Answer to Question 5.
## Generally, the emissions are tending downward reducing from just over 3,000
## tons per year in 1999 to just under 2,000 tons per year in 2008.  Although,
## from 2002 to 2005 there was a significant increase, but it remained under
## the high from 1999.

## Import Data
## PM2.5
#install.packages("rio")
#install.packages("ggplot2")
library(rio)
library(ggplot2)
data01 <- import("summarySCC_PM25.rds")

## Emissions source classification
data02 <- import("Source_Classification_Code.rds")

# Subset data01 for vehicles
vehicles <- grepl("vehicle", data02$SCC.Level.Two, ignore.case=TRUE)
data02Vehicles <- data02[vehicles,]$SCC
data01Vehicles <- data01[data01$SCC %in% data02Vehicles,]

## Subset for Baltimore
baltimoreSub <- data01Vehicles[data01Vehicles$fips == "24510",]

## Open png machine to create plot1.png
png(filename = "plot5.png", width = 540, height = 540, units = "px")

## Create plot

plot5 <- ggplot(baltimoreSub, aes(factor(year),
                                 Emissions)) +
        geom_bar(stat = "identity",
                 fill = "grey",
                 width = 0.65) +
        theme_bw() +  
        guides(fill = FALSE) +
        labs(x = "year", 
             y = expression("Total PM"[2.5]*" Emissions (Tons)")) + 
        labs(title = expression("Motor Vehicle Emissions in Baltimore City (1999-2008)," * " PM"[2.5]))

print(plot5)


## Close png machine
dev.off()

