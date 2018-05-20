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

## Question 5:- How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_SCC <- SCC[vehicles,]
vehicles_NEI <- NEI[NEI$SCC %in% vehicles_SCC$SCC,]

## we subset for motor vehicles in Baltimore,
baltimore_Vehicles_NEI <- vehiclesNEI[vehiclesNEI$fips==24510,]

ggplot(baltimore_Vehicles_NEI,aes(factor(year),Emissions)) +
    geom_bar(stat="identity",fill="grey",width=0.75) +
    theme_bw() +  guides(fill=FALSE) +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
    labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))




