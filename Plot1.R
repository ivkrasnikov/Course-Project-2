rm(list = ls(all = TRUE))
gc()
setwd("d:/coursera/Course-Project-2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

total_emission_by_year <- tapply(NEI$Emissions, NEI$year, sum)/10^6
years <- unique(NEI$year)

plot(total_emission_by_year~years, main = "Total PM2.5 emission by years", xlab = "Years", ylab = "Total emission of PM2.5 (mln. tons)")
abline(lm(total_emission_by_year~ years), lty = "dashed")

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()