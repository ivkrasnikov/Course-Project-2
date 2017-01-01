library(ggplot2)

rm(list = ls(all = TRUE))
gc()
setwd("d:/coursera/Course-Project-2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal_related  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)|grepl("coal", SCC$EI.Sector, ignore.case = TRUE)

coal_related <- SCC[coal_related, ]
coal_related <- NEI[NEI$SCC %in% coal_related$SCC, ]

ggp <- ggplot(coal_related,aes(factor(year),Emissions/10^6)) +
  geom_bar(aes(fill=year), stat="identity",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="Year", y=expression("Total emission of PM2.5 (mln. tons)")) + 
  labs(title=expression("PM2.5 Coal Combustion Source Emissions Across US"))

print(ggp)

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()