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

## Question 4: Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
## First we subset coal combustion source factors NEI data.

combustion_Data <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal_data <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coal_Combustion_Data <- (combustion_Data & coal_data)
coal_combustion_SCC<- SCC[coal_Combustion_Data,]
coal_combustion_NEI<- NEI[NEI$SCC %in% combustion_SCC$SCC, ]

ggplot(coal_combustion_NEI,aes(factor(year),Emissions/10^5)) +
    geom_bar(stat="identity",fill="grey",width=0.75) +
    theme_bw() +  guides(fill=FALSE) +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
    labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))
