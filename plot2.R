
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
             sep =";"  ,
             select = c("Global_active_power" , "Date" ,"Time")
)

DF_Spec = DF[(DF$Date == "1/2/2007" | DF$Date=="2/2/2007"),]

DF_Spec$Date = as.Date(DF_Spec$Date, tryFormats = c("%d/%m/%Y"))
datetime = paste(DF_Spec$Date, DF_Spec$Time)
DF_Spec$datetime = as.POSIXct(datetime)

###################[Plotting]#############################.

png(file = "plot2.png" , height=480, width=480)

with(DF_Spec,
     plot( datetime,Global_active_power,
           type="l",
           xlab = "Time",
           ylab = "Global Active Power (kilowatts)",
           ylim = c(0 ,7)
    )
)

dev.off()