##' @title Search family IDs
##' @description Search family IDs via family name, supports Latin and Chinese names.
##' @rdname search_family_id
##' @name search_family_id
##' @param query \code{character} One and more queries,support Family name, or part of family name, supports Latin and Chinese names.
##' @param start \code{integer} Record number to start at. If omitted, the results are returned from the first record (start=1). Use in combination with limit to page through results. Note that we do the paging internally for you, but you can manually set the start parameter.
##' @param limit \code{integer} Number of records to return, the default value is 20.
##' @param mc.cores The number of cores to use, i.e. at most how many child processes will be run simultaneously. The option is initialized from environment variable MC_CORES if set. Must be at least one, and parallelization requires at least two cores,see \code{\link{mclapply}} for details.
##' @return dataframe
##' @author Liuyong Ding \email{ly_ding@126.com}
##' @importFrom jsonlite fromJSON
##' @importFrom rlist list.rbind
##' @importFrom tibble as_tibble
##' @importFrom pbmcapply pbmclapply
##' @importFrom purrr transpose
##' @details Visit the website \url{http://sp2000.org.cn/api/document} for more details
##' @examples
##' \dontrun{
##' ##Set your key
##' set_search_key("your apiKey",db = "sp2000")
##'
##' ##Search family IDs via family name
##' familyid <- search_family_id(query = "Anguillidae")
##' }
##' @export

#********************API V2********************
search_family_id <- function(query = NULL, start = 1, limit = 20, mc.cores = 2) {
  if (!is_search_key_set()){
    cat("*******************************************************************************\n")
    cat("** You need to apply for the apiKey from http://sp2000.org.cn/api/document   ** \n** to run all search_* functions, and then run set_search_key('your apiKey') **")
    cat("\n*******************************************************************************\n")
  }else{
    x1 <- familyID(query[1],page = start)
    switch(as.character(x1$code),
           "200" = {
             cat(sprintf("Request returned successfully!!!"), sep = "\n")
             cat(sprintf("Download  date: %s", Sys.Date()), sep = "\n")
           },
           "400" = {cat("Error request - the parameter query is not valid")},
           "401" = {cat("Request return failed!!! \n The apikey is incorrect. Please reenter it!!! \n You need to apply for the apiKey from http://sp2000.org.cn/api/document \n Running set_search_key('your apiKey') to run all search_* functions" )})
    if (.Platform$OS.type == "windows") {
      mc.cores = 1
    }
    if (as.character(x1$code) == 200){
      data <- pbmclapply(query,mc.cores = mc.cores,function(queries){
        x <- familyID(query = queries,page = start)
        x$data$familes$download_date <- as.Date(Sys.time())
        x$data$familes <- as_tibble(x$data$familes)
        x <- list(meta = list(code=x$code,limit=x$data$limit,count=x$data$count,page=x$data$page,message=x$message),
                  data = x$data$familes)
      })
      names(data)<- query
      # cat(sprintf("Records - Found: %s, Returned: %s",found(data),returned(data)), sep = "\n")
      # cat(sprintf("Queries: %s", paste0(queries(query,data), collapse = ", ")),sep = "\n")
      return(data)
    }
  }

}

familyID <- function(query = NULL,page,...) {
  query <- as.character(query)
  if (is_search_key_set()){
  url <- paste0("http://www.sp2000.org.cn/api/v2/getFamiliesByFamilyName?apiKey=",Sys.getenv('sp2000_apiKey'),"&familyName=", query,'&',"page=",page)
  x <- fromJSON(url,flatten = TRUE)
  }
}

# queries <- function(query,x){
#   if (length(query) > 3){
#     paste0(query[1:3],"(",sapply(1:3,function(i)dim(x[[query[3]]][["data"]])[1]),")")
#   }else{
#     paste0(query,"(",sapply(1:length(query),function(i)dim(x[[query[i]]][["data"]])[1]),")")
#   }
# }
#
# found <- function(x){
#   sum(unlist(list.extract(transpose(transpose(x)[["meta"]]), "count")))
# }
#
# returned <- function(x){
#   sum(unlist(list.extract(transpose(transpose(x)[["meta"]]), "page")))
# }

