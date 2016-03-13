# Plot 4

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


# 4. Across the United States, how have emissions from coal combustion-related 
#    sources changed from 1999-2008?

# unique(SCC$SCC)
# unique(SCC$Data.Category)
# unique(SCC$Short.Name)
# unique(SCC$EI.Sector)
# unique(SCC$SCC.Level.One)
# unique(SCC$SCC.Level.Two)
# unique(SCC$SCC.Level.Three)
# unique(SCC$SCC.Level.Four)

CombustionID <- grep(pattern = "Combustion", x = SCC$SCC.Level.One)
SCC[CombustionID,]
CoalCombustionID <- grep(pattern = "Coal", x = SCC[CombustionID,]$SCC.Level.Three)
SCC[CoalCombustionID,]

NEI_CoalCombustion <- NEI[NEI$SCC %in% SCC[CoalCombustionID,]$SCC,]
plot4 <- aggregate(Emissions ~ year, data = NEI_CoalCombustion, FUN = sum)

png(filename = "plot4.png")
barplot(height = plot4$Emissions, space = NULL, names.arg = plot4$year, xlab = "Year", ylab = "Total PM2.5 emission (Tons) - Coal combustion-related source", main = "Emissions from coal combustion-related accross the year")
dev.off()

