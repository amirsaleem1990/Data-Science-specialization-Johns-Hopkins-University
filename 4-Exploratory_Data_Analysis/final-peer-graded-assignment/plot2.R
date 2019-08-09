# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510"\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.Q2- Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510"\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
df <- readRDS("data/summarySCC_PM25.rds")
Baltimore <- subset(df, fips == "24510")

png("plot2.png")
barplot(tapply(Baltimore$Emissions, Baltimore$year, sum),
        ylab = "Emissions")
title(main="Total emissions from PM2.5 in the Baltimore City, Maryland for 1999-2008")
dev.off()