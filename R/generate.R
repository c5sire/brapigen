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

### Function to retrieve call specifications for a call, with either "DELETE",
### "GET", "PATCH", "POST", or "PUT" as verb,
### intended to loop over allCallNames, where each element of the vector will be
### used as idName.
getCall <- function(brapiSpecs, idName, verb) {
  verb <- tolower(verb)
  allCallNames <- fetchCallNames(brapiSpecs = brapiSpecs)
  idNumber <- which(allCallNames == idName)
  callName <- names(brapiSpecs[["paths"]])[idNumber]
  ## Check for type of call and deprecation
  if (verb %in% names(brapiSpecs[["paths"]][[callName]])) {
    if (!("Deprecated" %in% brapiSpecs[["paths"]][[callName]][[verb]][["tags"]])) {
      aCall <- brapiSpecs[["paths"]][[callName]][[verb]]
      aCall[["name"]] <- allCallNames[idNumber]
      aCall[["call"]] <- callName
      aCall[["verb"]] <- verb
      return(aCall)
    }
  } else {
    return()
  }
}

### Function to generate a call path for the @title section in the documentation
aCallTitle <- function(aCall) {
  titleCall <- gsub(pattern = "\\{", replacement = "\\\\{", x = aCall[["call"]])
  titleCall <- gsub(pattern = "\\}", replacement = "\\\\}", x = titleCall)
  return(titleCall)
}

### Function to generate a string ("callRefURL") to be used in @references to
### construct the URL
aCallRefURL <- function(aCall) {
  callRefURL <- gsub(pattern = "\\/\\{", replacement = "__", x = aCall[["call"]])
  callRefURL <- gsub(pattern = "\\}\\/", replacement = "__", x = callRefURL)
  callRefURL <- sub(pattern = "^\\/", replacement = "", x = callRefURL)
  callRefURL <- sub(pattern = "\\}$", replacement = "_", x = callRefURL)
  callRefURL <- gsub(pattern = "\\/", replacement = "_", x = callRefURL)
  callRefURL <- gsub(pattern = "-", replacement = "_", x = callRefURL)
  return(callRefURL)
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
                                                'default: as.character(NA),',
                                                ' other possible values: "csv", tsv" and depending on the call "flapjack" may be supported.'))},
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

