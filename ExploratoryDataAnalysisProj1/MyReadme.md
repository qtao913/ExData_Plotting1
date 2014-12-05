1. Source each R file. For example, source("plot1.R")
2. Run the function in each R file. For example, run "plot1()" at terminal
3. There are 4 blocks in each function. Each block handles different work.
4. The first block of code will automatically download the original file from the website, unzip the file to a folder named "data"
5. The second block of code extracts only rows from "1/2/2007" to "2/2/2007". Rows are read into a data frame.
6. The third block of code merges the first two columns to represent a single timestamp in a format %d/%m/%Y %H:%M:%S"
7. The fourth block of code plots each diagram according to requirements. Each diagram is saved as a 480 * 480 pixels png file.