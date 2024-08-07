# Measuring Standing Trees: We will demonstrate how to use each instrument in the field. Before submitting your data to Canvas, remember to convert all measurements to metric. 

library("readxl")

wd <- getwd()
setwd(paste(wd,'/data/Exercise1', sep=""))

# There will be multiple files 
group1_data <- read_excel("Field Exercise 1 Datasheet.xlsx", sheet = "Exercise_1_Data")

# Example for how to merge all files
ex1 <- rbind( group1_data, group1_data, group1_data) # combine all groups into a single file:

# figures:
library( ggplot2)



