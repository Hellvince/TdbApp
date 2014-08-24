library(plyr)
library(ggplot2)

# Load the SAS outputs and merge them
# Create a single dataframe for each cancer localisation
loadData <- function(x) {
    filenames <- list.files(paste0("data/",x), pattern="*.csv", full.names=T ,recursive = T)
    tmp <- lapply(filenames, function (x) read.csv(x, stringsAsFactor=F))
    return(ldply(tmp, data.frame))
} 

localisation <- c("sein")

for (file in localisation){
    tmp <- loadData(file)
    assign(file, tmp)
    rm(tmp)
}   

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