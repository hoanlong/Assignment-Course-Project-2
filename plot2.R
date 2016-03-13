# Plot 2

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


# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#    (fips == "24510") from 1999 to 2008? Use the base plotting system to make 
#    a plot answering this question.

plot2 <- aggregate(Emissions ~ year, data = NEI[NEI$fips == "24510",], FUN = sum)

png(filename = "plot2.png")
barplot(height = plot2$Emissions, space = NULL, names.arg = plot2$year, xlab = "Year", ylab = "Total PM2.5 emission (Tons) - Baltimore City, Maryland", main = "PM2.5 emission (Tons) vs Year - Baltimore City, Maryland")
dev.off()

