## Read PM2.5 Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

library(reshape2)

#Subset Baltimore City and Los Angeles County PM2.5 data for motor vehicles
balt_LA_road <- subset(NEI, (fips == "24510" | fips == "06037") 
                         & type == "ON-ROAD")
# Calculate total emissions from all sources for a given year and given fips
sums <- tapply(balt_LA_road$Emissions, list(balt_LA_road$year, balt_LA_road$fips), 
               FUN = sum)
balt_LA <- melt(sums)
names(balt_LA) <- c("Year", "City", "Emissions")
balt_LA$City <- as.factor(balt_LA$City)
levels(balt_LA$City) <- c("Los Angeles County", "Baltimore City")

library(ggplot2)

# Creating graphics device
png("plot6.png", width = 480, height = 480, units = "px")
g <- ggplot(balt_LA, aes(Year, Emissions))
g + facet_grid(City ~ ., scales = "free_y") + 
    geom_point(aes(Year, Emissions, color = City)) + 
    geom_line(aes(color = City)) + 
    scale_x_continuous(name = "Year", breaks = c(1999, 2002, 2005, 2008))
dev.off()