library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Tableau de bord"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      
      sliderInput("years",
                  "Data since :",
                  min = 2007,
                  max = 2013,
                  value = c(2007,2013),
                  format="###0"),
      
      sliderInput("limits",
                  "Y limit  :",
                  min = 0,
                  max = max(nbsej_stats$sum),
                  value = 0,
                  format="## ##0")
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
