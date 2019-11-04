### Packages to be added to DESCRIPTION of brapigen
### usethis::use_package(package = "yaml")
### usethis::use_package(package = "magrittr")
### usethis::use_package(package = "whisker")
### usethis::use_package(package = "stringr")

### load required packages
library(magrittr)
library(whisker)

### Functions
### ----
### Function to retrieve all call names
fetchCallNames <- function(brapiSpecs, verb = c("", "DELETE", "GET", "PATCH", "POST", "PUT")) {
  verb <- tolower(match.arg(verb))
  if (verb == "") {
    callNames <- brapiSpecs[["paths"]] %>% names
    callNames <- sub(pattern = "_",
                     replacement = "",
                     x = stringr::str_replace_all(
                       string = stringr::str_replace_all(string = callNames,
                                                         pattern = "/",
                                                         replacement = "_"),
                       pattern = stringr::regex("\\{|\\}"),
                       replacement = ""))
    return(callNames)
  } else {
    callNames <- as.character()
    for (i in names(brapiSpecs[["paths"]])) {
      if (verb %in% names(brapiSpecs[["paths"]][[i]])
          &&
          !("deprecated" %in% names(brapiSpecs[["paths"]][[i]][[verb]]))) {
        callNames <- c(callNames, i)
      }
    }
    callNames <- sub(pattern = "_",
                     replacement = "",
                     x = stringr::str_replace_all(
                       string = stringr::str_replace_all(string = callNames,
                                                         pattern = "/",
                                                         replacement = "_"),
                       pattern = stringr::regex("\\{|\\}"),
                       replacement = ""))
    return(callNames)
  }
}

### Function to retrieve call specifications for a GET call
### intended to loop over allCallNames, where each element of the vector will be
### used as idName
getCall <- function(brapiSpecs, idName) {
  allCallNames <- fetchCallNames(brapiSpecs = brapiSpecs)
  idNumber <- which(allCallNames == idName)
  callName <- names(brapiSpecs[["paths"]])[idNumber]
  ## Check for type of call and deprecation
  if ("get" %in% names(brapiSpecs[["paths"]][[callName]])) {
    if (!("Deprecated" %in% brapiSpecs[["paths"]][[callName]][["get"]][["tags"]])) {
      aCall <- brapiSpecs[["paths"]][[callName]][["get"]]
      aCall[["name"]] <- allCallNames[idNumber]
      aCall[["call"]] <- callName
      aCall[["verb"]] <- "get"
      return(aCall)
    }
  } else {
    return()
  }
}

### Function to generate @param section in the documentation
aCallParamVector <- function(aCall) {
  n <- length(aCall[["parameters"]])
  res <- character(0)
  for (i in 1:n) {
    p <- aCall[["parameters"]][[i]]
    if (p[["name"]] == "Authorization" | "deprecated" %in% names(p)) {
      next()
    } else {
      if (p[["name"]] %in% c("Accept",
                             "active",
                             "dataType",
                             "expandHomozygotes",
                             "format",
                             "includeSiblings",
                             "includeSynonyms",
                             "listType",
                             "sortOrder")) {
        switch(p[["name"]],
               "Accept" = {res <- c(res, paste0(p[["name"]], " ",
                                                "character",
                                                "; required: ",
                                                p[["required"]], "; ",
                                                p[["description"]], "; ",
                                                'default: "application/json",',
                                                ' other possible values: "text/csv"|"text/tsv"|"application/flapjack"'))},
               "active" = {res <- c(res, paste0(p[["name"]], " ",
                                                "logical",
                                                "; required: ",
                                                p[["required"]], "; ",
                                                p[["description"]], "; ",
                                                'default: NA,',
                                                ' other possible values: TRUE | FALSE'))},
               "dataType" = {res <- c(res, paste0(p[["name"]], " ",
                                                  "character",
                                                  "; required: ",
                                                  p[["required"]], "; ",
                                                  p[["description"]], "; ",
                                                  'default: "",',
                                                  ' other possible values: "application/json"|"text/csv"|"text/tsv"|"application/flapjack"'))},
               "expandHomozygotes" = {res <- c(res, paste0(p[["name"]], " ",
                                                           "logical",
                                                           "; required: ",
                                                           p[["required"]], "; ",
                                                           p[["description"]], "; ",
                                                           'default: NA,',
                                                           ' other possible values: TRUE | FALSE'))},
               "format" = {res <- c(res, paste0(p[["name"]], " ",
                                                "character",
                                                "; required: ",
                                                p[["required"]], "; ",
                                                p[["description"]], "; ",
                                                'default: "csv",',
                                                ' other possible values: "tsv" and depending on the call "flapjack" may be supported.'))},
               "includeSiblings" = {res <- c(res, paste0(p[["name"]], " ",
                                                         "logical",
                                                         "; required: ",
                                                         p[["required"]], "; ",
                                                         p[["description"]], "; ",
                                                         'default: NA,',
                                                         ' other possible values: TRUE | FALSE'))},
               "includeSynonyms" = {res <- c(res, paste0(p[["name"]], " ",
                                                         "logical",
                                                         "; required: ",
                                                         p[["required"]], "; ",
                                                         p[["description"]], "; ",
                                                         'default: NA,',
                                                         ' other possible values: TRUE | FALSE'))},
               "listType" = {res <- c(res, paste0(p[["name"]], " ",
                                                  "character",
                                                  "; required: ",
                                                  p[["required"]], "; ",
                                                  p[["description"]], "; ",
                                                  'default: "",',
                                                  ' other possible values: "germplasm"|"markers"|"observations"|"observationUnits"|"observationVariables"|"programs"|"samples"|"studies"|"trials"'))},
               "sortOrder" = {res <- c(res, paste0(p[["name"]], " ",
                                                   "character",
                                                   "; required: ",
                                                   p[["required"]], "; ",
                                                   p[["description"]], "; ",
                                                   'default: "",',
                                                   ' other possible values: "asc"|"ASC"|"desc"|"DESC"'))})
      } else {
        res <- c(res, paste0(p[["name"]], " ",
                             ifelse(("items" %in% names(p[["schema"]])),
                                    "vector of type character",
                                    ifelse(p[["schema"]][["type"]] == "integer",
                                           "integer",
                                           "character")),
                             "; required: ",
                             p[["required"]], "; ",
                             p[["description"]]))
      }
    }
  }
  return(res)
}

