columnTypes <- c('character', 'character', 'numeric', 'numeric','numeric', 'numeric', 'numeric', 'numeric', 'numeric')

data <- read.delim(
  'household_power_consumption.txt', 
  sep = ';', 
  header = TRUE, 
  colClasses=columnTypes, 
  na.strings='?'
)

png(filename = 'plot1.png')

hist(
  data$Global_active_power, 
  col = 'red', 
  main = 'Global Active Power', 
  xlab = 'Global Active Power (kilowatts)'
)

dev.off()