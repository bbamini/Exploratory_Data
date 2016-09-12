## Read PM2.5 Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#Subset Baltimore City, Maryland PM2.5 data for motor vehicles
baltimore_road <- subset(NEI, fips == "24510" & type == "ON-ROAD")


# Calculate total emissions from all sources for a given year
sums <- tapply(baltimore_road$Emissions, baltimore_road$year, FUN = sum)

# Creating png graphics device
png("plot5.png", width = 480, height = 480, units = "px") 
barplot(sums, col = "Wheat", main = "Total PM2.5 Emissions in Baltimore from 
        motor vehicles", ylab = "Total PM2.5 (tons)", xlab = "Year", 
        yaxp = c(0, 350, 7))
dev.off()