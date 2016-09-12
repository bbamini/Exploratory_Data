## Read PM2.5 Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Emissions from coal combustion-related sources were characterized as 
# SCC numbers with "Coal" in the Short.Name description field
coalindex <- grep("Coal", SCC$Short.Name)
coalSCC <- SCC$SCC[coalindex]

# New data table for coal combustion source
coal <- subset(NEI, NEI$SCC %in% coalSCC) 

# Calculate total emissions from coal sources for a given year
sums <- tapply(coal$Emissions, coal$year, FUN = sum)

# Creating png graphics device
png("plot4.png", width = 480, height = 480, units = "px") 
barplot(sums, col = "Wheat", main = "Total PM2.5 Emissions from Coal Combustion", 
        ylab = "Total PM2.5 (tons)", xlab = "Year", yaxp = c(0, 6e+05, 6))
dev.off()