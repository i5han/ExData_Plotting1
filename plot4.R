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

days <- c('1/2/2007 00:00:00', '2/2/2007 00:00:00', '3/2/2007 00:00:00')
day_labels <- c('Thursday', 'Friday', 'Saturday')
tck_locations <- as.numeric(as.POSIXct(days, format='%d/%m/%Y %H:%M:%S'))

png(filename = 'plot4.png')

par(mfcol = c(2,2))

plot(
  unix_time, 
  data$Global_active_power, 
  type = 'l',
  xlab = '',
  xaxt="n", # dont plot x axis ticks
  ylab = 'Global Active Power (kilowatts)'
)

axis(1, at=tck_locations, labels=day_labels)

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

axis(1, at=tck_locations, labels=day_labels)

legend(
  'topright', 
  lty = 1,
  bty = 'n',
  col = c('black', 'red', 'blue'), 
  legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')
)

with(data, plot(
  unix_time, 
  data$Voltage, 
  xaxt = 'n', 
  xlab = 'datetime', 
  ylab = 'Voltage', 
  type = 'l'
))
axis(1, at=tck_locations, labels=day_labels)

with(data, plot(
  unix_time, 
  Global_reactive_power, 
  xaxt = 'n', 
  xlab = 'datetime', 
  #ylab = 'Voltage', 
  type = 'l'
))
axis(1, at=tck_locations, labels=day_labels)

dev.off()
