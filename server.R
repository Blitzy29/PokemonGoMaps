
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
p_load(R.PersonalTools)
p_load(R.Maps)

tablePokemonLocations <- fread("data/tablePokemonLocations.txt")
# interactiveListPokemon <- tablePokemonLocations[,sort(unique(namePokemon))]

shinyServer(function(input, output) {
  
  output$map <- renderLeaflet({
    pokemonChosen <- input$selectPokemon
    map <- leaflet()
    map %<>% addTiles()
    map %<>% SetMapView('Paris')
    map %<>% AddHeatMap(tablePokemonLocations[namePokemon == pokemonChosen])
  })

})
