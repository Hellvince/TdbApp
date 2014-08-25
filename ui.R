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
shinyUI(navbarPage("Tableau de bord",
                   
                   tabPanel("Résultats",  
                            
                            # Sidebar with a slider input for the number of bins
                            sidebarLayout(
                                    sidebarPanel(
                                            
                                            h3("Type de cancer"),
                                            
                                            selectInput("dataset", "Localisation :",
                                                        choices = list("Sein" = "sein",
                                                                       "Colon-Rectum" = "ccr")),
                                            
                                            hr(),
                                            
                                            h3("Filtre des résultats"),
                                            
                                            
                                            selectInput("region", "Région :",
                                                        choices = c("Choisir"="all", sort(unique(sein$reg_reg)))),
                                            
                                            selectInput("departement", "Département :",
                                                        choices = c("Choisir"="all", sort(unique(sein$dep_dep)))),
                                            
                                            selectInput("eta_num", "Numéro FINESS :",
                                                        choices = c("Choisir"="all", sort(unique(sein$eta_num)))),
                                            
                                            selectInput("raison_sociale", "Nom de l'établissement :",
                                                        choices = c("Choisir"="all", sort(unique(sein$raison_sociale)))),
                                            
                                            selectInput("lib_categorie", "Catégorie d'établissement :",
                                                        choices = c("Choisir"="all", sort(unique(sein$lib_categorie)))),
                                            
                                            hr(),
                                            
                                            HTML("<a class='btn' href='/'>RAZ</a>")
                                            
                                    ),
                                    
                                    # Show a plot of the generated distribution
                                    mainPanel(
                                            tabsetPanel(
                                                    
                                                    tabPanel('Results',
                                                             tableOutput("table")),
                                                    
                                                    tabPanel('help',
                                                             h3("This is the future help"))
                                            )
                                    ))
                   ),
                   
                   tabPanel("Données",
                            h3("Télécharger les données"),
                            p("Télécharger le jeu de données entier pour le cancer sélectionné"),
                            downloadButton('dl_ori', "Télécharger (format CSV)"),
                            br(),
                            br(),
                            p("Télécharger le jeu de données restreint aux critères sélectionnés"),
                            downloadButton('dl_sel', "Télécharger (format CSV)")
                            ),
                   
                   tabPanel("Aide",
                            h3("Future aide format markdown ?")
                            ),
                   
                   navbarMenu("A propos...",
                              #tabPanel("Des données", includeMarkdown("doc/data.md")),
                              #tabPanel("De l'INCA", , includeMarkdown("doc/inca.md")),
                              tabPanel("De l'application", includeMarkdown("doc/app.md"))
                              )
))