## Read PM2.5 Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#Subset Baltimore City, Maryland PM2.5 data
baltimore <- subset(NEI, fips == "24510")

# Calculate total emissions from all sources for a given year
sums <- tapply(baltimore$Emissions, baltimore$year, FUN = sum)

# Creating png graphics device
png("plot2.png", width = 480, height = 480, units = "px") 
barplot(sums, col = "Wheat", main = "Total PM2.5 Emissions in Baltimore City, MD", 
        ylab = "Total PM2.5 (tons)", xlab = "Year", yaxp = c(0, 3600, 6))
dev.off()

