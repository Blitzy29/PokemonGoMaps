p_load(R.PersonalTools)
p_load(R.Maps)

tablePokemonLocations <- fread("data/tablePokemonLocations.txt")

# tablePokemonLocations[,namePokemon] %>% table %>% sort
# tablePokemonLocations[,hour] %>% table %>% sort

pokemonChosen <- 'Zubat'

map <- leaflet()
map %<>% addTiles()
map %<>% SetMapView('Paris')
map %<>% AddHeatMap(tablePokemonLocations[namePokemon == pokemonChosen & hour == hourPeriod])
DisplayMap(map)
