brapi <- yaml::read_yaml(system.file("openapi/brapi_1.2.yaml", package = "brapigen"))
library(magrittr)
library(whisker)
# create directory infrastructure

dir_b <- "../brapir"

unlink(dir_b, recursive = T, force = T)
list.files(dir_b, recursive = T)


dir.create(dir_b)
dir_r <- file.path(dir_b, "R")
dir.create(dir_r)

file.copy("inst/templates/zzz.R", file.path(dir_r, "zzz.R"))
# Descriptionlib

get_call_names <- function(brapi) {
  brapi$paths %>% names
}

get_call <- function(brapi, id_name) {
  brapi_names <- get_call_names(brapi)
  nme <- brapi_names[stringr::str_detect(brapi_names, id_name)]
  brapi$paths[nme][[1]]$get
}
acall <- get_call(brapi, "common")
ades <- stringr::str_replace_all(acall$description, "\\n\\n", "\n#' ")

template <- readLines("inst/templates/function_GET.mst")

get_param_vector <- function(acall) {
  n <- length(acall$parameters)
  res <- character(2)
  for (i in 1:n) {
    p <- acall$parameters[[i]]
    res[i] <- paste0(p$name, " ",
                     p$type, "; required: ",
                     p$required, "; ",
                     p$description
                     )
  }
  return(res)
}

aparam <- get_param_vector(acall)
aparam<- iteratelist(aparam, value = "pname")

get_param_string <- function(acall) {
  n <- length(acall$parameters)
  res <- character(n)
  for (i in 1:n) {
    p <- acall$parameters[[i]]$name
    res[i] <- paste0( p, " = ''")
  }
  res <- paste(res, collapse = ", ")
  return(res)
}

params <- get_param_string(acall)

afamily <- c(
  "brapi_1.3",
  acall$tag
)
afamily <- iteratelist(afamily, value = "fname")
data <- list( name = "commoncropname"
              , verb = "get"
              , version = "1.3"
              , tag = acall$tag
              , summary = acall$summary
              , params = params
              , afamily = afamily
              , aparam = aparam
              , description = ades

)

writeLines(whisker.render(template, data), "./output.R")

