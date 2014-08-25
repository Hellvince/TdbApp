################################################################################
##
##      Title   : slobal.R (part of the Shiny application called TdbApp)
##      Author  : Vincent Canuel
##      Date    :
##
##
################################################################################

################################################################################
##
##      Main parameters
##
################################################################################

# List of supported cancer type
localisation <- c("sein")


# Loading required libraries
library(plyr)
library(ggplot2)

# Global ggplot theme customization
mytheme <- theme_grey(12) + theme(panel.border = element_blank(), 
                                  axis.line = element_line(), 
                                  panel.background = element_blank(),
                                  legend.key = element_blank(), 
                                  panel.grid.minor.x = element_blank(), 
                                  panel.grid.major.x = element_blank(), 
                                  panel.grid.major.y = element_line(color="grey90"), 
                                  panel.grid.minor.y = element_blank())
theme_set(mytheme)


################################################################################
##
##      Data munching
##
################################################################################

# Function to load the SAS outputs and merge them
loadData <- function(x) {
        filenames <- list.files(paste0("data/",x), 
                                pattern="*.csv", 
                                full.names=T ,
                                recursive = T)
        
        tmp <- lapply(filenames, 
                      function (x) read.csv(x, stringsAsFactor=F))
        
        return(ldply(tmp, data.frame))
} 

# Create a single dataframe for each type of supported cancer
for (file in localisation){
        tmp <- loadData(file)
        colnames(tmp) <- tolower(colnames(tmp))
        assign(file, tmp)
        rm(tmp)
}   