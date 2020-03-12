##' @title Search family IDs
##' @description Search family IDs via family name, supports Latin and Chinese names
##' @rdname search_familyID
##' @name search_familyID
##' @param query \code{character} Family name, or part of family name, supports Latin and Chinese names
##' @param mc.cores The number of cores to use, i.e. at most how many child processes will be run simultaneously. The option is initialized from environment variable MC_CORES if set. Must be at least one, and parallelization requires at least two cores.
##' @param apiKey \code{string} You need to apply for the apiKey from \url{http://sp2000.org.cn/api/document} to run this function
##' @return dataframe
##' @author Liuyong Ding
##' @importFrom jsonlite fromJSON
##' @importFrom rlist list.rbind
##' @importFrom tibble tibble
##' @importFrom pbmcapply pbmclapply
##' @details Visit the website \url{http://sp2000.org.cn/api/document} for more details
##' @examples
#' \dontrun{
#' apiKey <- "your apiKey"
#' search_familyID(query = "Cyprinidae",apiKey = apiKey)
#' queries <- c("Rosaceae","Cyprinidae")
#' search_familyID(query = queries,apiKey = apiKey)
#' }
##' @export
search_familyID <- function(query = NULL,mc.cores = 2,apiKey=NULL) {
  cat(sprintf("last Update: %s",Sys.Date()),sep = "\n")
  if (.Platform$OS.type == "windows") {
    mc.cores = 1
  }
  if(length(query) == 1){
    x <- familyID(query,apiKey)
    x <- tibble(family = query,familyIDs = x)
    x$download.date <- as.Date(Sys.time())

  } else {
    x <- pbmclapply(query,familyID,apiKey)
    x <- list.rbind(x)[,1]
    x <- tibble(family = query,familyIDs = x,mc.cores = mc.cores)
    x$download.date <- as.Date(Sys.time())
  }
  return(x)
}

familyID <- function(query = NULL,apiKey = NULL) {
  query <- as.character(query)
  url <- paste0('http://www.sp2000.org.cn/api/family/familyName/familyID/', query, '/', apiKey)
  x <- fromJSON(url,flatten = TRUE)
  x <- x$fids
  return(x)
}

