plot4 <- function(dir=getwd()){
    # Check if file exists in named directory
    if(!file.exists("household_power_consumption.txt")){
        # Download the file
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip",method="curl")
        # Unzip the file
        unzip("household_power_consumption.zip")
    }
    
    # Create the data frame from the txt file
    # First row of the txt file is the header
    # Each data point in a row separated into columns by the ; operator
    # If the value is ? then it is read as NA in the data frame
    rawdf<-read.table("household_power_consumption.txt",na.strings="?",header=TRUE,sep=";")
    # Subset the data frame for just February 1-2, 2007
    rawdf.sub1<-rawdf[rawdf$Date=="1/2/2007"|rawdf$Date=="2/2/2007",]
    df<-rawdf.sub1
    # Set up vectors for the dates and times
    dates<-df$Date
    times<-df$Time
    # Create new vectors combining the date and time columns
    exactTime<-paste(dates,times)
    # Change the strings in the Time column into time objects
    df$Time=strptime(exactTime,format="%d/%m/%Y %H:%M:%S")
    # Change the strings in the Date column into date objects
    df$Date=as.Date(df$Date,format="%d/%m/%Y")
    
    # Initialize png file
    png("plot4.png",width=480,height=480)
    # Create 2x2 matrix to draw four plots, starting in first row first column
    par(mfrow=c(2,2))
    # Draw line graph of Global Active Power versus Time
    plot(df$Time,df$'Global_active_power',type="l",xlab="",ylab="Global Active Power")
    # Switch to row 1 column 2
    par(mfg=c(1,2))
    # Draw line graph of Voltage versus Time
    plot(df$Time,df$Voltage,xlab="datetime",ylab="Voltage",type="l")
    # Switch to row 2 column 1
    par(mfg=c(2,1))
    # Plot Sub metering 1 measurements versus times in line format with proper verical axis label
    plot(df$Time,df$'Sub_metering_1',type="l",xlab="",ylab="Energy sub metering")
    # Add red lines showing Sub metering 2 versus time
    lines(df$Time,df$'Sub_metering_2',col="red")
    # Add blue lines showing Sub metering 3 versus time
    lines(df$Time,df$'Sub_metering_3',col="blue")
    # Add legend in top right with corresponding labels, lines, and colors and no border
    legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1),bty="n")
    # Switch to row 2 column 2
    par(mfg=c(2,2))
    # Draw line graph of Global Reactive Power versus Time
    plot(df$Time,df$'Global_reactive_power',xlab="datetime",ylab="Global_reactive_power",type="l")
    # Create the png file plot4.png in the directory
    dev.off()
}