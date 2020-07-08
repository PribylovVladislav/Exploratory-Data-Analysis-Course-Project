# Download and save file

if(!file.exists('./data/exdata_data_NEI_data.zip')) {
  if(!dir.exists('./data')) {dir.create('./data')}
  fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
  download.file(fileURL, './data/exdata_data_NEI_data.zip')
  dir.create('./data/exdata_data_NEI')
  unzip('./data/exdata_data_NEI_data.zip', exdir = './data/exdata_data_NEI')
}

# Data processing

NEI <- readRDS('./data/exdata_data_NEI/summarySCC_PM25.rds')
SCC <- readRDS('./data/exdata_data_NEI/Source_Classification_Code.rds')
total <- c(sum(NEI[NEI$year == 1999 & NEI$fips == 24510,]$Emissions, na.rm = TRUE),
           sum(NEI[NEI$year == 2002 & NEI$fips == 24510,]$Emissions, na.rm = TRUE),
           sum(NEI[NEI$year == 2005 & NEI$fips == 24510,]$Emissions, na.rm = TRUE), 
           sum(NEI[NEI$year == 2008 & NEI$fips == 24510,]$Emissions, na.rm = TRUE))

# Plot

png(filename = "plot2.png", width = 1280, height = 720)
par(mar = c(4, 6, 4, 2))
plot(c(1999, 2002, 2005, 2008), total, type = "l", lwd = 3, axes = FALSE,
     xlab = 'Year', ylab = expression('Total tons of PM'[2.5]*' Emissions'),
     main = expression('Total tons of PM'[2.5]*' in Baltimore City'), cex.lab = 1.5, cex.main = 3)
axis(1, at = c(1999, 2002, 2005, 2008), labels = paste(c(1999, 2002, 2005, 2008)))
axis(2, at = c(1:4)*1000, labels = paste(c(1:4)*1000))
dev.off()