library(dplyr)
if(!file.exists(file.path('data'))){ dir.create(file.path('data'))}
url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(url= url, destfile = file.path('data','power_consumption.zip'), mode = 'wb')
dir_files <- unzip(file.path('data','power_consumption.zip'), list = T)$Name

data <- read.table(unz(file.path('data','power_consumption.zip'), dir_files), 
                   sep=';', 
                   header = T, 
                   na.strings = '?')
df <-   data %>% 
        mutate(Datetime = strptime(paste(Date, Time), 
                                   format="%d/%m/%Y %H:%M:%S")) %>% 
        mutate(Date = as.Date(Date, format='%d/%m/%Y')) %>%
        filter(Date ==  as.Date('2007-02-01') | Date == as.Date('2007-02-02'))

png(filename = 'plot4.png')
par(mfrow = c(2,2))
with(df,{
        plot(Datetime, Global_active_power, type = "l", lty = 1, 
             xlab='', 
             ylab ='Global Active Power')
        plot(Datetime, Voltage, type = "l", lty = 1, 
             xlab='datetime', 
             ylab ='Voltage')
        plot(Datetime, Sub_metering_1, type = "l", lty = 1, 
             xlab='', 
             ylab ='Energy sub metering')
        points(Datetime, Sub_metering_2, type = "l", lty = 1, col = 'red')
        points(Datetime, Sub_metering_3, type = "l", lty = 1, col = 'blue')
        plot(Datetime, Global_reactive_power, type = "l", lty = 1, 
             xlab='datetime', 
             ylab ='Global_reactive_power')
})
dev.off()