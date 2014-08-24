library(plyr)
library(ggplot2)

# Load the SAS outputs and merge them
filenames <- list.files("data/sein", pattern="*.xls", full.names=T ,recursive = T)

tut <- lapply(filenames, read.csv)


# Customize the ggplot theme
mytheme <- theme_grey(12) + theme(panel.border = element_blank(), 
                                  axis.line = element_line(), 
                                  panel.background = element_blank(),
                                  legend.key = element_blank(), 
                                  panel.grid.minor.x = element_blank(), 
                                  panel.grid.major.x = element_blank(), 
                                  panel.grid.major.y = element_line(color="grey90"), 
                                  panel.grid.minor.y = element_blank())
theme_set(mytheme)

nbsej <- read.csv2("./data/SEJOURS_DEP.csv", stringsAsFactor=F)
nbsej_stats <- ddply(nbsej, .(annee), summarize, sum = sum(NbSej_dep))