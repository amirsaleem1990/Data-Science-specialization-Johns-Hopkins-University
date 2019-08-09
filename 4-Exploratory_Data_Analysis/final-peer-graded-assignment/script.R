#########################################################################################################################################################################################################################################
# Q1- Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008. #
#########################################################################################################################################################################################################################################
df <- readRDS("data/summarySCC_PM25.rds")

# crate a file for plot
png("plot1.png")
barplot(tapply(df$Emissions/1000, df$year, sum), ylab = "Emission in 1000")
title(main = "Total PM2.5 Emission")

# save the plot in file
dev.off()

###########################################################################################################################################################################################################################################
# Q2- Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510"\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question. #
###########################################################################################################################################################################################################################################
df <- readRDS("data/summarySCC_PM25.rds")
Baltimore <- subset(df, fips == "24510")
# crate a file for plot
png("plot2.png")
barplot(tapply(Baltimore$Emissions, Baltimore$year, sum),
        ylab = "Emissions")
title(main="Total emissions from PM2.5 in the Baltimore City, Maryland for 1999-2008")

# save the plot in file
dev.off()

###############################################################################################################################################################################################################################################################################################################################################################
# Q3- Of the four types of sources indicated by the type\color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question. #
###############################################################################################################################################################################################################################################################################################################################################################
library(ggplot2)
library(dplyr)
df <- readRDS("data/summarySCC_PM25.rds")
Baltimore <- subset(df, fips == "24510")
data <- Baltimore %>% group_by(type, year) %>% summarise(Emissions = sum(Emissions))
data$year <- as.character(data$year)

# crate a file for plot
png("plot3.png")
p <- ggplot(data = data, aes(type, Emissions))
p + geom_bar(stat = "identity", aes(fill = year), position = "dodge") +
  labs(title = "Baltimore City Emissions comparison") + labs (x = "Type", y = "Total Emissions")

# save the plot in file
dev.off()


#################################################################################################################
# Q4- Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008? #
#################################################################################################################
df <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
df.coal <- SCC[grep("Coal", SCC$EI.Sector,),]
df.coal <- filter(df.coal, grepl(
  paste(c("Combustion", "Stoker", "Burn", "fire", "fluidized", "furnace"),collapse="|"), 
  Short.Name, ignore.case=TRUE))
df.final <- df[df$SCC %in% df.coal$SCC,]

# crate a file for plot
png("plot4.png")

barplot(tapply(df.final$Emissions, df.final$year, sum), main = "Emissions from coal combustion-related sources changed from 1999–2008",
        ylab = "Sum of Emissions")

# save the plot in file
dev.off()


###############################################################################################
# Q5- How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? #
###############################################################################################
df <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
Baltimore <- subset(df, fips == "24510")
df.id <- SCC[grep("vehicle",
                  SCC$SCC.Level.Two,
                  ignore.case=TRUE), "SCC"]
final.df <- Baltimore[Baltimore$SCC %in% df.id,]
# crate a file for plot
png("plot5.png")

barplot(tapply(final.df$Emissions, final.df$year, sum), main = " Motor Vehicle Source Emissions in Baltimore from 1999-2008",
        ylab = "Sum of Emissions")

# save the plot in file
dev.off()

###############################################################################################################################################################################################################################################################################################
# Q6- Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"\color{red}{\verb|fips == "06037"|}fips=="06037"). Which city has seen greater changes over time in motor vehicle emissions? #
###############################################################################################################################################################################################################################################################################################
library(lattice)
df <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
ID <- SCC[grep("vehicle",
               SCC$SCC.Level.Two,
               ignore.case=TRUE), "SCC"]
df.vehicle <- df[df$SCC %in% ID, ]
df.baltimore <- subset(df.vehicle, fips == "24510")
df.Los.Angeles <- subset(df.vehicle, fips == "06037")

data.baltimore <- data.frame(tapply(df.baltimore$Emissions, df.baltimore$year, sum))
data.baltimore$year <- row.names(data.baltimore)
data.baltimore$city <- "Baltimore"
row.names(data.baltimore) <- 1:nrow(data.baltimore)
names(data.baltimore) <- c("Emissions.SUM", "year", "city")

data.Los.angeles <- data.frame(tapply(df.Los.Angeles$Emissions, df.Los.Angeles$year, sum))
data.Los.angeles$year <- row.names(data.Los.angeles)
data.Los.angeles$city <- "Los.angeles"
row.names(data.Los.angeles) <- 1:nrow(data.Los.angeles)
names(data.Los.angeles) <- c("Emissions.SUM", "year", "city")

final.data <- rbind(data.baltimore, data.Los.angeles)

# crate a file for plot
png("plot6.png")
dotplot(Emissions.SUM ~ year | city, data=final.data, layout = c(2,1))

# save the plot in file
dev.off()