### Function to generate function call arguments
aCallParamString <- function(aCall) {
  n <- length(aCall[["parameters"]])
  res <- character(0)
  for (i in 1:n) {
    p <- aCall[["parameters"]][[i]]
    if (p[["name"]] == "Authorization" | "deprecated" %in% names(p)) {
      next()
    } else {
      if (p[["name"]] == "page" | p[["name"]] == "pageSize") {
        res <- paste(res,
                     paste(p[["name"]],
                           "=",
                           as.integer(p[["example"]])),
                     sep = ", ")
        next()
      }
      if (p[["name"]] == "format") {
        res <- paste(res,
                     paste(p[["name"]],
                           "=",
                           "'csv'"),
                     sep = ", ")
        next()
      }
      if (p[["name"]] == "min") {
        res <- paste(res,
                     paste(p[["name"]],
                           "=",
                           0),
                     sep = ", ")
        next()
      }
      if (p[["name"]] == "max") {
        res <- paste(res,
                     paste(p[["name"]],
                           "=",
                           0),
                     sep = ", ")
        next()
      }
      if (p[["name"]] %in% c("Accept",
                             "active",
                             "expandHomozygotes",
                             "includeSiblings",
                             "includeSynonyms")) {
        switch(p[["name"]],
               "Accept" = {res <- paste(res,
                                        paste(p[["name"]],
                                              "=",
                                              "'application/json'"),
                                        sep = ", ")
               next()},
               "active" = {res <- paste(res,
                                        paste(p[["name"]], "=", "NA"),
                                        sep = ", ")
               next()},
               "expandHomozygotes" = {res <- paste(res,
                                                   paste(p[["name"]], "=", "NA"),
                                                   sep = ", ")
               next()},
               "includeSiblings" = {res <- paste(res,
                                                 paste(p[["name"]], "=", "NA"),
                                                 sep = ", ")
               next()},
               "includeSynonyms" = {res <- paste(res,
                                                 paste(p[["name"]], "=", "NA"),
                                                 sep = ", ")
               next()})
      } else {
        res <- paste(res,
                     paste(p[["name"]], "=", "''"),
                     sep = ", ")
      }
    }
  }
  res <- sub(pattern = "^, ",
             replacement = "",
             x = res)
  return(res)
}

### Function to identify required arguments in a function call
aCallReqArgs <- function(aCall) {
  n <- length(aCall[["parameters"]])
  required <- character(0)
  for (i in 1:n) {
    p <- aCall$parameters[[i]]
    if (p[["required"]] == TRUE) {
      required <- paste(required,
                        aCall[["parameters"]][[i]][["name"]],
                        sep = ", ")
    } else {
      next()
    }
  }
  required <- sub(pattern = "^, ",
                  replacement = "",
                  x = required)
  if (length(required) == 0) {
    aCall[["required"]] <- ""
    return(aCall)
  } else {
    aCall[["required"]] <- required
    return(aCall)
  }
}

