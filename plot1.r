plot1 <- function(dir=getwd()){
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
    png("plot1.png",width=480,height=480)
    # Draw the histogram of Global Active Power, specify title and x label, and make the bars red
    hist(df$'Global_active_power',main="Global Active Power",col="red",xlab="Global Active Power (kilowatts)")
    # Create the png file plot1.png
    dev.off()
}