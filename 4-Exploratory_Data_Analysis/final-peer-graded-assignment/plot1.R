# Q1- Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
df <- readRDS("data/summarySCC_PM25.rds")

# crate a file for plot
png("plot1.png")
barplot(tapply(df$Emissions/1000, df$year, sum), ylab = "Emission in 1000")
title(main = "Total PM2.5 Emission")

# save the plot in file
dev.off()
