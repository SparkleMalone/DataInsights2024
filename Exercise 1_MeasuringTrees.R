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
setwd('/Users/sm3466/YSE Dropbox/Yale-Myers MODs/YMF MODs 2024/Materials related to general MODs/Data Insights/DataInsights2024/data/Exercise1')
test <- read.csv("exercise_1_data.csv" )

names(test)

library(ggplot2)
library(tidyverse)
test$Value <- as.numeric(test$Value)

test %>% filter(Variable == "DBH") %>%  ggplot(aes(x= Instrument, y=Value , col = Tree_species)) + geom_point(alpha=0.5) +
  theme(axis.text.x = element_text(angle=25, hjust = 1,
                                   size = 12)) + facet_wrap(facet = vars(Tree_number)) + ylab("DBH")
test %>% filter(Variable == "Height") %>%  ggplot(aes(x= Instrument, y=Value , col = Tree_species)) + geom_point(alpha=0.5) +
  theme(axis.text.x = element_text(angle=25, hjust = 1,
                                   size = 12)) + facet_wrap(facet = vars(Tree_number)) + ylab("Height")

