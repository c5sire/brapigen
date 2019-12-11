### Internal function for parsing the result part of the response content into
### a flattened data.frame object
brapi_result2df <- function(cont, usedArgs) {
  ## Helper functions
  jointDetail <- function(detailDat, colName) {
    detailDatCol <- data.frame(detailDat[[colName]],
                               stringsAsFactors = FALSE)
    detailDat[[colName]] <- NULL
    if (nrow(detailDatCol) > 0) {
      detailDat <-  detailDat[rep(seq_len(nrow(detailDat)), each = nrow(detailDatCol)), ]
      df <- cbind(detailDat, detailDatCol)
    } else {# nrow(detailDatCol) == 0
      df <- detailDat
    }
    row.names(df) <- seq_len(nrow(df))
    return(df)
  }
  ## Process result to data.frame
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
                        no =  "master/detail")
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
               for (l1name in names(which(lengths(resultList) > 1))) {
                 switch(class(resultList[[l1name]]),
                        "character" = {
                          tempmaster[[l1name]] <- paste(resultList[[l1name]],
                                                        collapse = ", ")
                        },
                        "data.frame" = {
                          for (i in seq_len(nrow(resultList[[l1name]]))) {
                            for (j in seq_along(resultList[[l1name]])) {
                              tempmaster[[paste(l1name,
                                                colnames(resultList[[l1name]][j]),
                                                i,
                                                sep = ".")]] <- resultList[[l1name]][i, j]
                            }
                          }
                        },
                        "list" = {
                          templist <- as.list(data.frame(t(as.matrix(unlist(as.relistable(resultList[[l1name]])))),
                                                             stringsAsFactors = FALSE))
                          names(templist) <- paste(l1name, names(templist), sep = ".")
                          tempmaster <- c(tempmaster, templist)
                        }
                 )
               }
               dat <- cbind(master, as.data.frame(tempmaster, stringsAsFactors = FALSE))
             }
           },
           "detail" = {
             if (class(resultList[["data"]]) == "data.frame") {
               detail <- as.data.frame(x = jsonlite::flatten(resultList[["data"]], recursive = TRUE),
                                       stringsAsFactors = FALSE)
             } else {
               detail <- as.data.frame(x = resultList[["data"]],
                                       stringsAsFactors = FALSE)
             }
             for (colName in names(detail)) {
               switch(class(detail[[colName]]),
                      "list" = {
                        ## list of data.frame
                        if (all(sapply(X = detail[[colName]],
                                       FUN = class) == "data.frame")) {
                          tempDetail <- jointDetail(detail[1, ], colName)
                          nrows <- nrow(detail)
                          if (nrows > 1) {
                            for (i in 2:nrows) {
                              nextRow <- jointDetail(detail[i, ], colName)
                              tempDetail <- dplyr::bind_rows(tempDetail, nextRow)
                            }
                          }
                          tempDetail[[colName]] <- NULL
                          ## Remove duplicated rows
                          tempDetail <- tempDetail[!duplicated(tempDetail), ]
                          ## Row renumbering
                          rownames(tempDetail) <- seq_len(nrow(tempDetail))
                          detail <- tempDetail
                        }
                      }#,
               )
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
