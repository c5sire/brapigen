### Internal function for parsing the result part of the response content into
### a data.frame object
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
    if ("data" %in% names(resultList) && length(resultList) == 1) {
      ## Only "data" element (Payload: detail)
      dat <- as.data.frame(x = resultList[["data"]], stringsAsFactors = FALSE)
      for (colName in names(dat)) {
        if (class(dat[[colName]]) == "list") {
          dat[[colName]] <- vapply(X = dat[[colName]],
                                   FUN = paste,
                                   FUN.VALUE = "",
                                   collapse = "; ")
        }
      }
    }
    ## resultList can consist of:
    ## 1) master (no pagination only one line)
    ## 2) detail (only a "data" element)
    ## 3) master/detail (first parse "data" element and repeat master part to match dimensions)
  }
  return(dat)
}
