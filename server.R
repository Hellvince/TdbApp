################################################################################
##
##      Title   : server.R (part of the Shiny application called TdbApp)
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
library(plyr)
library(ggplot2)

################################################################################
##
##      Processing data
##
################################################################################

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        
        subsetChoice <- reactive({
                # Get the selected type of cancer
                return(get(input$subset))
        })
        
        selectedData <- reactive({
                # Update the selected data
                data <- subsetChoice()
                if (input$region != "all"){
                        data <- subset(data, reg_reg == input$region)
                }
                if (input$departement != "all"){
                        data <- subset(data, dep_dep == input$departement)
                }
                if (input$eta_num != "all"){
                        data <- subset(data, eta_num == input$eta_num)
                }
                data
        })
        
        
        output$table <- renderTable({
                selectedData()
        })
        
#         output$distPlot <- renderPlot({    
#                 # Draw the barplot for the specified years
#                 ggplot(selectedData(), aes(x=eta_num, y=somme_act_sein_cciabla , fill="red")) +
#                         geom_bar(stat="identity") +
#                         labs(x = "Année", y="Somme des séjours")
#         })
})
