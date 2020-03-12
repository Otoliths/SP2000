##' @title Search checklist
##' @description Get checklist via species or infraspecies ID
##' @rdname search_checklist
##' @name search_checklist
##' @param query \code{string} single or more query
##' @param mc.cores The number of cores to use, i.e. at most how many child processes will be run simultaneously. The option is initialized from environment variable MC_CORES if set. Must be at least one, and parallelization requires at least two cores.
##' @param apiKey \code{string} You need to apply for the apiKey from \url{http://sp2000.org.cn/api/document} to run this function
##' @return lists
##' @author Liuyong Ding
##' @details Visit the website \url{http://sp2000.org.cn/api/document} for more details
##' @importFrom pbmcapply pbmclapply
##' @importFrom jsonlite fromJSON
##' @examples
##' \dontrun{
##' apiKey <- "your apiKey"
##' search_checklist(query="025397f9-9891-40a7-b90b-5a61f9c7b597",apiKey = apiKey)
##'
##' queries <- c("025397f9-9891-40a7-b90b-5a61f9c7b597","04c59ee8-4b48-4095-be0d-663485463f21")
##' search_checklist(query = queries,apiKey = apiKey)
##' }
##' @export

search_checklist <- function(query = NULL,mc.cores = 2,apiKey = NULL){
  cat(sprintf("last Update: %s",Sys.Date()),sep = "\n")
  if (.Platform$OS.type == "windows") {
    mc.cores = 1
  }
  if(length(query) == 1){
    x <- species(query,apiKey)
  } else {
    x <- pbmclapply(query,species,apiKey,mc.cores = mc.cores)
  }
  return(x)
}

species <- function(query = NULL,apiKey = NULL) {
  url <- paste0('http://www.sp2000.org.cn/api/taxon/species/taxonID/', query, '/', apiKey)
  x <- fromJSON(url,flatten = TRUE)
  x$downloadDate <- as.Date(Sys.time())
  return(x)
}

