#' @title
#' brapi_checkCon
#'
#' @description
#' Checks if a BrAPI server can be reached given the connection details.
#'
#' @param con list; required: **TRUE**; BrAPI connection object
#' @param verbose logical; default is TRUE
#' @param brapi_calls character; Use to check if one or more calls are implemented by the server according to the calls url. Default is "any".
#'
#' @details
#' Raises errors.
#'
#' @return logical
#'
#' @author brapir generator package
#'
#' @family brapiutils
#'
#' @example
#'
#' @export
brapi_checkCon <- function(con = NULL, verbose = TRUE, brapi_calls = "any") {
  base::stopifnot(is.brapi_con(con))
  base::stopifnot(is.logical(verbose))
  base::stopifnot(is.character(brapi_calls))

  url <- con$db

  brapi_canInternet()
  brapi_canInternet(url)

  if (verbose) {
    brapi_message("BrAPI connection ok.")
    brapi_message(paste(con, collapse = "\n"))
  }
  return(TRUE)
}
