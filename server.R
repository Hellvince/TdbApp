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
        
        datasetChoice <- reactive({
                # Get the selected type of cancer
                return(get(input$dataset))
        })
        
        
        selectedData <- reactive({
                # Update the selected data
                data <- datasetChoice()
                
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

        
        ########################################################################
        ##
        ##      REACTIVE : Watch and update filters value based on selection
        ##
        ########################################################################
        regionValues <- reactive({
                # Watch the value of region
                if (input$region != "all") {
                        return(unique(selectedData()$reg_reg))
                }else{
                        return(c("Choisir"="all", sort(unique(selectedData()$reg_reg))))
                }
        })
        
        departementValues <- reactive({
                # Watch the value of departement
                if (input$departement != "all"){
                        return(unique(selectedData()$dep_dep))
                }else{
                        return(c("Choisir"="all", sort(unique(selectedData()$dep_dep))))
                }
        })
        
        eta_numValues <- reactive({
                # Watch the value of FINESS
                if (input$eta_num != "all"){
                        return(unique(selectedData()$eta_num))
                }else{
                        return(c("Choisir"="all", sort(unique(selectedData()$eta_num))))
                }
        })
        
        raisonValues <- reactive({
                # Watch the value of name
                if (input$raison_sociale != "all"){
                        return(unique(selectedData()$raison_sociale))
                }else{
                        return(c("Choisir"="all", sort(unique(selectedData()$raison_sociale))))
                }
        })
        
        categorieValues <- reactive({
                # Watch the value of type
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
        
        
        ########################################################################
        ##
        ##      REACTIVE : Process the selected data
        ##
        ########################################################################
        # Calculate the sum of each variable
        sommeData <- reactive({
                as.data.frame(lapply(selectedData()[,-(1:8)], sum))
        })
        
        
        ########################################################################
        ##
        ##      OUTPUT : Render the values of interest
        ##
        ########################################################################
        # Render the output on main panel
        output$table <- renderTable({
                sommeData()
        })
        
#         output$distPlot <- renderPlot({    
#                 # Draw the barplot for the specified years
#                 ggplot(selectedData(), aes(x=eta_num, y=somme_act_sein_cciabla , fill="red")) +
#                         geom_bar(stat="identity") +
#                         labs(x = "Année", y="Somme des séjours")
#         })

        ########################################################################
        ##
        ##      OUTUPUT : Buttons to download datasets
        ##
        ########################################################################

        output$dl_ori <- downloadHandler(
                filename = function() {'Original_dataset.csv'},
                content = function(file) {write.csv(datasetChoice(), file, row.names = F)}
        )

        output$dl_sel <- downloadHandler(
                filename = function() {'Selected_dataset.csv'},
                content = function(file) {write.csv(selectedData(), file, row.names = F)}
        )
})

