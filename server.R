library(shiny)
library(plyr)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  selectedData <- reactive({
    # Update the selected data using years input
    return(subset(nbsej_stats, annee <= input$years[2] & annee >= input$years[1]))
  })
  
  output$distPlot <- renderPlot({    
    # Draw the barplot for the specified years
    ggplot(selectedData(), aes(x=annee, y=sum , fill="red")) +
      geom_bar(stat="identity") +
      ylim(input$limits, max(selectedData()$sum)) +
      labs(x = "Année",
           y="Somme des séjours",
           title= paste0("Evolution du nombre de séjours \nselon les classes d'âge, entre ", min(selectedData()$annee)," et ",  max(selectedData()$annee)))
  })
})
