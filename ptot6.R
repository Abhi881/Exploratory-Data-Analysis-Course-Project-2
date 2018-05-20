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

## Question 6:- Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips=="06037"). Which city has seen greater changes over time in motor vehicle emissions?

## Filtering dataset with vehicle  sources
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_SCC <- SCC[vehicles,]
vehicles_NEI <- NEI[NEI$SCC %in% vehicles_SCC$SCC,]

## Filtering dataset containing "Baltimore" city
vehicles_Baltimore_NEI <- vehicles_NEI[vehicles_NEI$fips == 24510,]

## Filtering dataset containing "Los Angeles" city
vehicles_LA_NEI <- vehicles_NEI[vehicles_NEI$fips=="06037",]

## Adding both dataset using rbind function 
Baltimore_LA_NEI <- rbind(vehicles_Baltimore_NEI,vehicles_LA_NEI)

## Renaming fips as city name 
Baltimore_LA_NEI$fips<- as.factor(Baltimore_LA_NEI$fips)
Baltimore_LA_NEI$fips <- ifelse(Baltimore_LA_NEI$fips == "24510","Baltimore", "Los Angeles")

## Creating bar chart for comparing Baltimore & Los Angeles 

ggplot(Baltimore_LA_NEI, aes(x=factor(year), y=Emissions, fill=fips)) +
    geom_bar(aes(fill=year),stat="identity") +
    facet_grid(scales="free", space="free", .~fips) +
    guides(fill=FALSE) + theme_bw() +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
    labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))


# Conclusion : Los Angeles County has seen the greatest changes over time in motor vehicle emissions in compasion to Baltimore city.