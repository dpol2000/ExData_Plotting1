## Plot 2

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
days$Global_active_power <- as.numeric(as.character(days$Global_active_power))

# set saving the plot into a png file
png('plot2.png', width = 480, height = 480)

# draw the plot
plot(times, days$Global_active_power, 
     type="l", ylab="Global Active Power (kilowatts)", xlab="", axes=FALSE)
axis(1, pos=-0.07, at=c(0, max(times)/2, max(times)), labels=c("Thu", "Fri", "Sat"))
axis(2)
box()

# saving is finished
dev.off()