### Function to generate @param section in the documentation for POST/PUT calls
aCallBodyVector <- function(aCall) {
  tempList <- aCall[["requestBody"]][["content"]][["application/json"]][["schema"]][["properties"]]
  res <- character(0)
  for (name in names(tempList)) {
    tempItem <- tempList[[name]]
    tempItem[["name"]] <- name
    if (tempItem[["name"]] == "Authorization" | "deprecated" %in% names(tempItem)) {
      next()
    } else {
      res <- c(res, paste0(name, " ",
                           switch(tempItem[["type"]],
                                  "array" = {
                                    if (tempItem[["items"]][["type"]] == "string") {
                                      "vector of type character"
                                    }
                                  },
                                  "boolean" = "logical",
                                  "integer" =  "integer",
                                  "object" = "list",
                                  "string"  = "character"),
                           "; required: FALSE", "; ",
                           tempItem[["description"]],
                           if (tempItem[["type"]] %in% c("array", "boolean", "integer", "string")) {
                             switch(tempItem[["type"]],
                                    "array" = {'; default: "", when using multiple values supply as c("value1", "value2").'},
                                    "boolean" = {"; default: NA, other possible values: TRUE | FALSE."},
                                    "integer" = {ifelse(name == "decimalPlaces",
                                                        "; default: 0.",
                                                        "")},
                                    "string" = {ifelse(name == "format",
                                                       '; default: as.character(NA), other possible values: "csv", "tsv", and depending on the call "flapjack" may be supported.',
                                                       '; default: "".')})
                           } else {
                             ""
                           })
               )
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
                           "as.character(NA)"),
                     sep = ", ")
        next()
      }
      if (p[["name"]] == "min") {
        res <- paste(res,
                     paste(p[["name"]],
                           "=",
                           "as.integer(NA)"),
                     sep = ", ")
        next()
      }
      if (p[["name"]] == "max") {
        res <- paste(res,
                     paste(p[["name"]],
                           "=",
                           "as.integer(NA)"),
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
  if ("requestBody" %in% names(aCall)) {
    tempList <- aCall[["requestBody"]][["content"]][["application/json"]][["schema"]][["properties"]]
    for (name in names(tempList)) {
      p <- tempList[[name]]
      p[["name"]] <- name
      if (p[["name"]] == "Authorization" | "deprecated" %in% names(p)) {
        next()
      } else {
        res <- paste(res,
                     paste(name, "=",
                           switch(p[["type"]],
                                  "array" = {
                                    if (p[["items"]][["type"]] == "string") "''"
                                  },
                                  "boolean" = "NA",
                                  "integer" = {
                                    switch(name,
                                           "decimalPlaces" = "0",
                                           "imageFileSize" = "as.integer(NA)",
                                           "imageFileSizeMax" = "as.integer(NA)",
                                           "imageFileSizeMin" = "as.integer(NA)",
                                           "imageHeight" = "as.integer(NA)",
                                           "imageHeightMax" = "as.integer(NA)",
                                           "imageHeightMin" = "as.integer(NA)",
                                           "imageWidth" = "as.integer(NA)",
                                           "imageWidthMax" = "as.integer(NA)",
                                           "imageWidthMin" = "as.integer(NA)",
                                           "page" = "0",
                                           "pageSize" = "1000"
                                          )
                                  },
                                  "object" = "list()",
                                  "string"  = ifelse(p[["name"]] == "format", "as.character(NA)" , "''")
                                  )),
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
for (verb in c("DELETE", "GET", "PATCH", "POST", "PUT")) {
  assign(paste(verb, "calls", sep = ""), fetchCallNames(brapiSpecs, verb))
}

# for (verb in c("GET", "POST", "PUT")) {
#   print(verb)
#   print(get(paste(verb, "calls", sep = "")))
# }
# get(paste(verb, "calls", sep = ""))

### Create aCall object containing call elements
### tested on: see openapi/examples_brapigen-brapir_test-server_brapi_org.R
for (callName in GETcalls) {
  ## retrieve call setting
  aCall <- getCall(brapiSpecs = brapiSpecs, idName = callName, verb = "GET")
  ## Create element to substitute call address in @title
  aCall[["titleCall"]] <- aCallTitle(aCall = aCall)
  ## Create call description as a character vector substituted LINE FEED \
  ## Carriage Return for @detail section.
  aCallDesc <- gsub(pattern = "\\n(?!(#' ))",
                    replacement = "\n#' ",
                    x = aCall[["description"]], perl = TRUE)
  ## Create @param descriptions for documentation
  aCallParam <- aCallParamVector(aCall = aCall)
  aCallParam <- whisker::iteratelist(x = aCallParam, value = "pname")
  aCallParam <- lapply(X = aCallParam,
                       FUN = function(el) {
                         lapply(X = el, FUN = function(elel) {
                           stringr::str_replace_all(string = elel,
                                                    pattern = "\\n\\n",
                                                    replacement = "\n#' ")})})
  ## Create call reference url part for the @references section
  aCall[["callRefURL"]] <- aCallRefURL(aCall = aCall)
  ## Creation function arguments for selected call
  aCallArgs <- aCallParamString(aCall = aCall)
  ## Identify and store required arguments
  aCall <- aCallReqArgs(aCall = aCall)
  ## Store call family information for documentation in @family
  aCallFamily <- c(
    paste0(tolower(strsplit(x = brapiSpecs[["info"]][["title"]], split = "-")[[1]][1]),
           "_",
           brapiSpecs[["info"]][["version"]]),
    aCall[["tags"]]
  )
  aCallFamily <- whisker::iteratelist(aCallFamily, value = "fname")
  ## Create call data list object for the selected call to be used by the
  ## whisker package.
  aCallData <- list(verb = aCall[["verb"]],
                    titleCall = aCall[["titleCall"]],
                    summary = aCall[["summary"]],
                    parameters = aCallParam,
                    description = aCallDesc,
                    version = brapiSpecs[["info"]][["version"]],
                    tag = gsub(pattern = " ",
                               replacement = "\\%20",
                               x = aCall[["tags"]][1]),
                    callRefURL = aCall[["callRefURL"]],
                    family = aCallFamily,
                    name = gsub(pattern = "-",
                                replacement = "_",
                                x = aCall[["name"]]),
                    arguments = aCallArgs,
                    required = aCall[["required"]],
                    call = aCall[["call"]],
                    package = brapiSpecs[["info"]][["title"]])

  ## Load template for function name
  template <- readLines(con = "inst/templates/function_name.mst")
  ## Create function name
  functionName <- whisker::whisker.render(template = template,
                                          data = aCallData)
  ## Load template to create the GET function
  template <- readLines(con = "inst/templates/function_GET.mst")
  ## Write the created GET function
  writeLines(text = whisker::whisker.render(template = template,
                                            data = aCallData),
             con = paste0(dir_r, functionName, ".R"))
}


for (callName in POSTcalls) {# start with callName <- POSTcalls[] "search_variables" done: 14,16,12,13,17,9,11,1,15,10,2,5,6,8
  ## Retrieve call setting
  aCall <- getCall(brapiSpecs = brapiSpecs, idName = callName, verb = "POST")
  ## Create element to substitute call address in @title
  aCall[["titleCall"]] <- aCallTitle(aCall = aCall)
  ## Create call description as a character vector substituted LINE FEED \
  ## Carriage Return for @detail section.
  aCallDesc <- gsub(pattern = "\\n(?!(#' ))",
                    replacement = "\n#' ",
                    x = aCall[["description"]], perl = TRUE)
  ## Create @param descriptions for documentation
  aCallParam <- aCallParamVector(aCall = aCall)
  aCallParam <- whisker::iteratelist(x = aCallParam, value = "pname")
  aCallParam <- lapply(X = aCallParam,
                       FUN = function(el) {
                         lapply(X = el, FUN = function(elel) {
                           stringr::str_replace_all(string = elel,
                                                    pattern = "\\n\\n",
                                                    replacement = "\n#' ")})})
  if ("requestBody" %in% names(aCall)) {
    callBodyVector <- aCallBodyVector(aCall = aCall)
    callBodyVector <- whisker::iteratelist(x = callBodyVector, value = "pname")
    aCallParam <- c(aCallParam, callBodyVector)
  }
  ## Create call reference url part for the @references section
  aCall[["callRefURL"]] <- aCallRefURL(aCall = aCall)
  ## Creation function arguments for selected call
  aCallArgs <- aCallParamString(aCall = aCall)
  ## Identify and store required arguments
  aCall <- aCallReqArgs(aCall = aCall)
  ## Store call family information for documentation in @family
  aCallFamily <- c(
    paste0(tolower(strsplit(x = brapiSpecs[["info"]][["title"]], split = "-")[[1]][1]),
           "_",
           brapiSpecs[["info"]][["version"]]),
    aCall[["tags"]])
  aCallFamily <- whisker::iteratelist(aCallFamily, value = "fname")
  ## Create call data list object for the selected call to be used by the
  ## whisker package.
  aCallData <- list(verb = aCall[["verb"]],
                    titleCall = aCall[["titleCall"]],
                    summary = aCall[["summary"]],
                    parameters = aCallParam,
                    description = aCallDesc,
                    version = brapiSpecs[["info"]][["version"]],
                    tag = gsub(pattern = " ",
                               replacement = "\\%20",
                               x = aCall[["tags"]][1]),
                    callRefURL = aCall[["callRefURL"]],
                    family = aCallFamily,
                    name = gsub(pattern = "-",
                                replacement = "_",
                                x = aCall[["name"]]),
                    arguments = aCallArgs,
                    required = aCall[["required"]],
                    call = aCall[["call"]],
                    package = brapiSpecs[["info"]][["title"]])

  ## Load template for function name
  template <- readLines(con = "inst/templates/function_name.mst")
  ## Create function name
  functionName <- whisker::whisker.render(template = template,
                                          data = aCallData)
  ## Load template to create the GET function
  template <- readLines(con = "inst/templates/function_POST.mst")
  ## Write the created GET function
  writeLines(text = whisker::whisker.render(template = template,
                                            data = aCallData),
             con = paste0(dir_r, functionName, ".R"))
}
