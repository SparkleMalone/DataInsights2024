# Measuring Standing Trees: We will demonstrate how to use each instrument in the field. Before submitting your data to Canvas, remember to convert all measurements to metric. 

library("readxl")
library(gtools)
library(tidyverse)

wd <- getwd()
setwd(paste(wd,'/data/Exercise1', sep=""))

# There will be multiple files 
files <- list.files(pattern='.xls')

group_data <- read_excel(files[1], sheet = "Exercise_1_Data") [, 1:5] %>% as.data.frame()
group2_data <- read_excel(files[2], sheet = "Exercise_1_Data")[, 1:5] %>% as.data.frame()
group3_data <- read_excel(files[3], sheet = "Exercise_1_Data")[, 1:5] %>% as.data.frame()
group4_data <- read_excel(files[4], sheet = "Exercise_1_Data")[, 1:5] %>% as.data.frame()
group5_data <- read_excel(files[5], sheet = "Exercise_1_Data")[, 1:5] %>% as.data.frame()
group6_data <- read_excel(files[6], sheet = "Exercise_1_Data")[, 1:5] %>% as.data.frame()
group7_data <- read_excel(files[7], sheet = "Exercise_1_Data")[, 1:5] %>% as.data.frame()

names(group_data) <- names(group2_data)
names(group3_data) <- names(group2_data)
names(group4_data) <- names(group2_data)
names(group5_data) <- names(group2_data)
names(group6_data) <- names(group2_data)
names(group7_data) <- names(group2_data)
# Example for how to merge all files

rbind(group_data[, 1:5], group2_data[, 1:5])
ex1 <- rbind( group_data[, 1:5], group2_data[, 1:5], group3_data[, 1:5],
              group4_data[, 1:5], group5_data[, 1:5], group6_data[, 1:5],
              group7_data[, 1:5]) # combine all groups into a single file:

write.csv(ex1, 'version1.csv' )
ex1b <- read.csv('Version1b.csv' )
ex1b$count <- 1
ex1b.count <- ex1b %>% group_by(Tree_number, Variable, Instrument) %>% summarise( count = sum(count))

ex1b.count %>% filter(Instrument == 'Biltmore stick')

# Figures:
library(ggplot2)
library(tidyverse)

ex1b$Value <- as.numeric(ex1b$Value)
ex1b$Tree_number <- as.factor(ex1b$Tree_number)

p.1 <- ex1b %>% filter(Variable == "DBH") %>%  ggplot( aes(x= Tree_number, y=Value)) + 
  geom_dotplot(binaxis='y', stackdir='center')  +
  theme(text = element_text(size=18))+ facet_wrap(facet = vars(Instrument)) + ylab("DBH")

plot.dbh <- p.1+ stat_summary(fun.data="mean_sdl", fun.args = list(mult=1), 
                  geom="crossbar", width=0.5)

library(ggpubr)
png(file="DBH_Trees.png",
    width=600, height=500)
ggarrange(plot.dbh)
dev.off()

ex.dbh.treeS <- rbind(ex1b %>% filter(Variable == "DBH", Tree_number == c(1,2) ),ex1b %>% filter(Variable == "DBH", Tree_number == c(4,9) ))


plot.DBH.SampleTrees <-  ex.dbh.treeS %>%  ggplot( aes(x= Tree_number, y=Value)) + 
  geom_dotplot(binaxis='y', stackdir='center')  +
  theme(text = element_text(size=18)) + facet_wrap(facet = vars(Instrument)) + ylab("DBH")

plot.DBH.SampleTrees.final <-  plot.DBH.SampleTrees + stat_summary(fun.data="mean_sdl", fun.args = list(mult=1), 
                  geom="crossbar", width=0.5)


library(ggpubr)
png(file="DBH_TreesSample.png",
    width=600, height=500)
ggarrange(plot.DBH.SampleTrees.final)
dev.off()


pH.1 <- ex1b %>% filter(Variable == "Height", Instrument != 'Biltmore stick', Instrument != 'Calipers' ) %>%  ggplot( aes(x= Tree_number, y=Value)) + 
  geom_dotplot(binaxis='y', stackdir='center')  + theme(text = element_text(size=18)) + facet_wrap(facet = vars(Instrument)) + ylab("Height")

plot.Height <- pH.1+ stat_summary(fun.data="mean_sdl", fun.args = list(mult=1), 
                   geom="crossbar", width=0.5)

library(ggpubr)
png(file="Height_Trees.png",
    width=600, height=500)
ggarrange(plot.Height)
dev.off()

ex.Ht.treeS <- rbind(ex1b %>%filter(Variable == "Height", 
                              Instrument != 'Biltmore stick', 
                              Instrument != 'Calipers', 
                              Tree_number == c(3, 6) ), ex1b %>% 
                       filter(Variable == "Height", Instrument != 'Biltmore stick', Instrument != 'Calipers', Tree_number == 11))


                       
pH.1b <- ex.Ht.treeS %>%  ggplot( aes(x= Tree_number, y=Value)) + 
  geom_dotplot(binaxis='y', stackdir='center')  +
  theme(text = element_text(size=18)) + facet_wrap(facet = vars(Instrument)) + ylab("Height")

plot.Height <- pH.1b + stat_summary(fun.data="mean_sdl", fun.args = list(mult=1), 
                   geom="crossbar", width=0.5)

png(file="Height_TreesSamples.png",
    width=600, height=500)
ggarrange(plot.Height)
dev.off()
