
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Pokemon Go Maps"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput("selectPokemon", label = h3("Select a Pokemon"), 
                  choices = sapply(interactiveListPokemon,list), selected = 1)
      
    ),
    
    mainPanel(
      leafletOutput("map"),
      textOutput("sorry")
    )
    
  )
  
))