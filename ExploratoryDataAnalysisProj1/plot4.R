plot4 <- function() {
	## dowload the original txt from the website into a folder named "data"
	## unzip the zip file
	url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	if(!file.exists("data")) {dir.create("data")}
	download.file(url,destfile="./data/rawdata.zip",method="curl")
	unzip(zipfile="./data/rawdata.zip", exdir ="./data/")
	
	## extract only the rows from "1/2/2007" and "2/2/2007" using fread.
	## reformat the extracted data table to data frame
	## assign corresponding column names to the data frame
	library(data.table)
	myData <- fread("grep ^[12]/2/2007 household_power_consumption.txt")
	myData <- as.data.frame.matrix(myData) ## change the table to a data frame
	myColName <- read.table("household_power_consumption.txt", sep = ";", nrows = 1, stringsAsFactors = FALSE)
	colnames(myData) <- myColName
	
	## merge the first two columns together to make a single column of timestamp
	temp <- paste(myData[,1],myData[,2])
	Dates <- strptime(temp, "%d/%m/%Y %H:%M:%S")
	data <- cbind(Dates, myData[,3:9])
	
	## plot 4 diagrams in a single canvas by calling "mfrow" and output to a png file
	png("./data/plot4.png", width=480, height=480, units = "px")
	par(mfrow = c(2,2), bg = "white")
	plot(data[,1], data[,2],type = "l", xlab = "", ylab = "Global Active Power")
	plot(data[,1], data[,4],type = "l", xlab = "", ylab = "Voltage")
	plot(data[,1], data[,6],type = "l", xlab = "", ylab = "Energy sub metering")
	lines(data[,1],data[,7],col = "red")
	lines(data[,1],data[,8],col = "blue")
	legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty = "n")
	plot(data[,1], data[,3],type = "l", xlab = "", ylab = "Global_reactive_power")
	dev.off()
}