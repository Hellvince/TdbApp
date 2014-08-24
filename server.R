library(shiny)
library(plyr)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    subsetChoice <- reactive({
        # Get the selected subset
        return(get(input$subset))
    })
    
    selectedData <- reactive({
        # Update the selected data using years input
        return(subset(subsetChoice(), reg_reg = input$region))
    })
  
    output$distPlot <- renderPlot({    
        # Draw the barplot for the specified years
        ggplot(selectedData(), aes(x=ETA_NUM, y=Somme_ACT_sein_CCIAbla , fill="red")) +
            geom_bar(stat="identity") +
            labs(x = "Année", y="Somme des séjours")
    })
})
