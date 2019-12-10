
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
             na.strings = "?",
             select = c("Global_active_power" ,"Date")
)

DF_Spec = DF[(DF$Date == "1/2/2007" | DF$Date=="2/2/2007"),]

###################[Plotting]#############################.

png(file = "plot1.png" , height=480, width=480)
hist(DF_Spec$Global_active_power , main = "Global Active Power",
     col = "red" ,
     xlab = "Global Active Power (kilowatts)",
     xlim = c(0,6)
)
dev.off()