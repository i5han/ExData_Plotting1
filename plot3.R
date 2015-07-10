columnTypes <- c('character', 'character', 'numeric', 'numeric','numeric', 'numeric', 'numeric', 'numeric', 'numeric')

alldata <- read.delim(
  'household_power_consumption.txt', 
  sep = ';', 
  header = TRUE, 
  colClasses=columnTypes, 
  na.strings='?',
)

data <- subset(alldata, Date == '1/2/2007' | Date == '2/2/2007')

# easier to plot with unix time than to work with date and time separately
# merge date and time character columns and convert to unix time
unix_time <- as.numeric(as.POSIXct(with(data, paste(Date, Time)), format='%d/%m/%Y %H:%M:%S'))

png(filename = 'plot3.png')

plot(
  unix_time, 
  data$Sub_metering_1, 
  type = 'l',
  xlab = '',
  xaxt="n", # dont plot x axis ticks
  ylab = 'Energy sub metering'
)

with(data, {
  lines(unix_time, Sub_metering_2, col = 'red')
  lines(unix_time, Sub_metering_3, col='blue')
})

days <- c('1/2/2007 00:00:00', '2/2/2007 00:00:00', '3/2/2007 00:00:00')
tck_locations <- as.numeric(as.POSIXct(days, format='%d/%m/%Y %H:%M:%S'))
axis(1, at=tck_locations, labels=c('Thursday', 'Friday', 'Saturday'))

legend('topright', lty = 1, col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

dev.off()