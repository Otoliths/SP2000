#' @title Query details of species in China Animal Scientific Database
#' @description Query the description type information based on the species name and database name.
#' @rdname zoology_description
#' @param query \code{string} The string to query for scientific names.
#' @param dbname \code{integer} There is one required parameter, a single numeric that indicates which China animal scientific database to use. Details in \code{\link{zoology_dbase_name}}  for the list of available databases.
#' @return description type information
#' @author Liuyong Ding \email{ly_ding@126.com}
#' @details Visit the website \url{http://zoology.especies.cn} for more details.
#' @importFrom jsonlite fromJSON
#' @importFrom urltools url_encode
#' @examples
#' \dontrun{
#' ##Set your key
#' set_search_key("your apiKey",db = "zoology")
#'
#' ##Query description type information of Chinese Bird Database
#' zoology_description_type(query = "Aix galericulata",dbname = 4)
#' }
#' @export

zoology_description_type <- function(query, dbname) {
  if (!is_query_key_set()){
    cat("*******************************************************************************\n")
    cat("** You need to apply for the apiKey from http://zoology.especies.cn/database/api   ** \n** to run all zoology_* functions, and then run set_search_key('your apiKey', db = 'zoology') **")
    cat("\n*******************************************************************************\n")
  }else{
    query <- urltools::url_encode(query)
    dbase_name <- jsonlite::fromJSON(paste0('http://zoology.especies.cn/api/v1/dbaseName?apiKey=',Sys.getenv('zoology_apiKey')))
    dbname <- dbase_name[["data"]][["dbaseName"]][dbname]
    dbname <- urltools::url_encode(dbname)
    url <- paste0('http://zoology.especies.cn/api/v1/descriptionType?scientificName=',query,'&dbaseName=',dbname, '&apiKey=',Sys.getenv('zoology_apiKey'))
    x <- jsonlite::fromJSON(url,flatten = TRUE)
    switch(as.character(x$code),
           "200" = {
             cat(sprintf("Request returned successfully!!!"), sep = "\n")
             cat(sprintf("last Update: %s",Sys.Date()),sep = "\n")},
           "1100" = {cat("Error request - No database information available")},
           "1500" = {cat("Error request - No result for this species your query")},
           "402" = {cat("Please note that API key are allowed 2000 requests per 24 hour period!!! \n To request an increase in the daily API request limit, you can visit at http://zoology.especies.cn/user/info")},
           "401" = {cat("Request return failed!!! \n The apikey is incorrect. Please reenter it!!! \n You need to apply for the apiKey from http://zoology.especies.cn/database/api \n Running set_search_key('your apiKey') to run all zoology_* functions" )})
    if (as.character(x$code) == 200){
      #cat(sprintf("China Animal Scientific Database - Found: %s",x$data$sum), sep = "\n")
      #cat(sprintf("[%s]%s",1:length(x$data$dbaseName),x$data$desType), sep = "\n")
      s <- x[["data"]][["desType"]]
      type <- data.frame(id = names(s), type = diag(as.matrix(s)))
      return(type)
    }
  }
}
