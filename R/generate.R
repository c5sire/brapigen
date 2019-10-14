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
dir_r <- base::file.path(dir_b, "R/")
base::dir.create(path = dir_r)

### copy files
fileNames <- base::setdiff(x = base::list.files("inst/templates/"),
                           y = base::list.files("inst/templates/")[grepl(pattern = "*.mst",
                                                                         x = base::list.files("inst/templates/"))])
base::file.copy(from = paste0("inst/templates/", fileNames), to = paste0(dir_r, fileNames), overwrite = TRUE)

### Descriptionlib
### function to retrieve all call names
fetchCallNames <- function(brapiSpecs) {
  brapiSpecs[["paths"]] %>% names
}

### retrieve all call names in a readable format
allCallNames <- fetchCallNames(brapiSpecs = brapiSpecs)
allCallNames <- sub(pattern = "_",
                    replacement = "",
                    x = stringr::str_replace_all(
                      string = stringr::str_replace_all(string = allCallNames,
                                                        pattern = "/",
                                                        replacement = "_"),
                      pattern = stringr::regex("\\{|\\}"),
                      replacement = ""))

### only during development TO BE DELETED LATER
rm(list = setdiff(objects(),
                  c("brapiSpecs",
                    "allCallNames",
                    "dir_b",
                    "dir_r",
                    "fileNames",
                    "fetchCallNames")))

### function to retrieve call specifications for a GET call
### intended to loop over allCallNames, where each element of the vector will be
### used as idName
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
      aCall[["name"]] <- allCallNames[idNumber]
      aCall[["call"]] <- callName
      aCall[["verb"]] <- "get"
      return(aCall)
    }
  } else {
    return()
  }
}

### Create aCall object containing call elements
### tested on:
### * calls
### * commoncropnames
### * markers
### * germplasm_germplasmDbId_attributes
aCall <- getCall(brapiSpecs = brapiSpecs, idName = "search_observationtables_searchResultsDbId")
### Create aCallDesc object containing call description
aCallDesc <- stringr::str_replace_all(string = stringr::str_replace_all(string = aCall[["description"]],
                                                           pattern =  c("\\n\\n\\n"),
                                                           replacement =  "\\\n\\\n"),
                         pattern =  c("\\n\\n"),
                         replacement =  "\n#' ")

### function to generate @param section in the documentation
aCallParamVector <- function(aCall) {
  n <- length(aCall$parameters)
  res <- character(n)
  for (i in 1:n) {
    p <- aCall$parameters[[i]]
    if ("deprecated" %in% names(p)) {
      res[i] <- paste0(p[["name"]], "; ",
                       p[["description"]])
    } else {
      res[i] <- paste0(p$name, " ",
                       ifelse(("items" %in% names(p[["schema"]])),
                              "vector of type character",
                              ifelse(p[["schema"]][["type"]] == "integer",
                                     "integer",
                                     "character")),
                       "; required: ",
                       p$required, "; ",
                       p$description)
    }
  }
  return(res)
}

### Create @param description for documentation
aCallParam <- aCallParamVector(aCall = aCall)
aCallParam <- whisker::iteratelist(x = aCallParam, value = "pname")
aCallParam <- lapply(X = aCallParam,
                     FUN = function(el) {
                       lapply(X = el, FUN = function(elel) {
                         stringr::str_replace_all(string = elel,
                                                  pattern = "\\n\\n",
                                                  replacement = "\n#' ")
                       })
                     })

### Create function for function arguments
aCallParamString <- function(aCall) {
  n <- length(aCall[["parameters"]])
  res <- character(0)
  for (i in 1:n) {
    if (aCall[["parameters"]][[i]][["name"]] == "Authorization" | "deprecated" %in% names(aCall[["parameters"]][[i]])) {
      next()
    } else {
      if (aCall[["parameters"]][[i]][["name"]] == "page" | aCall[["parameters"]][[i]][["name"]] == "pageSize") {
        res <- paste(res,
                     paste(aCall[["parameters"]][[i]][["name"]],
                           "=",
                           as.integer(aCall[["parameters"]][[i]][["example"]])),
                     sep = ", ")
      } else {
        res <- paste(res,
                     paste(aCall[["parameters"]][[i]][["name"]], "=", "''"),
                     sep = ", ")
      }
    }
  }
  res <- sub(pattern = "^, ",
             replacement = "",
             x = res)
  return(res)
}

### Creation function arguments for selected call
aCallArgs <- aCallParamString(aCall = aCall)

### Create function to identify required arguments
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
    aCall$required <- ""
    return(aCall)
  } else {
    aCall$required <- required
    return(aCall)
  }
}

### Identify and store required arguments
aCall <- aCallReqArgs(aCall = aCall)

### Store call family information for documentation
aCallFamily <- c(
  paste0("brapi_", brapiSpecs[["info"]][["version"]]),
  aCall$tags
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
                  version = brapiSpecs[["info"]][["version"]],
                  tag = aCall[["tags"]])

template <- readLines(con = "inst/templates/function_name.mst")

functionName <- whisker::whisker.render(template = template,
                                        data = aCallData)

template <- readLines(con = "inst/templates/function_GET.mst")

writeLines(text = whisker::whisker.render(template = template,
                                          data = aCallData),
           con = paste0(dir_r, "/", functionName, ".R"))
