## Don't ask me for my CRAN mirror every time
options("repos" = c(CRAN = "https://cran.rstudio.com/"))

library(pacman)

p_load(data.table)
p_load(plyr)
p_load(dplyr)
p_load(magrittr)
p_load(testthat)
p_load(devtools)

## Create invisible environment ot hold all your custom functions
.env <- new.env()

.env$print0 <- function(...) print(paste0(...))

## Attach all the variables above
attach(.env)

.First <- function() {
  unlink(".RData")
}

.Last <- function() {
  unlink(".RData")
}
