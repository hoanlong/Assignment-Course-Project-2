# Plot 3

# set working directory
setwd("~/Coursera/04_Exploratory Data Analysis/Week 04/Assignment Course Project 2")

# cheking for and creating directories
if (!file.exists("./01_Data")) {
        dir.create("./01_Data")
}

# download dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url = fileUrl, destfile = "./01_Data/Dataset.zip")
dateDownloaded <- date()
unzip(zipfile = "./01_Data/Dataset.zip", exdir = "./01_Data")

# read dataset for Training
NEI <- readRDS(file = "./01_Data/summarySCC_PM25.rds")
SCC <- readRDS(file = "./01_Data/Source_Classification_Code.rds")


# 3. Of the four types of sources indicated by the type (point, nonpoint, 
#    onroad, nonroad) variable, which of these four sources have seen decreases 
#    in emissions from 1999-2008 for Baltimore City? Which have seen increases 
#    in emissions from 1999-2008? Use the ggplot2 plotting system to make a 
#    plot answer this question.

library(ggplot2)
plot3 <- aggregate(Emissions ~ year + type, data = NEI[NEI$fips == "24510",], FUN = sum)

png(filename = "plot3.png")

ggplot(data = plot3, mapping = aes(x = factor(year), y = Emissions)) +
        geom_bar(stat="identity") +
        facet_grid(. ~ type) +
        geom_smooth(size = 1, color = "red", linetype = 1, method = "lm", se = FALSE) +
        xlab("Year") +
        ylab("Total PM2.5 emission (Tons) - Baltimore City, Maryland") +
        ggtitle("PM2.5 emission (Tons) vs Year - Baltimore City, Maryland")
dev.off()


