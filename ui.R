################################################################################
##
##      Title   : ui.R (part of the Shiny application called TdbApp)
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
# Loading required packages
# TO DO : may not be required since we use a global.R file : load them all there ?
library(shiny)

################################################################################
##
##      Creating UI
##
################################################################################

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Tableau de bord"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
        
        h3("Type de cancer"),
        
        selectInput("subset", "Localisation :",
                    choices = list("Sien" = "sein",
                                   "Colon-Rectum" = "ccr")),
        
        hr(),

        h3("Filtre des résultats :"),
        
        selectInput("region", "Région :", 
                    choices = c("Choisir"='', unique(sein$reg_reg))),
        
        selectInput("departement", "Département :", 
                    choices = c("Choisir"='', unique(sein$dep_dep))),
        
        selectInput("eta_num", "Etablissement :", 
                    choices = c("Choisir"='', unique(sein$eta_num)))
        
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        
        tabPanel('Results',
                 plotOutput("distPlot")),
        
        tabPanel('help',
                 h3("This is the future help"))
    )
  ))
))
