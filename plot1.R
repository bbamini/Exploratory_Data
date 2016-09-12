## Read PM2.5 Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

# Calculate total emissions from all sources for a given year
sums <- tapply(NEI$Emissions, NEI$year, FUN = sum)
sumsby1000 <- sums/1000 # Sum is in units of thousands of tons

# Creating png graphics device
png("plot1.png", width = 480, height = 480, units = "px") 
barplot(sumsby1000, col = "Wheat", main = "Total PM2.5 Emissions", 
        ylab = "Total PM2.5 (1000 tons)", xlab = "Year", yaxp = c(0, 8000, 8))
dev.off()

