##' @title Search family IDs
##' @description Search family IDs via family name, supports Latin and Chinese names.
##' @rdname search_familyid
##' @name search_familyid
##' @param query \code{character} Family name, or part of family name, supports Latin and Chinese names.
##' @param mc.cores The number of cores to use, i.e. at most how many child processes will be run simultaneously. The option is initialized from environment variable MC_CORES if set. Must be at least one, and parallelization requires at least two cores,see [mclapply()] for details.
##' @return dataframe
##' @author Liuyong Ding
##' @importFrom jsonlite fromJSON
##' @importFrom rlist list.rbind
##' @importFrom tibble tibble
##' @importFrom pbmcapply pbmclapply
##' @details Visit the website \url{http://sp2000.org.cn/api/document} for more details
##' @examples
#' \dontrun{
#' search_familyid(query = "Cyprinidae")
#' queries <- c("Rosaceae","Cyprinidae")
#' search_familyid(query = queries)
#' }
##' @export
search_familyid <- function(query = NULL,mc.cores = 2) {
  cat(sprintf("last Update: %s",Sys.Date()),sep = "\n")
  if (.Platform$OS.type == "windows") {
    mc.cores = 1
  }
if (is_search_key_set()){
  if(length(query) == 1){
    x <- tibble(family = query,familyIDs = familyID(query))
    x$download.date <- as.Date(Sys.time())
  } else {
    x <- tibble(family = query,familyIDs = list.rbind(pbmclapply(query,familyID))[,1])
    x$download.date <- as.Date(Sys.time())
  }
  return(x)
  } else {
    cat("*******************************************************************************\n")
    cat("** You need to apply for the apiKey from http://sp2000.org.cn/api/document   ** \n** to run all search_* functions, and then run set_search_key('your apiKey') **")
    cat("\n*******************************************************************************\n")
  }
}

familyID <- function(query = NULL,...) {
  query <- as.character(query)
  if (is_search_key_set()){
    api_key <- Sys.getenv('sp2000_apiKey')
    url <- paste0('http://www.sp2000.org.cn/api/family/familyName/familyID/', query, '/', api_key)
    x <- fromJSON(url,flatten = TRUE)
    x <- x$fids
  return(x)
  } else {
    cat("You need to apply for the apiKey from http://sp2000.org.cn/api/document \n to run all search_* functions, and then run set_search_key('your apiKey')")
  }
}
