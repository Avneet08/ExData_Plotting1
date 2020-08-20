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



# Creating the plot 2
 
plot(pc$gap~pc$dateTime,type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()