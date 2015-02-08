## Plot 3

## try to read the data file from the working directory
data <- 0
data <- read.table('household_power_consumption.txt', header = TRUE, sep=";")

## if the file is absent, download it from the internet
if (length(data)==1) {
    
    code <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                          "household_power_consumption.zip")
    
    if (code==0) {
        data <- read.table(unz("household_power_consumption.zip", 
                               "household_power_consumption.txt"), header = TRUE, sep=";")
    } else {
        stop("The data file cannot be downloaded!")
    }
}

## get data from two days of interest
day1 <- data[data$Date=='1/2/2007',]
day2 <- data[data$Date=='2/2/2007',]
days <- rbind(day1, day2)

## create a vector for the y axis
times <- c(1:length(days$Time))

## convert data into numeric format
days$Sub_metering_1 <- as.numeric(as.character(days$Sub_metering_1))
days$Sub_metering_2 <- as.numeric(as.character(days$Sub_metering_2))
days$Sub_metering_3 <- as.numeric(days$Sub_metering_3)

# set saving the plot into a png file
png('plot3.png', width = 480, height = 480)

# draw the plot
plot(times, days$Sub_metering_1, 
     type="l", xlab="", ylab="Energy sub metering", axes=FALSE,
     ylim=c(0,max(days$Sub_metering_1)))
lines(times, days$Sub_metering_2, col="red")
lines(times, days$Sub_metering_3, col="blue")
axis(1, pos=-1.5, at=c(0,max(times)/2,max(times)), labels=c("Thu", "Fri", "Sat"))
axis(2)

# add legend
legend(1866, 40, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1),lwd=c(2.5,2.5, 2.5),col=c("black", "red","blue"))
box()

# saving is finished
dev.off()