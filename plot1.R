# Plot 1

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


# 1. Have total emissions from PM2.5 decreased in the United States from 1999 
#    to 2008? Using the base plotting system, make a plot showing the total 
#    PM2.5 emission from all sources for each of the years 1999, 2002, 2005, 
#    and 2008.

plot1 <- aggregate(Emissions ~ year, data = NEI, FUN = sum)

png(filename = "plot1.png")
barplot(height = plot1$Emissions, space = NULL, names.arg = plot1$year, xlab = "Year", ylab = "Total PM2.5 emission (Tons)", main = "PM2.5 emission (Tons) vs Year")
dev.off()

