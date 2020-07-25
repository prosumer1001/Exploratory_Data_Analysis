## Coursera, Course.  Exploratory Data Analysis
## Coursera (https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2)

## Question 2, plot2
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make 
## a plot answering this question.

## Answer to Question 2:  The trend is downward with 1999 being over 3,000 tons
## and 2008 being approximately 2,000 tons.

## Import Data
## PM2.5
install.packages("rio")
library(rio)
data01 <- import("summarySCC_PM25.rds")

## Emissions source classification
data02 <- import("Source_Classification_Code.rds")

## Subset for Baltimore
baltimoreSub <- data01[data01$fips == "24510",]

## Aggregate the Baltimore subset by summing data by year
baltimoreAggregate <- aggregate(Emissions ~ year, baltimoreSub, sum)

## Open png machine to create plot1.png
png(filename = "plot2.png", width = 540, height = 540, units = "px")

## Create plot

barplot(
        baltimoreAggregate$Emissions,
        names.arg=baltimoreAggregate$year,
        xlab="Year",
        ylab="PM2.5 Emissions (Tons)",
        main="Total PM2.5 Emissions From all Baltimore City Sources"
)

## Close png machine
dev.off()



