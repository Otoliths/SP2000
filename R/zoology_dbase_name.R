#' @title Query details of species in China Animal Scientific Database
#' @description Query the database name and return a collection of names for all databases.
#' @rdname zoology_dbase_name
#' @importFrom jsonlite fromJSON
#' @format China Animal Scientific Database
#' \describe{
#' \item{1}{Chinese zoology database}
#' \item{2}{China Animal Map Database}
#' \item{3}{China Economic Animal Database}
#' \item{4}{Chinese Bird Database}
#' \item{5}{Chinese Mammal Database}
#' \item{6}{China Butterfly Database}
#' \item{7}{Chinese Bee Database}
#' \item{8}{China Inland Water Fish Database}
#' \item{9}{Chinese Amphibian Database}
#' \item{10}{Chinese Reptile database}
#' \item{...}{allow additional more databases to be used}
#' }
#' @return A collection of names for all China animal scientific databases
#' @details Visit the website \url{http://zoology.especies.cn} for more details.
#' @author Liuyong Ding \email{ly_ding@126.com}
#' @author Ke Yang \email{ydyangke@163.com}
#' @references \url{http://zoology.especies.cn}
#' @examples
#' \dontrun{
#' ##Set your key
#' set_search_key("your apiKey",db = "zoology")
#'
#' #Query China Animal Scientific Database lists
#' zoology_dbase_name()
#' }
#' @export
zoology_dbase_name <- function() {
  if (!is_query_key_set()){
    cat("*******************************************************************************\n")
    cat("** You need to apply for the apiKey from http://zoology.especies.cn/database/api   ** \n** to run all zoology_* functions, and then run set_search_key('your apiKey', db = 'zoology') **")
    cat("\n*******************************************************************************\n")
  }else{
    url <- paste0('http://zoology.especies.cn/api/v1/dbaseName?apiKey=',Sys.getenv('zoology_apiKey'))
    x <- jsonlite::fromJSON(url)
    switch(as.character(x$code),
           "200" = {
             cat(sprintf("Request returned successfully!!!"), sep = "\n")
             cat(sprintf("last Update: %s",Sys.Date()),sep = "\n")
           },
           "1100" = {cat("Error request - No database information available")},
           "402" = {cat("Please note that API key are allowed 2000 requests per 24 hour period!!! \n To request an increase in the daily API request limit, you can visit at http://zoology.especies.cn/user/info")},
           "401" = {cat("Request return failed!!! \n The apikey is incorrect. Please reenter it!!! \n You need to apply for the apiKey from http://zoology.especies.cn/database/api \n Running set_search_key('your apiKey') to run all zoology_* functions" )})
    if (as.character(x$code) == 200){
      cat(sprintf("China Animal Scientific Database - Found: %s",x$data$sum), sep = "\n")
      cat(sprintf("%01d:%s",1:length(x$data$dbaseName),x$data$dbaseName), sep = "\n")
      #return(x[["data"]][["dbaseName"]])
    }
  }
}
