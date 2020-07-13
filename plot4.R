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
coal <- SCC[grep('*Coal', SCC$EI.Sector), ]
coal <- unique(coal$SCC)
NEI <- subset(NEI[NEI$SCC %in% coal,])
total <- c(sum(NEI[NEI$year == 1999 ,]$Emissions, na.rm = TRUE),
           sum(NEI[NEI$year == 2002 ,]$Emissions, na.rm = TRUE),
           sum(NEI[NEI$year == 2005 ,]$Emissions, na.rm = TRUE), 
           sum(NEI[NEI$year == 2008 ,]$Emissions, na.rm = TRUE))


# Plot

png(filename = "plot4.png", width = 1280, height = 720)
par(mar = c(4, 6, 4, 2))
plot(c(1999, 2002, 2005, 2008), total, type = "l", lwd = 3, axes = FALSE,
     xlab = 'Year', ylab = expression('Total millions of tons of PM'[2.5]*' Emissions from coal-related sources'),
     main = expression('Total tons of PM'[2.5]*' in US from coal-related sources'), cex.lab = 1.5, cex.main = 3)
axis(1, at = c(1999, 2002, 2005, 2008), labels = paste(c(1999, 2002, 2005, 2008)))
axis(2, at = c(seq(from = 2/10, to = 6/10, by = 1/20)*1000000), labels = paste( c(seq(from = 2/10, to = 6/10, by = 1/20))) )
dev.off()