### ----

### Create a GET function

### brapigen package needs to be build!
### Changed to version 1.3
brapiSpecs <- yaml::read_yaml(system.file("openapi/brapi_1.3.yaml",
                                     package = "brapigen"))

### Packages to be added to DESCRIPTION of Brapir
### usethis::use_package(package = "curl")

### Create directory infrastructure
dir_b <- "../brapir"

base::unlink(x = dir_b, recursive = TRUE, force = TRUE)
base::list.files(path = dir_b, recursive = TRUE)

base::dir.create(path = dir_b)
dir_r <- base::file.path(dir_b, "R/")
base::dir.create(path = dir_r)

### copy files
fileNames <- base::setdiff(x = base::list.files("inst/templates/"),
                           y = base::list.files("inst/templates/")[grepl(pattern = "*.mst",
                                                                         x = base::list.files("inst/templates/"))])
invisible(base::file.copy(from = paste0("inst/templates/", fileNames),
                          to = paste0(dir_r, fileNames),
                          overwrite = TRUE))

### Retrieve call names in a readable format
###
### 105 Total calls
### --- +
###   0 DELETE calls
###  72 GET calls
###   0 PATCH calls
###  22 POST calls
###  11 PUT calls
allCallNames <- fetchCallNames(brapiSpecs = brapiSpecs)
DELETEcalls <- fetchCallNames(brapiSpecs = brapiSpecs, verb = "DELETE")
GETcalls <- fetchCallNames(brapiSpecs = brapiSpecs, verb = "GET")
PATCHcalls <- fetchCallNames(brapiSpecs = brapiSpecs, verb = "PATCH")
POSTcalls <- fetchCallNames(brapiSpecs = brapiSpecs, verb = "POST")
PUTcalls <- fetchCallNames(brapiSpecs = brapiSpecs, verb = "PUT")

### Create aCall object containing call elements
### tested on:
### * calls
### * commoncropnames
### * markers
### * germplasm_germplasmDbId_attributes
### * search_observationtables_searchResultsDbId
### * studies_studyDbId_layouts
### * studies_studyDbId_observations
### * maps_mapDbId_positions_linkageGroupName # has two required arguments
aCall <- getCall(brapiSpecs = brapiSpecs, idName = "calls")
### Create aCallDesc object containing call description
aCallDesc <- stringr::str_replace_all(string = stringr::str_replace_all(string = aCall[["description"]],
                                                           pattern =  c("\\n\\n\\n"),
                                                           replacement =  "\\\n\\\n"),
                         pattern =  c("\\n\\n"),
                         replacement =  "\n#' ")

### Create @param description for documentation
aCallParam <- aCallParamVector(aCall = aCall)
aCallParam <- whisker::iteratelist(x = aCallParam, value = "pname")
aCallParam <- lapply(X = aCallParam,
                     FUN = function(el) {
                       lapply(X = el, FUN = function(elel) {
                         stringr::str_replace_all(string = elel,
                                                  pattern = "\\n\\n",
                                                  replacement = "\n#' ")})})

### Creation function arguments for selected call
aCallArgs <- aCallParamString(aCall = aCall)

### Identify and store required arguments
aCall <- aCallReqArgs(aCall = aCall)

### Store call family information for documentation
aCallFamily <- c(
  paste0(tolower(strsplit(x = brapiSpecs[["info"]][["title"]], split = "-")[[1]][1]),
         "_",
         brapiSpecs[["info"]][["version"]]),
  aCall[["tags"]]
)
aCallFamily <- whisker::iteratelist(aCallFamily, value = "fname")

### Create call data for the selected call
aCallData <- list(name = aCall[["name"]],
                  summary = aCall[["summary"]],
                  parameters = aCallParam,
                  description = aCallDesc,
                  family = aCallFamily,
                  arguments = aCallArgs,
                  required = aCall[["required"]],
                  verb = aCall[["verb"]],
                  call = aCall[["call"]],
                  package = brapiSpecs[["info"]][["title"]],
                  version = brapiSpecs[["info"]][["version"]],
                  tag = aCall[["tags"]])

### Load template for function name
template <- readLines(con = "inst/templates/function_name.mst")
### Create function name
functionName <- whisker::whisker.render(template = template,
                                        data = aCallData)
### Load template to create the GET function
template <- readLines(con = "inst/templates/function_GET.mst")
### Write the created GET function
writeLines(text = whisker::whisker.render(template = template,
                                          data = aCallData),
           con = paste0(dir_r, functionName, ".R"))
