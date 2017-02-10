
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
p_load(R.PersonalTools)
p_load(R.Maps)

tablePokemonLocations <- fread("data/tablePokemonLocations.txt")
interactiveListPokemon <- tablePokemonLocations[,sort(unique(namePokemon))]
# sapply(interactiveListPokemon,list)

pokeball <- makeIcon("www/pokeball.png",5,5)

shinyServer(function(input, output) {
  
  output$map <- renderLeaflet({
    map <- leaflet()
    map %<>% addTiles()
    map %<>% SetMapView('Paris')
    
    tablePokemonLocationsPart <- tablePokemonLocations[namePokemon == input$selectPokemon]
    
    if (nrow(tablePokemonLocationsPart) > 1) {
      map %<>% AddHeatMap(tablePokemonLocationsPart)
    }
    
    if (nrow(tablePokemonLocationsPart) > 0) {
      map %<>% addMarkers(data=tablePokemonLocationsPart,
                          ~longitude,
                          ~latitude,
                          icon=pokeball)
    }

  })
  
  output$sorry <- renderText({
    ifelse(nrow(tablePokemonLocations[namePokemon == input$selectPokemon]) == 0,
           "Sorry, this pokemon could not be found in Paris.",
           "")
  })
  
})
