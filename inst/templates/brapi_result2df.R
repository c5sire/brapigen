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
             if (all(lengths(resultList) <= 1)) {
               ## use only lengths == 1
               master <- as.data.frame(resultList[lengths(resultList) == 1],
                                       stringsAsFactors = FALSE)
               dat <- master
             } else {
               master <- as.data.frame(resultList[lengths(resultList) == 1],
                                       stringsAsFactors = FALSE)
               tempmaster <- list()
               for (elname in names(which(lengths(resultList) > 1))) {
                 switch(class(resultList[[elname]]),
                        "character" = {
                          tempmaster[[elname]] <- paste(resultList[[elname]],
                                                        collapse = ", ")
                        },
                        "data.frame" = {
                          for (i in seq_len(nrow(resultList[[elname]]))) {
                            for (j in seq_along(resultList[[elname]])) {
                              tempmaster[[paste(elname, colnames(resultList[[elname]][j]),
                                                i,
                                                sep = ".")]] <- resultList[[elname]][i, j]
                            }
                          }
                        })
               }
               tempmaster < as.data.frame(tempmaster,
                                          stringsAsFactors = FALSE)
               dat <- cbind(master, tempmaster)
             }
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
