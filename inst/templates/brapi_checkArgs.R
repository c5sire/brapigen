### Internal function to check used and required arguments
brapi_checkArgs <- function(usedArgs, reqArgs) {
  usedArgs[["con"]] <- NULL
  ## Check for the required Arguments
  if (grepl(pattern = ", ", x = reqArgs)) {
    reqArgs <- strsplit(x = reqArgs, split = ", ")[[1]]
  }
  reqArgs <- usedArgs[c(reqArgs)]
  for (i in 1:length(reqArgs)) {
    if (!is.character(reqArgs[[i]])) {
      stop('Required argument: "', names(reqArgs[i]), '" should be of type character e.g. "text".')
    }
    if (!(nchar(reqArgs[[i]]) > 0)) {
      stop("Required argument ", names(reqArgs[i]), " should at least have length one.")
    }
  }
  ## Delete required arguments from used arguments
  usedArgs[names(reqArgs)] <- NULL
  ## CONTINUE HERE!!

  if ("page" %in% names(usedArgs)) {
    if (!is.numeric(usedArgs[["page"]])) {
      stop('Argument: "page" should be of type integer.')
    }
    if (page < 0) {
      stop('Argument: "page" should be >= 0 (0 is the default meaning page number 1).')
    }
  }
  if (all(c("pageSize", "page") %in% names(usedArgs))) {
    brapi_checkPagingArgs(queryArgs[["pageSize"]], queryArgs[["page"]])
  } # perhaps put this in argument checking
}
