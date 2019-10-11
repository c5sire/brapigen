### brapigen package needs to be build!
### Changed to version 1.3
brapiSpecs <- yaml::read_yaml(system.file("openapi/brapi_1.3.yaml",
                                     package = "brapigen"))

### load required packages
library(magrittr) # usethis::use_package(package = "magrittr")
library(whisker)  # usethis::use_package(package = "whisker")

### create directory infrastructure
dir_b <- "../brapir"

base::unlink(x = dir_b, recursive = TRUE, force = TRUE)
base::list.files(path = dir_b, recursive = TRUE)

base::dir.create(path = dir_b)
dir_r <- base::file.path(dir_b, "R")
base::dir.create(path = dir_r)

### copy files
base::file.copy(from = "inst/templates/zzz.R",
                to = file.path(dir_r, "zzz.R"))

### Descriptionlib
fetchCallNames <- function(brapiSpecs) {
  brapiSpecs[["paths"]] %>% names
}

getCall <- function(brapiSpecs, idName) {
  brapiCallNames <- fetchCallNames(brapiSpecs = brapiSpecs)
  ## usethis::use_package(package = "stringr")
  callName <- brapiCallNames[stringr::str_detect(string = brapiCallNames,
                                                 pattern = idName)]
  ## check type of the call and deprecation
  brapiSpecs[["paths"]][[callName]][["get"]]
}

aCall <- getCall(brapiSpecs = brapiSpecs, idName = "commoncropnames")

aCallDesc <- stringr::str_replace_all(string = stringr::str_replace_all(string = aCall[["description"]],
                                                           pattern =  c("\\n\\n\\n"),
                                                           replacement =  "\\\n\\\n"),
                         pattern =  c("\\n\\n"),
                         replacement =  "\n#' ")

aCallParamVector <- function(aCall) {
  n <- length(aCall$parameters)
  res <- character(n)
  for (i in 1:n) {
    p <- aCall$parameters[[i]]
    res[i] <- paste0(p$name, " ",
                     p$type, "; required: ",
                     p$required, "; ",
                     p$description)
  }
  return(res)
}

aCallParams <- aCallParamVector(aCall = aCall)

aCallParams <- iteratelist(x = aCallParams, value = "pname")

aCallParamString <- function(aCall) {
  n <- length(aCall$parameters)
  res <- character(n)
  for (i in 1:n) {
    p <- aCall$parameters[[i]]$name
    ## check for parameter type needed
    res[i] <- paste0(p, " = ''")
  }
  res <- paste(res, collapse = ", ")
  return(res)
}

aCallArgs <- aCallParamString(aCall = aCall)

aCallFamily <- c(
  "brapi_1.3",
  aCall$tags
)

aCallFamily <- iteratelist(aCallFamily, value = "fname")

aCallData <- list(name = "commoncropnames",
                  summary = aCall$summary,
                  parameters = aCallParams,
                  description = aCallDesc,
                  family = aCallFamily,
                  arguments = aCallArgs,
                  verb = "get",
                  version = "1.3",
                  tag = aCall$tags)

template <- readLines(con = "inst/templates/function_GET.mst")

writeLines(whisker.render(template, aCallData), "./output.R")
