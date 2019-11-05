## Internal function receiving a response for a GET call
brapi_GET <- function(callurl, usedArgs) {
  brapi_message(msg = paste0("URL call was: ", callurl, "\n"))
  brapi_message(msg = paste0("Waiting for response from server: ...\n"))

  if ("Accept" %in% names(usedArgs)) {
    res <- httr::GET(url = callurl,
                     httr::timeout(25),
                     httr::add_headers("Accept" = paste(usedArgs[["Accept"]]),
                                       "Authorization" = paste("Bearer", usedArgs[["con"]][["token"]])))
  } else {
    res <- httr::GET(url = callurl,
                     httr::timeout(25),
                     httr::add_headers("Authorization" = paste("Bearer", usedArgs[["con"]][["token"]])))
  }

  txt <- ifelse(res$status == 200, " ok!", " problem!")
  brapi_message(msg = paste0("Server status: ", txt, "\n"))
  # url <- httr::content(res)
  # if (format == "json") show_server_status_messages(res)
  return(res)
}
