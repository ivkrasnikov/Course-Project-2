library(ggplot2)

rm(list = ls(all = TRUE))
gc()
setwd("d:/coursera/Course-Project-2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimoreNEI <- subset(NEI, NEI$fips == "24510" & NEI$type=="ON-ROAD")
baltimoreNEI$city <- "Baltimore City, Maryland"

LA_NEI <- subset(NEI, NEI$fips == "06037" & NEI$type=="ON-ROAD")
LA_NEI$city <- "Los Angeles, California"

rbNEI <- rbind(baltimoreNEI,LA_NEI)

ggp <- ggplot(rbNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="Year", y=expression("Total PM2.5 Emission (Tons)")) + 
  labs(title=expression("PM2.5 Motor Vehicle Source Emissions in Baltimore & LA"))

print(ggp)

dev.copy(png, file = "plot6.png", width = 480, height = 480)
dev.off()