# Q3- Of the four types of sources indicated by the type\color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
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