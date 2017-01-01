rm(list = ls(all = TRUE))
gc()
setwd("d:/coursera/Course-Project-2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimoreNEI <- subset(NEI, NEI$fips == "24510")
baltimore_emission_by_year <- tapply(baltimoreNEI$Emissions, baltimoreNEI$year, sum)
years <- unique(NEI$year)

plot(baltimore_emission_by_year~years, main = "Total PM2.5 emission in the Baltimore City, Maryland by years", xlab = "Years", ylab = "Total emission of PM2.5 (tons)")
abline(lm(baltimore_emission_by_year~ years), lty = "dashed")

dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()