Exploratory Data Analysis - Course Project 2
============================================

# Introduction

Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National [Emissions Inventory web site](http://www.epa.gov/ttn/chief/eiinformation.html).

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

# Data

The data for this assignment are available from the course web site as a single zip file:

* [Data for Peer Assessment [29Mb]](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip)

The zip file contains two files:

PM2.5 Emissions Data (`summarySCC_PM25.rds`): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. Here are the first few rows.
````
##     fips      SCC Pollutant Emissions  type year
## 4  09001 10100401  PM25-PRI    15.714 POINT 1999
## 8  09001 10100404  PM25-PRI   234.178 POINT 1999
## 12 09001 10100501  PM25-PRI     0.128 POINT 1999
## 16 09001 10200401  PM25-PRI     2.036 POINT 1999
## 20 09001 10200504  PM25-PRI     0.388 POINT 1999
## 24 09001 10200602  PM25-PRI     1.490 POINT 1999
````

* `fips`: A five-digit number (represented as a string) indicating the U.S. county
* `SCC`: The name of the source as indicated by a digit string (see source code classification table)
* `Pollutant`: A string indicating the pollutant
* `Emissions`: Amount of PM2.5 emitted, in tons
* `type`: The type of source (point, non-point, on-road, or non-road)
* `year`: The year of emissions recorded

Source Classification Code Table (`Source_Classification_Code.rds`): This table provides a mapping from the SCC digit strings int he Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

You can read each of the two files using the `readRDS()` function in R. For example, reading in each file can be done with the following code:

````
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
````

as long as each of those files is in your current working directory (check by calling `dir()` and see if those files are in the listing).

# Assignment

The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.

## Making and Submitting Plots

For each plot you should

* Construct the plot and save it to a PNG file.
* Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You should also include the code that creates the PNG file. Only include the code for a single plot (i.e. plot1.R should only include code for producing plot1.png)
* Upload the PNG file on the Assignment submission page
* Copy and paste the R code from the corresponding R file into the text box at the appropriate point in the peer assessment.

In preparation we first ensure the data sets archive is downloaded and extracted.



We now load the NEI and SCC data frames from the .rds files.


```r
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
```

## Questions

You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.

### Question 1
Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.



First we'll aggregate the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.


```r
total_emission_by_year <- tapply(NEI$Emissions, NEI$year, sum)/10^6
years <- unique(NEI$year)
```

Using the base plotting system, now we plot the total PM2.5 Emission from all sources,

```r
plot(total_emission_by_year~years, main = "Total PM2.5 emission by years", xlab = "Years", ylab = "Total emission of PM2.5 (mln. tons)")
abline(lm(total_emission_by_year~ years), lty = "dashed")
```

![plot of chunk plot1](plot1.png) 

**Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?**

As we can see from the plot, total emissions have decreased in the US from 1999 to 2008.



### Question 2
Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.



First we aggregate total emissions from PM2.5 for Baltimore City, Maryland (fips="24510") from 1999 to 2008.

```r
baltimoreNEI <- subset(NEI, NEI$fips == "24510")
baltimore_emission_by_year <- tapply(baltimoreNEI$Emissions, baltimoreNEI$year, sum)
years <- unique(NEI$year)
```

Now we use the base plotting system to make a plot of this data,

```r
plot(baltimore_emission_by_year~years, main = "Total PM2.5 emission in the Baltimore City, Maryland by years", xlab = "Years", ylab = "Total emission of PM2.5 (tons)")
abline(lm(baltimore_emission_by_year~ years), lty = "dashed")
```

![plot of chunk plot2](plot2.png) 

**Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?**

Overall total emissions from PM2.5 have decreased in Baltimore City, Maryland from 1999 to 2008.

### Question 3
Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.



Using the ggplot2 plotting system,


```r
baltimoreNEI <- subset(NEI, NEI$fips == "24510")
baltimore <- aggregate(Emissions ~ year + type, baltimoreNEI, sum)

ggp <- ggplot(baltimoreNEI,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="Year", y=expression("Total emission of PM2.5 (tons)")) + 
  labs(title=expression("PM2.5 Emissions in the Baltimore City, Maryland by Source Type"))
print(ggp)
```

![plot of chunk plot3](plot3.png) 

**Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?**

The `non-road`, `nonpoint`, `on-road` source types have all seen decreased emissions overall from 1999-2008 in Baltimore City.

**Which have seen increases in emissions from 1999–2008?**

The `point` source saw a slight increase overall from 1999-2008. Also note that the `point` source saw a significant increase until 2005 at which point it decreases again by 2008 to just above the starting values. 

### Question 4
Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?



First we subset coal combustion source factors NEI data.

```r
coal_related  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)|grepl("coal", SCC$EI.Sector, ignore.case = TRUE)

coal_related <- SCC[coal_related, ]
coal_related <- NEI[NEI$SCC %in% coal_related$SCC, ]
```

Finally we plot using ggplot2,

```r
ggp <- ggplot(coal_related,aes(factor(year),Emissions/10^6)) +
  geom_bar(aes(fill=year), stat="identity",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="Year", y=expression("Total emission of PM2.5 (mln. tons)")) + 
  labs(title=expression("PM2.5 Coal Combustion Source Emissions Across US"))

print(ggp)
```

![plot of chunk plot4](plot4.png) 

**Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?**

Emissions from coal combustion related sources have decreased from 6 * 10^6 to below 4 * 10^6 from 1999-2008.

Eg. Emissions from coal combustion related sources have decreased by about 1/3 from 1999-2008!

### Question 5
How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?



First we subset the motor vehicles, which we assume is anything like Motor Vehicle in SCC.Level.Two.

```r
baltimoreNEI <- subset(NEI, NEI$fips == "24510" & NEI$type=="ON-ROAD")
balmore_annual <- aggregate(Emissions ~ year, baltimoreNEI, sum)
years <- unique(baltimoreNEI$year)
```

Finally we plot using ggplot2,

```r
ggp <- ggplot(balmore_annual, aes(factor(year), Emissions)) +
  geom_bar(aes(fill=year), stat="identity",width=0.75) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="Year", y=expression("Total emission of PM2.5 (Tons)")) + 
  labs(title=expression("PM2.5 emissions from Motor Vehicle Source in the Baltimore City, Maryland"))

print(ggp)
```

![plot of chunk plot5](plot5.png) 

**How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?**

Emissions from motor vehicle sources have dropped from 1999-2008 in Baltimore City!

### Question 6
Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?



Comparing emissions from motor vehicle sources in Baltimore City (fips == "24510") with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"),


```r
baltimoreNEI <- subset(NEI, NEI$fips == "24510" & NEI$type=="ON-ROAD")
baltimoreNEI$city <- "Baltimore City, Maryland"

LA_NEI <- subset(NEI, NEI$fips == "06037" & NEI$type=="ON-ROAD")
LA_NEI$city <- "Los Angeles, California"

rbNEI <- rbind(baltimoreNEI,LA_NEI)
```

Now we plot using the ggplot2 system,


```r
ggp <- ggplot(rbNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="Year", y=expression("Total PM2.5 Emission (Tons)")) + 
  labs(title=expression("PM2.5 Motor Vehicle Source Emissions in Baltimore & LA"))

print(ggp)
```

![plot of chunk plot6](plot6.png) 

**Which city has seen greater changes over time in motor vehicle emissions?**

Los Angeles County has seen the greatest changes over time in motor vehicle emissions.





