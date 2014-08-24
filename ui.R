library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Tableau de bord"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
        
        selectInput("subset", "Localisation :",
                    choices = list("sein", "ccr")),
        
        selectInput("region", "Région :", 
                    choices = unique(sein$reg_reg))
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
