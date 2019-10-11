### brapigen package needs to be build!
### Changed to version 1.3
brapiSpecs <- yaml::read_yaml(system.file("openapi/brapi_1.3.yaml",
                                     package = "brapigen"))

### Packages to be added to DESCRIPTION
### usethis::use_package(package = "magrittr")
### usethis::use_package(package = "whisker")
### usethis::use_package(package = "stringr")

### load required packages
library(magrittr)
library(whisker)

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

allCallNames <- fetchCallNames(brapiSpecs = brapiSpecs)
allCallNames <- sub(pattern = "_",
                    replacement = "",
                    x = stringr::str_replace_all(
                      string = stringr::str_replace_all(string = allCallNames,
                                                        pattern = "/",
                                                        replacement = "_"),
                      pattern = stringr::regex("\\{|\\}"),
                      replacement = ""))

### Prior to 2019-10-11
# getCall <- function(brapiSpecs, idName) {
#   brapiCallNames <- fetchCallNames(brapiSpecs = brapiSpecs)
#   ## usethis::use_package(package = "stringr")
#   callName <- brapiCallNames[stringr::str_detect(string = brapiCallNames,
#                                                  pattern = idName)]
#   ## check type of the call and deprecation
#   brapiSpecs[["paths"]][[callName]][["get"]]
# }

### intended to loop over allCallNames, where each element of the vector will be
### used idName
getCall <- function(brapiSpecs, idName) {
  brapiCallNames <- fetchCallNames(brapiSpecs = brapiSpecs)
  allCallNames <- sub(pattern = "_",
                      replacement = "",
                      x = stringr::str_replace_all(
                        string = stringr::str_replace_all(string = brapiCallNames,
                                                          pattern = "/",
                                                          replacement = "_"),
                        pattern = stringr::regex("\\{|\\}"),
                        replacement = ""))
  idNumber <- which(allCallNames == idName)
  callName <- brapiCallNames[idNumber]
  ## Check for type of call and deprecation
  if ("get" %in% names(brapiSpecs[["paths"]][[callName]])) {
    if (!("Deprecated" %in% brapiSpecs[["paths"]][[callName]][["get"]][["tags"]])) {
      aCall <- brapiSpecs[["paths"]][[callName]][["get"]]
      aCall$verb <- "get"
      aCall$name <- allCallNames[idNumber]
      return(aCall)
    }
  } else {
    return()
  }
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

aCallParams <- lapply(X = aCallParams,
                      FUN = function(el) {
                        lapply(X = el, FUN = function(elel) {
                          stringr::str_replace_all(string = elel,
                                                   pattern = "\\n\\n",
                                                   replacement = "\n#' ")
                        })
                      })

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
  paste0("brapi_", brapiSpecs[["info"]][["version"]]),
  aCall$tags
)

aCallFamily <- iteratelist(aCallFamily, value = "fname")

aCallData <- list(name = aCall$name,
                  summary = aCall$summary,
                  parameters = aCallParams,
                  description = aCallDesc,
                  family = aCallFamily,
                  arguments = aCallArgs,
                  verb = aCall$verb,
                  version = brapiSpecs[["info"]][["version"]],
                  tag = aCall$tags)

template <- readLines(con = "inst/templates/function_name.mst")

functionName <- whisker::whisker.render(template = template,
                                        data = aCallData)

template <- readLines(con = "inst/templates/function_GET.mst")

writeLines(text = whisker::whisker.render(template = template,
                                          data = aCallData),
           con = paste0(dir_r, "/", functionName, ".R"))
