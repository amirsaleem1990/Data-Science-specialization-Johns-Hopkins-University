# # Q4- Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
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