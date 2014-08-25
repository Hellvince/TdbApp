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
shinyServer(function(input, output, session) {
        
        subsetChoice <- reactive({
                # Get the selected type of cancer
                return(get(input$subset))
        })
        
        selectedData <- reactive({
                # Update the selected data
                data <- subsetChoice()
                
                if (input$region != "all") {
                        data <- subset(data, reg_reg == input$region)
                }
                
                if (input$departement != "all"){
                        data <- subset(data, dep_dep == input$departement)
                }
                
                if (input$eta_num != "all"){
                        data <- subset(data, eta_num == input$eta_num)
                }
                
                if (input$raison_sociale != "all"){
                        data <- subset(data, raison_sociale == input$raison_sociale)
                }
                
                if (input$lib_categorie != "all"){
                        data <- subset(data, lib_categorie == input$lib_categorie)
                }
                
                data
        })

        
        # Watch the current value of filters and construct the resulting possibilites
        regionValues <- reactive({
                if (input$region != "all") {
                        return(unique(selectedData()$reg_reg))
                }else{
                        return(c("Choisir"="all", sort(unique(selectedData()$reg_reg))))
                }
        })
        
        departementValues <- reactive({
                if (input$departement != "all"){
                        return(unique(selectedData()$dep_dep))
                }else{
                        return(c("Choisir"="all", sort(unique(selectedData()$dep_dep))))
                }
        })
        
        eta_numValues <- reactive({
                if (input$eta_num != "all"){
                        return(unique(selectedData()$eta_num))
                }else{
                        return(c("Choisir"="all", sort(unique(selectedData()$eta_num))))
                }
        })
        
        raisonValues <- reactive({
                if (input$raison_sociale != "all"){
                        return(unique(selectedData()$raison_sociale))
                }else{
                        return(c("Choisir"="all", sort(unique(selectedData()$raison_sociale))))
                }
        })
        
        categorieValues <- reactive({
                if (input$lib_categorie != "all"){
                        return(unique(selectedData()$lib_categorie))
                }else{
                        return(c("Choisir"="all", sort(unique(selectedData()$lib_categorie))))
                }
        })
        
        # Push possible list of values to each filters
        observe({
                updateSelectInput(session, "region",
                                  choices = regionValues())
        })
        
        observe({
                updateSelectInput(session, "departement",
                                  choices = departementValues())        
        })
        
        observe({
                updateSelectInput(session, "eta_num",
                                  choices = eta_numValues())        
        })
        
        observe({
                updateSelectInput(session, "lib_categorie",
                                  choices = categorieValues())        
        })
        
        observe({
                updateSelectInput(session, "raison_sociale",
                                  choices = raisonValues())        
        })
        
        
        # Render the output on main panel
        output$text <- renderText({
                selectedData()$eta_num
        })
        
#         output$distPlot <- renderPlot({    
#                 # Draw the barplot for the specified years
#                 ggplot(selectedData(), aes(x=eta_num, y=somme_act_sein_cciabla , fill="red")) +
#                         geom_bar(stat="identity") +
#                         labs(x = "Année", y="Somme des séjours")
#         })
})
