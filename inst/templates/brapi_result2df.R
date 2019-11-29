### Internal function for parsing the result part of the response content into
### a flattened data.frame object
brapi_result2df <- function(cont, usedArgs) {
  if ("format" %in% names(usedArgs)) {
    ## three possibilities "csv", "tsv" and "flapjack"
    switch(usedArgs[["format"]],
           "csv" = {
             out <- read.csv(file = textConnection(cont),
                             stringsAsFactors = FALSE)
             colnames(out) <- gsub(pattern = "\\.",
                                   replacement = "|",
                                   x = colnames(out))},
           "tsv" = {
             out <- read.delim(file = textConnection(cont),
                               stringsAsFactors = FALSE)
             colnames(out) <- gsub(pattern = "\\.",
                                   replacement = "|",
                                   x = colnames(out))},
           "flapjack" = {
             out <- read.delim(file = textConnection(cont),
                               stringsAsFactors = FALSE)})
  } else {
    ## Parse JSON content into a list that consists of a metadata and result
    ## element
    contList <- jsonlite::fromJSON(txt = cont)
    ## Use only the result element from the content list (contList)
    resultList <- contList[["result"]]
    ## resultList can consist of:
    ## 1) master (no pagination only one line)
    ## 2) detail (only a "data" element)
    ## 3) master/detail (parse "data" element and repeat master part to match dimensions)
    if ("data" %in% names(resultList)) {
      payload <- ifelse(test = length(resultList) == 1,
                        yes = "detail",
                        no = "master/detail")
    } else {
      payload <- "master"
    }
    switch(payload,
           "master" = {
             master <- as.data.frame(resultList,
                                     stringsAsFactors = FALSE)
             dat <- master
           },
           "detail" = {
             detail <- as.data.frame(x = resultList[["data"]],
                                     stringsAsFactors = FALSE)
             for (colName in names(detail)) {
               if (class(detail[[colName]]) == "list") {
                 detail[[colName]] <- vapply(X = detail[[colName]],
                                             FUN = paste,
                                             FUN.VALUE = "",
                                             collapse = "; ")
               }
             }
             dat <- detail
           },
           "master/detail" = {##headerRow! e.g. /search/observationtables/{searchResultsDbId}
             detail <- as.data.frame(x = resultList[["data"]],
                                     stringsAsFactors = FALSE)
             for (colName in names(detail)) {
               if (class(detail[[colName]]) == "list") {
                 detail[[colName]] <- vapply(X = detail[[colName]],
                                             FUN = paste,
                                             FUN.VALUE = "",
                                             collapse = "; ")
               }
             }
             master <- resultList[!names(resultList) %in% "data"]
             dat <- cbind(as.data.frame(master, stringsAsFactors = FALSE), detail)
           })
  }
  return(dat)
}
