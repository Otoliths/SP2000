#' @title Query details of species in China Animal Scientific Database
#' @description Query the description information based on the species name, database name, and description type.
#' @rdname zoology_description
#' @param query \code{string} The string to query for scientific names.
#' @param dbname \code{integer} There is one required parameter, a single numeric that indicates which China animal scientific database to use. Details in \code{\link{zoology_dbase_name}}  for the list of available databases.
#' @param destype \code{integer} There is one required parameter, a single numeric that indicates which description type information to use. Details in \code{\link{zoology_description}}  for the list of available description type information based on the species name and database name.
#' @return details of species in China Animal Scientific Database
#' @author Liuyong Ding \email{ly_ding@126.com}
#' @details Visit the website \url{http://zoology.especies.cn} for more details.
#' @importFrom jsonlite fromJSON
#' @importFrom urltools url_encode
#' @examples
#' \dontrun{
#' ##Set your key
#' set_search_key("your apiKey",db = "zoology")
#'
#' ##Query details of species in Chinese Bird Database
#' zoology_description(query = "Aix galericulata",dbname = 4,destype = 209)
#' }
#' @export

zoology_description <- function(query, dbname, destype) {
  if (!is_query_key_set()){
    cat("*******************************************************************************\n")
    cat("** You need to apply for the apiKey from http://zoology.especies.cn/database/api   ** \n** to run all zoology_* functions, and then run set_search_key('your apiKey', db = 'zoology') **")
    cat("\n*******************************************************************************\n")
  }else{
    query <- urltools::url_encode(query)
    dbase_name <- jsonlite::fromJSON(paste0('http://zoology.especies.cn/api/v1/dbaseName?apiKey=',Sys.getenv('zoology_apiKey')))
    dbname <- dbase_name[["data"]][["dbaseName"]][dbname]
    if (!as.character(dbase_name$code) %in% "402"){
      dbname <- urltools::url_encode(dbname)
    }
    url <- paste0('http://zoology.especies.cn/api/v1/description?scientificName=',query,'&dbaseName=',dbname,'&descriptionType=',destype, '&apiKey=',Sys.getenv('zoology_apiKey'))
    x <- jsonlite::fromJSON(url,flatten = TRUE)
    switch(as.character(x$code),
           "200" = {
             cat(sprintf("Request returned successfully!!!"), sep = "\n")
             cat(sprintf("last Update: %s",Sys.Date()),sep = "\n")},
           "1500" = {cat("Error request - There is no such species")},
           "1502" = {cat("Error request - No database information available")},
           "402" = {cat("Please note that API key are allowed 2000 requests per 24 hour period!!! \n To request an increase in the daily API request limit, you can visit at http://zoology.especies.cn/user/info")},
           "401" = {cat("Request return failed!!! \n The apikey is incorrect. Please reenter it!!! \n You need to apply for the apiKey from http://zoology.especies.cn/database/api \n Running set_search_key('your apiKey') to run all zoology_* functions" )})
    if (as.character(x$code) == 200){
      #cat(sprintf("China Animal Scientific Database - Found: %s",x$data$sum), sep = "\n")
      #cat(sprintf("[%s]%s",1:length(x$data$dbaseName),x$data$desType), sep = "\n")
      result <- x[["data"]]
      results <- list(meta = list(scientificName = result$scientificName), data = result$DescriptionInfo)
      results <- list(results)
      names(results) <- urltools::url_decode(query)
      return(results)
    }
  }
}
