### Internal function to check required arguments are filled
brapi_checkReqArgs <- function(...) {
  args <- list(...)
  non_empty <- function(s) {nchar(s) > 0}
  if (!lapply(X = args, FUN = non_empty) %>% unlist %>% all()) {
    stop("All required arguments must have at least a length of one.")
  }
}
