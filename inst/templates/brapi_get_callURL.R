brapi_get_callURL <- function(usedArgs, callPath, reqArgs, packageName, callVersion) {
  ## Check for Brapi connection object
  con <- usedArgs[["con"]]
  if (is.null(con)) {return(NULL)}
  ## Preprocess required and used arguments, respectively reqArgs and usedArgs
  usedArgs <- usedArgs[2:length(usedArgs)]
  if (grepl(pattern = ", ", x = reqArgs)) {
    reqArgs <- strsplit(x = reqArgs, split = ", ")[[1]]
  }
  ## Check for correct protocol
  if (con[["secure"]]) {con[["protocol"]] <- "https://"}
  ## Assign port
  port <- ifelse(con[["port"]] == 80, "", paste0(":", con[["port"]]))
  ## Add apipath when not  NULL
  if (!is.null(con[["apipath"]])) {
    con[["apipath"]] <- paste0("/", con[["apipath"]])
  }
  ## Add Brapi vesion
  version <- paste0("v", as.character(floor(callVersion)))
  brapiVersion <- paste0("/brapi/", version)
  ## Correction for multicrop databases when call does not require {crop}
  if (callPath == "/commoncropnames" | callPath == "/calls") {
    con[["multicrop"]] <- FALSE
  }
  ## Create pointbase callurl: http(s)://db:port/{apipath}/{crop}/brapi/v?
  if (con[["multicrop"]]) {
    callurl <- paste0(con[["protocol"]], con[["db"]], port, con[["apipath"]],
                        "/", con[["crop"]], brapiVersion)
  } else {
    callurl <- paste0(con[["protocol"]], con[["db"]], port, con[["apipath"]],
                        brapiVersion)
  }
  ## Extend pointbase callurl with call path to create call url
  pathVector <- strsplit(callPath, split = "\\{|\\}")[[1]]
  for (i in seq_along(pathVector)) {
    if (grepl(pattern = "^/", x = pathVector[i])) {
      callurl <- paste0(callurl, pathVector[i])
    } else {
      callurl <- paste0(callurl, usedArgs[[pathVector[i]]])
    }
  }
  ### Remove con and required arguments from used arguments list
  queryArgs <- usedArgs
  queryArgs[c("con", reqArgs)] <- NULL
  if (length(queryArgs) == 0) {
    return(callurl)
  } else {
    queryNames <- names(queryArgs)
    forbidden <- "[/?&]$"
    ### Add query parameters to call url
    if (all(c("pageSize", "page") %in% names(queryArgs))) {
      brapi_checkPagingArgs(queryArgs[["pageSize"]], queryArgs[["page"]])
    } # perhaps put this in argument checking
    if ("pageSize" %in% names(queryArgs)) {
      queryArgs[["pageSize"]] <- ifelse(queryArgs[["pageSize"]] == 1000,
                                        "",
                                        queryArgs[["pageSize"]])
    }
    if ("page" %in% names(queryArgs)) {
      queryArgs[["page"]] <- ifelse(queryArgs[["page"]] == 0,
                                    "",
                                    queryArgs[["page"]])
    }
    queryParams <- list()
    j <- 1
    for (i in seq_along(queryArgs)) {
      if (nchar(names(queryArgs)[[i]]) == 0) {
        base::stop("All parameters must have a name.")
      }
      if (is.logical(queryArgs[[i]])) {
        queryArgs[[i]] <- tolower(queryArgs[[i]])
      }
      if (length(queryArgs[[i]]) == 1) {
        if (is.na(queryArgs[[i]])) {queryArgs[[i]] <- ""}
      }
      if (!is.null(queryArgs[[i]]) && queryArgs[[i]] != "") {
        queryArgs[[i]] <- sub(forbidden, "", queryArgs[[i]])
        queryParams[[j]] <- paste0(queryNames[i], "=", paste(queryArgs[[i]], collapse = ","))
        j <- j + 1
      }
    }
    callurl <- gsub(pattern = " ",
                    replacement = "%20",
                    x = paste0(callurl, "?", paste(queryParams, collapse = "&")))
    return(sub(pattern = forbidden,
               replacement = "",
               x = callurl))
  }
}
