## Read PM2.5 Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#Subset Baltimore City, Maryland PM2.5 data
baltimore <- subset(NEI, fips == "24510")

# Calculate total emissions for given source for a given year
sums <- tapply(baltimore$Emissions, list(baltimore$type, baltimore$year), 
               FUN = sum)

library(reshape2)

newdata <- melt(sums)
names(newdata) <- c("Type", "Year", "Emissions")

library(ggplot2)

# Creating graphics device
png("plot3.png", width = 480, height = 480, units = "px")
g <- ggplot(newdata, aes(Year, Emissions))
g + facet_grid(Type ~ ., scales = "free_y") + 
    geom_point(aes(Year, Emissions, color = Type)) + 
    geom_line(aes(color = Type)) + ylab("Emissions (tons)") +
    scale_x_continuous(name = "Year", breaks = c(1999, 2002, 2005, 2008))
dev.off()