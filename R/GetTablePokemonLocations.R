p_load(R.PersonalTools)

filesOutput <- list.files("data/ResultGridPattern/")

allFiles <- NULL
for (iFileOutput in filesOutput) {
  # iFileOutput <- filesOutput[1]
  filePart <- readLines(paste0("data/ResultGridPattern/",iFileOutput))
  allFiles %<>% append(filePart)
}

allPokemonFiles <- allFiles %>% .[grepl("https",.)] %>% unique
# length(allPokemonFiles)

GetPokemonName <- function(x) strsplit(x,split=" ") %>% .[[1]] %>% .[1]
GetPokemonLat <- function(x) strsplit(x,split="=") %>% .[[1]] %>% .[2] %>% strsplit(split=",") %>% .[[1]] %>% .[1]
GetPokemonLong <- function(x) strsplit(x,split="=") %>% .[[1]] %>% .[2] %>% strsplit(split=",") %>% .[[1]] %>% .[2] %>% strsplit(split = "&") %>% .[[1]] %>% .[1]

namePokemon <- allPokemonFiles %>% lapply(GetPokemonName) %>% unlist
latitude <- allPokemonFiles %>% lapply(GetPokemonLat) %>% unlist
longitude <- allPokemonFiles %>% lapply(GetPokemonLong) %>% unlist

tablePokemonLocationsNew <- data.table(namePokemon=namePokemon,
                                       latitude=as.numeric(latitude),
                                       longitude=as.numeric(longitude),
                                        date=as.character(Sys.Date()),
                                        hour=hour(Sys.time()))

# On va recreer la grille, avec le nombre de pokemons par carre
FindSquare <- function(longLatPokemon,seqLongLat) sum((seqLongLat - longLatPokemon < 0)*1)

tablePokemonLocationsNew[,squareLong := FindSquare(longitude,seqLong),by=longitude]
tablePokemonLocationsNew[,squareLat := FindSquare(latitude,seqLat),by=latitude]


tablePokemonLocations <- fread("data/tablePokemonLocations.txt")
tablePokemonLocations %<>% rbind(tablePokemonLocationsNew) %>% unique
# write.table(tablePokemonLocations,file="data/tablePokemonLocations.txt",row.names=F)
# unlink(paste0("data/ResultGridPattern/",filesOutput))