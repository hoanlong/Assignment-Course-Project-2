# Plot 5

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


# 5. How have emissions from motor vehicle sources changed from 1999-2008 in 
#    Baltimore City?

# unique(SCC$Short.Name)

VehiculeID <- grep(pattern = "[Vv]eh", x = SCC$Short.Name)
SCC[VehiculeID,]

NEI_Vehicule <- NEI[NEI$fips == "24510" & NEI$SCC %in% SCC[VehiculeID,]$SCC,]
plot5 <- aggregate(Emissions ~ year, data = NEI_Vehicule, FUN = sum)

png(filename = "plot5.png")
barplot(height = plot5$Emissions, space = NULL, names.arg = plot5$year, xlab = "Year", ylab = "Total PM2.5 emission (Tons) - Motor vehicle source", main = "Emissions from motor vehicle source accross the year")
dev.off()

