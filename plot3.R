library(plyr)
library(ggplot2)

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
NEI <- NEI[NEI$fips == "24510", ]
NEI <- ddply(NEI, .(type, year), summarize, total = sum(Emissions))
# Plot
png(filename = "plot3.png", width = 1280, height = 720)
p <- ggplot(NEI, mapping = aes(x = year, y = total, colour = type) ) + geom_point() + geom_line() + 
  labs(title = expression('Total PM'[2.5]*" Emissions in Baltimore City"), x = "Year", y = expression('Total tons of PM'[2.5]*" Emission")) +
  theme(plot.margin = margin(2, 2, 2, 2, 'cm'), plot.title = element_text(size=26, hjust = 0.5), axis.title.x = element_text(size = 18), axis.title.y = element_text(size = 18))
print(p)
dev.off()