# Measuring Standing Trees: We will demonstrate how to use each instrument in the field. Before submitting your data to Canvas, remember to convert all measurements to metric. 

library("readxl")
library(ggpubr)

setwd('/Users/sm3466/YSE Dropbox/Yale-Myers MODs/YMF MODs 2024/Materials related to general MODs/Data Insights/DataInsights2024/data/Exercise2/Edited')
files <- list.files( pattern= ".xls")

library(tidyverse)
# There will be multiple files 

compile.group <- function(files ){
  group1_fp <- read_excel(files, sheet = "Worksheet Standing Trees", skip=9, n_max =2)[2,] %>% select(`Group Number`, `Live BA (m2/ha)`) %>% mutate(Type = "Fixed")
  group1_vr <- read_excel(files, sheet = "Worksheet Standing Trees", skip=19, n_max =2)[2,]%>% select(`Group Number`, `Live BA (m2/ha)`) %>% mutate(Type = "Variable")
  group.data <- rbind(group1_fp, group1_vr )
  return(group.data)
}

group1 <- compile.group(files = files[1])
group2 <- compile.group(files = files[2]) %>% mutate(`Group Number` = 4)
group3 <- compile.group(files = files[3])
group4 <- compile.group(files = files[4])%>% mutate(`Group Number` = '4a')
group5 <- compile.group(files = files[5])
group6 <- compile.group(files = files[6])
group7 <- compile.group(files = files[7])

all.groups <- rbind(group1, group2, group3,group4,group4, group5)


library(ggplot2)
library(tidyverse)

Week1.Plota <- all.groups %>%  ggplot(aes(x= Type, y=`Live BA (m2/ha)`)) + 
  geom_point(alpha=0.5, size=3) + theme(text = element_text(size=25))  + 
  ylab("Total Basal area (m2/ha)") + geom_hline(yintercept=50,  color='red', size=1) +xlab("Method") + theme_bw()

Week1.Plota.final <- Week1.Plota + 
  stat_summary(fun.data=mean_sdl, 
               fun.args = list(mult=1),
               geom="errorbar", color="blue", width=0.2) + 
  stat_summary(fun.y=mean, geom="point", color="blue")

png(file="Basal_Area.png",
    width=500, height=500)


dev.off()

Week1.Plota <- all.groups %>%  ggplot(aes(x= Type, y=`Live BA (m2/ha)`)) + 
  geom_point(alpha=0.5, size=3) + theme(text = element_text(size=25))  + 
  ylab("Total Basal area (m2/ha)") +xlab("Method") + theme_bw()

Week1.Plota.final <- Week1.Plota + 
  stat_summary(fun.data=mean_sdl, 
               fun.args = list(mult=1),
               geom="errorbar", color="blue", width=0.2) + 
  stat_summary(fun.y=mean, geom="point", color="blue")

png(file="Basal_Area_NoLine.png",
    width=500, height=500)
Week1.Plota.final
dev.off()
