
###################[Getting the data ready]#######################
filename = "data_household_pc.zip"

if (!file.exists(filename)) { 
  fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename ) 
}

#unzip the .rar file the contains the database

if (!file.exists("household_power_consumption.txt")) { 
  unzip(filename )  
}


###################[Reading the data]#############################.
library(data.table)

DF = fread("household_power_consumption.txt" , header = T, 
            sep =";",
)
DF_Spec = DF[(DF$Date == "1/2/2007" | DF$Date=="2/2/2007"),]
DF_Spec$Date = as.Date(DF_Spec$Date, tryFormats = c("%d/%m/%Y"))
datetime = paste(DF_Spec$Date, DF_Spec$Time)
DF_Spec$datetime = as.POSIXct(datetime)

###################[Plotting]#############################.

png(file = "plot3.png" , height=480, width=480)

with(DF_Spec,{
     plot( datetime,Sub_metering_1,
           type="l",
           xlab="",
           ylab = "Energy sub metering",
           ylim = c(0 ,40))
           lines(datetime,Sub_metering_2 , col = "red")
           lines(datetime,Sub_metering_3 , col = "blue")
           legend("topright",
                  col = c("black","red","blue"),
                  lty=1,
                  legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
            )
     
})

dev.off()