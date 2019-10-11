#' brapi_commoncropnames
#'
#' Get the Common Crop Names
#'
#' @param page ; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize ; required: FALSE; The size of the pages to be returned. Default is `1000`.
#' @param Authorization ; required: FALSE; HTTP HEADER - Token used for Authorization 
# &lt;strong&gt;Bearer {token_string} &lt;/strong&gt;
#'
#' @details List the common crop names for the crops available in a database server. 
#' This call is **required** for multi-crop systems where data from multiple crops may be stored in the same database server. A distinct database server is defined by everything in the URL before &quot;/brapi/v1&quot;, including host name and base path.  
#' This call is recommended for single crop systems to be compatible with multi-crop clients. For a single crop system the response should contain an array with exactly 1 element. 
#' The common crop name can be used as a search parameter for Programs, Studies, and Germplasm.
#' test-server.brapi.org/brapi/v1/commonCropNames
#'
#' @return data.frame
#'
#' @family brapi_1.3
#' @family Crops
#'
#' @author brapir generator package
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/1.3#/Crops/get_commoncropnames }{SwaggerHub}
#'
#' @example
#'
#' @export
brapi_commoncropnames <- function(page = '', pageSize = '', Authorization = '') {
# check network
# get url
# get respones
# convert response to table
# show metadata
# return result table
out <- "x"
class(out) <- "brapi_commoncropnames"
}
