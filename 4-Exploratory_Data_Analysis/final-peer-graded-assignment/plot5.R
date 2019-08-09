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