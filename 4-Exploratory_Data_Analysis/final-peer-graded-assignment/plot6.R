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