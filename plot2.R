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


## Question 2 :- Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

## Filtering dataset with "fips" = 24510 Maryland
baltimoreNEI_data <- NEI[NEI$fips=="24510",]

## Aggregating data by summing up the Emissions as per year
aggTotalsBaltimore <- aggregate(Emissions ~ year, baltimoreNEI_data,sum)

## Creating bar chart using base plot
barplot(
    aggTotalsBaltimore$Emissions,
    names.arg=aggTotalsBaltimore$year,
    xlab="Year",
    ylab="PM2.5 Emissions (Tons)",
    main="Total PM2.5 Emissions From All Baltimore City Sources",
    col="red"
)

# conclusion : Overall total emissions from PM2.5 have decreased in Baltimore City, Maryland from 1999 to 2008.
