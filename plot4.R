## Coursera, Course.  Exploratory Data Analysis
## Coursera (https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2)

## Question 4, plot4
## Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999–2008?

## Answers to Question 4: 
## Emissions have generally decreased from approsimately 475,000 tons to 
## approximately 260,000 tons, which is a decrease of approximately 45%.

## Import Data
## PM2.5
#install.packages("rio")
#install.packages("ggplot2")
library(rio)
library(ggplot2)
data01 <- import("summarySCC_PM25.rds")

## Emissions source classification
data02 <- import("Source_Classification_Code.rds")

# Subset coal combustion related PM23 (data01) data
combustion <- grepl("comb", data02$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("coal", data02$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustion & coal)
data02Combustion <- data02[coalCombustion,]$SCC
data01Combustion <- data01[data01$SCC %in% data02Combustion,]

## Open png machine to create plot1.png
png(filename = "plot4.png", width = 540, height = 540, units = "px")

plot4 <- ggplot(data01Combustion,aes(factor(year),Emissions/10^5)) +
        geom_bar(stat="identity",fill="grey",width=0.65) +
        theme_bw() +  guides(fill=FALSE) +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons - Hundred Thousands)")) + 
        labs(title=expression("U.S. Coal Combustion Source Emissions (1999-2008)," * " PM"[2.5]))

print(plot4)

## Close png machine
dev.off()




