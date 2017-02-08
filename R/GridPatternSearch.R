# Limite of Paris
northEast  <- list(lat=48.90738242860694, long=2.4794769287109375)
southWest <- list(lat=48.811385499847525,long=2.2443008422851562)

# Grid pattern 13 by 13
pasLong <- abs(northEast$long - southWest$long)/13
pasLat  <- abs(northEast$lat  - southWest$lat )/13

seqLong <- seq(southWest$long,northEast$long,pasLong)
seqLat  <- seq(southWest$lat ,northEast$lat ,pasLat )

listGridPattern <- NULL
for (iLong in seqLong) {
  for (iLat in seqLat) {
    listGridPattern %<>% append(list(list(long=iLong,lat=iLat)))
  }
}

WriteCommandLine <- function(commandLine,fileToWrite) {
  commandLines <- NULL
  try(commandLines <- readLines(fileToWrite),silent=T)
  commandLines %<>% append(commandLine)
  write(commandLines,file = fileToWrite)
}

counting <- 1
for (iGridPattern in listGridPattern) {
  
  commandLine <- paste0("pokevision.exe watch",
                          " --lat=",iGridPattern$lat,
                          " --lon=",iGridPattern$long,
                          " --name=Paris",
                          " --range=1000",
                          " > data/ResultGridPattern/output_",counting,"_$(date +'%Y%m%d_%H%M').txt &",
                          " timeout 5",
                          " ; kill $!")
  
  WriteCommandLine(commandLine,"allCommandLines.sh")
  WriteCommandLine("sleep 10","allCommandLines.sh")
  
  counting %<>% +1
  
}
