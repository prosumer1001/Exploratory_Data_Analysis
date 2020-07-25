## Coursera, Course.  Exploratory Data Analysis
## Coursera (https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2)

## Question 1, plot1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.

## Answer to the question:  Yes, the total emissions from PM2.5 has decreased in the U.S. from 1999 to 2008.
## Import Data
## PM2.5
install.packages("rio")
library(rio)
data01 <- import("summarySCC_PM25.rds")

## Emissions source classification
data02 <- import("Source_Classification_Code.rds")

## Aggregate emissions by year
emissionsAggregate <- aggregate(Emissions ~ year, data = data01, FUN = sum)

## Open png machine to create plot1.png
png(filename = "plot1.png", width = 540, height = 540, units = "px")

## Create plot
barplot(
        (emissionsAggregate$Emissions)/10^6,
        names.arg=emissionsAggregate$year,
        xlab="Year",
        ylab="PM2.5 Emissions (Millions of Tons)",
        main="Total PM2.5 Emissions From All US Sources"
)

## Close png machine
dev.off()

