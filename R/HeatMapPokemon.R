p_load(R.PersonalTools)
p_load(R.Maps)

tablePokemonLocations <- fread("data/tablePokemonLocations.txt")
setnames(tablePokemonLocations,c("latPokemon","longPokemon"),
         c("latitude","longitude"))

tablePokemonLocations[,nomPokemon] %>% table %>% sort
tablePokemonLocations[,hour] %>% table %>% sort

pokemonChosen <- 'Zubat'

map <- leaflet()
map %<>% addTiles()
map %<>% SetMapView('Paris')
map %<>% AddHeatMap(tablePokemonLocations[nomPokemon == pokemonChosen & hour == hourPeriod])
DisplayMap(map)
