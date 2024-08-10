# Measuring Standing Trees: We will demonstrate how to use each instrument in the field. Before submitting your data to Canvas, remember to convert all measurements to metric. 

library("readxl")

wd <- getwd()
setwd(paste(wd,'/data/Exercise2', sep=""))

# There will be multiple files 
group1_fp <- read_excel("Field Excercise 2 Datasheet.xlsx", sheet = "Worksheet Standing Trees", skip=9, n_max =2)

group1_vr <- read_excel("Field Excercise 2 Datasheet.xlsx", sheet = "Worksheet Standing Trees", skip=19, n_max =2)

# Example for how to merge all files
fp <- rbind( group1_fp, group2_fp) # combine all groups into a single file:

vr <- rbind( group1_vr, group2_vr) # combine all groups into a single file:

# figures:
library( ggplot2)

setwd('/Users/sm3466/YSE Dropbox/Yale-Myers MODs/YMF MODs 2024/Materials related to general MODs/Data Insights/DataInsights2024/data/Exercise2')
test <- read.csv("comp_old_data.csv" )

names(test)

library(ggplot2)
library(tidyverse)
test$Value <- as.numeric(test$Value)

test %>% filter(Variable == "Total Basal area") %>%  ggplot(aes(x= Group, y=Value)) + geom_point(alpha=0.5) +
  theme(axis.text.x = element_text(angle=25, hjust = 1,
                                   size = 12)) + facet_wrap(facet = vars(Week)) + ylab("Total Basal area")
test %>% filter(Variable == "Coarse Woody Material") %>%  ggplot(aes(x= Group, y=Value )) + geom_point(alpha=0.5) +
  theme(axis.text.x = element_text(angle=25, hjust = 1,
                                   size = 12)) + facet_wrap(facet = vars(Week)) + ylab("Coarse Woody Material")

