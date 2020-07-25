## Coursera, Course.  Exploratory Data Analysis
## Coursera (https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2)

# Question 3, plot3
## Of the four types of sources indicated by the type(point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make 
## a plot answer this question.

## Answers to Question 3:  
## a. Which have seen decreases in emissions in Baltimore city from 1999-2008? 
##      Non-Road; Non-Point; and On-Road have seen consistent decreases
## b. Which have seen increases in emissions from 1999-2008?
##      Point saw consistent increases from 1999-2005 followed by a drop,
##      which was still larger than the original 1999 baseline.

## Import Data
## PM2.5
#install.packages("rio")
#install.packages("ggplot2")
library(rio)
library(ggplot2)
data01 <- import("summarySCC_PM25.rds")

## Emissions source classification
data02 <- import("Source_Classification_Code.rds")

## Subset for Baltimore
baltimoreSub <- data01[data01$fips == "24510",]

## Aggregate the Baltimore subset by summing data by year
baltimoreAggregate <- aggregate(Emissions ~ year, baltimoreSub, sum)

## Open png machine to create plot1.png
png(filename = "plot3.png", width = 540, height = 540, units = "px")

## Create plot

plot3 <- ggplot(baltimoreSub,aes(factor(year),Emissions,fill=type)) +
        geom_bar(stat="identity") +
        theme_bw() + guides(fill=FALSE)+
        facet_grid(.~type,scales = "free",space="free") + 
        labs(x="Facets by Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
        labs(title=expression("Baltimore City Emissions (1999-2008)," * " PM"[2.5]))

print(plot3)

## Close png machine
dev.off()


