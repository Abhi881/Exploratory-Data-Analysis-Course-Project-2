## load the NEI and SCC data frames from the .rds files.

NEI <- readRDS("summarySCC_PM25.rds")

SCC <- readRDS("Source_Classification_Code.rds")

# Visualize top 6 rows of dataset
head(NEI)
head(SCC)

# structure of given dataset
str(NEI)
str(SCC)

## Summary of given dataset
summary(NEI)
summary(SCC)

## Question- 3 Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

## Using package "ggplot2"
library(ggplot2)

ggplot(baltimoreNEI_data,aes(year,Emissions,fill=type)) +
    geom_bar(stat="identity") +
    theme_bw() + guides(fill=FALSE)+
    facet_grid(.~type,scales = "free",space="free") + 
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
    labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

## conclusion :
#1. The non-road, nonpoint, on-road source types have all seen decreased emissions overall from 1999-2008 in Baltimore City.
#2. The point source saw a slight increase overall from 1999-2008. Also note that the point source saw a significant increase until 2005 at which point it decreases again by 2008 to just above the starting values.

