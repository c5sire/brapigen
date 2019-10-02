### brapigen package needs to be build!
brapi <- yaml::read_yaml(system.file("openapi/brapi_1.2.yaml", package = "brapigen"))

### load required packages
library(magrittr) # usethis::use_package(package = "magrittr")
library(whisker)  # usethis::use_package(package = "whisker")

### create directory infrastructure
dir_b <- "../brapir"

unlink(x = dir_b, recursive = TRUE, force = TRUE)
list.files(path = dir_b, recursive = TRUE)

dir.create(path = dir_b)
dir_r <- file.path(dir_b, "R")
dir.create(path = dir_r)

### copy files
file.copy(from = "inst/templates/zzz.R", to = file.path(dir_r, "zzz.R"))

### Descriptionlib
get_call_names <- function(brapi) {
  brapi$paths %>% names
}

get_call <- function(brapi, id_name) {
  brapi_names <- get_call_names(brapi)
  ## usethis::use_package(package = "stringr")
  nme <- brapi_names[stringr::str_detect(string = brapi_names, pattern = id_name)]
  brapi$paths[nme][[1]]$get
}

acall <- get_call(brapi = brapi, id_name = "common")
ades <- stringr::str_replace_all(string = acall$description,
                                 pattern =  "\\n\\n",
                                 replacement =  "\n#' ")

template <- readLines(con = "inst/templates/function_GET.mst")

get_param_vector <- function(acall) {
  n <- length(acall$parameters)
  res <- character(2)
  for (i in 1:n) {
    p <- acall$parameters[[i]]
    res[i] <- paste0(p$name, " ",
                     p$type, "; required: ",
                     p$required, "; ",
                     p$description)
  }
  return(res)
}

aparam <- get_param_vector(acall = acall)
aparam <- iteratelist(x = aparam, value = "pname")

get_param_string <- function(acall) {
  n <- length(acall$parameters)
  res <- character(n)
  for (i in 1:n) {
    p <- acall$parameters[[i]]$name
    res[i] <- paste0(p, " = ''")
  }
  res <- paste(res, collapse = ", ")
  return(res)
}

params <- get_param_string(acall = acall)

afamily <- c(
  "brapi_1.3",
  acall$tags
)

afamily <- iteratelist(afamily, value = "fname")

data <- list(name = "commoncropnames",
             verb = "get",
             version = "1.3",
             tag = acall$tags,
             summary = acall$summary,
             params = params,
             afamily = afamily,
             aparam = aparam,
             description = ades)

writeLines(whisker.render(template, data), "./output.R")

