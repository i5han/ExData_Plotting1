columnTypes <- c('character', 'character', 'numeric', 'numeric','numeric', 'numeric', 'numeric', 'numeric', 'numeric')

alldata <- read.delim(
  'household_power_consumption.txt', 
  sep = ';', 
  header = TRUE, 
  colClasses=columnTypes, 
  na.strings='?',
)

data <- subset(alldata, Date == '1/2/2007' | Date == '2/2/2007')

png(filename = 'plot1.png')

hist(
  data$Global_active_power, 
  col = 'red', 
  main = 'Global Active Power', 
  xlab = 'Global Active Power (kilowatts)',
)

dev.off()