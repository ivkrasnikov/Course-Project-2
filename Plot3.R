library(ggplot2)

rm(list = ls(all = TRUE))
gc()
setwd("d:/coursera/Course-Project-2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimoreNEI <- subset(NEI, NEI$fips == "24510")
baltimore <- aggregate(Emissions ~ year + type, baltimoreNEI, sum)

ggp <- ggplot(baltimoreNEI,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="Year", y=expression("Total emission of PM2.5 (tons)")) + 
  labs(title=expression("PM2.5 Emissions in the Baltimore City, Maryland by Source Type"))
print(ggp)

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()