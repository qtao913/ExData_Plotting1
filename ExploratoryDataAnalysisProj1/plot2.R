plot2 <- function() {
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
	
	## plot the "power" against "date". Using type = line
	png("./data/plot2.png", width=480, height=480, units = "px")
	par(bg = "white")
	plot(data[,1], data[,2],type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
	dev.off()
}