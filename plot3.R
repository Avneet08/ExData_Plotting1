# Reading the file
pc <- read.table("household_power_consumption.txt",
                 header=TRUE,
                 sep=";",
                 skip=grep(pattern="1/2/2007",readLines("household_power_consumption.txt")),
                 nrows=2878,
                 na.strings = "?", 
                 colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric')
)
# Setting the column names 
colnames(pc)<-c("date","time","gap","grp","vol","gin","subm1","subm2","subm3")

# Formatting the date column to a date class
pc$date<-as.Date(pc$date,"%d/%m/%Y")

# Remove incomplete observation
pc <- pc[complete.cases(pc),]

# Creating the datetime object
dateTime <- paste(pc$date, pc$time)
dateTime<-setNames(dateTime,"datetime")
# Adding the date time to the dataset
pc<-cbind(dateTime,pc)

# Formating the datetime column 
pc$dateTime <- as.POSIXct(dateTime)

# Plot for plot3

with(pc, {
  plot(subm1~dateTime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(subm2~dateTime,col='Red')
  lines(subm3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"),cex = 0.75,lty=1, lwd=1,bty="n",
      legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png,"plot3.png", width=480, height=480)
dev.off()