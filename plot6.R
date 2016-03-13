# Plot 6

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


# 6. Compare emissions from motor vehicle sources in Baltimore City with 
#    emissions from motor vehicle sources in Los Angeles County, California 
#    (fips == "06037"). Which city has seen greater changes over time in motor 
#    vehicle emissions?

VehiculeID <- grep(pattern = "[Vv]eh", x = SCC$Short.Name)
SCC[VehiculeID,]

NEI_Vehicule_BC <- NEI[NEI$fips == "24510" & NEI$SCC %in% SCC[VehiculeID,]$SCC,]
plot6a <- aggregate(Emissions ~ year, data = NEI_Vehicule_BC, FUN = sum)

NEI_Vehicule_LA <- NEI[NEI$fips == "06037" & NEI$SCC %in% SCC[VehiculeID,]$SCC,]
plot6b <- aggregate(Emissions ~ year, data = NEI_Vehicule_LA, FUN = sum)

png(filename = "plot6.png", width = 960, height = 480)
mydata <- data.frame(BC = plot6a$Emissions, LA = plot6b$Emissions, row.names = plot6a$year)
barplot(t(mydata), main="Emissions from motor vehicle sources in Baltimore vs Los Angeles", xlab = "year", ylab="Total PM2.5 emission (Tons) - Motor vehicle source", beside=TRUE, 
        col=c(21, 2))
legend(x = "topleft", c("Baltimore City, Maryland","Los Angeles County, California"), lty=1, lwd=2.5, col=c(21, 2))
geom_smooth(size = 1, color = "red", linetype = 1, method = "lm", se = FALSE)
dev.off()