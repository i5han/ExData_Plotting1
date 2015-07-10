columnTypes <- c('character', 'character', 'numeric', 'numeric','numeric', 'numeric', 'numeric', 'numeric', 'numeric')

alldata <- read.delim(
  'household_power_consumption.txt', 
  sep = ';', 
  header = TRUE, 
  colClasses=columnTypes, 
  na.strings='?',
)

data <- subset(alldata, Date == '1/2/2007' | Date == '2/2/2007')

# easier to plot with unix time (merge date and time character columns and convert to unix time)
unix_time <- as.numeric(as.POSIXct(with(data, paste(Date, Time)), format='%d/%m/%Y %H:%M:%S'))

png(filename = 'plot2.png')

plot(
  unix_time, 
  data$Global_active_power, 
  type = 'l',
  xlab = '',
  xaxt="n", # dont plot x axis ticks
  ylab = 'Global Active Power (kilowatts)'
)

# 1170268200 is unixtime at start of Thursday as.numeric(as.POSIXct('1/2/2007 00:00:00', format='%d/%m/%Y %H:%M:%S'))
# 1170354600 is unixtime at start of Firday   as.numeric(as.POSIXct('2/2/2007 00:00:00', format='%d/%m/%Y %H:%M:%S'))
# 1170441000 is unixtime at start of Saturday as.numeric(as.POSIXct('3/2/2007 00:00:00', format='%d/%m/%Y %H:%M:%S'))
axis(1, at=c(1170268200, 1170354600, 1170441000), labels=c('Thursday', 'Friday', 'Saturday'))

dev.off()