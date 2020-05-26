##' @title Search Catalogue of Life China checklist
##' @description Get checklist via species or infraspecies ID.
##' @rdname search_checklist
##' @name search_checklist
##' @param query \code{string} single or more query, see [search_familyid()] and [search_taxonid()] for more details.
##' @param mc.cores The number of cores to use, i.e. at most how many child processes will be run simultaneously. The option is initialized from environment variable MC_CORES if set. Must be at least one, and parallelization requires at least two cores,see [mclapply()] for details.
##' @return Catalogue of Life China list(s)
##' @author Liuyong Ding
##' @details Visit the website \url{http://sp2000.org.cn/api/document} for more details.
##' @importFrom pbmcapply pbmclapply
##' @importFrom jsonlite fromJSON
##' @examples
##' \dontrun{
##' search_checklist(query="025397f9-9891-40a7-b90b-5a61f9c7b597")
##'
##' queries <- c("025397f9-9891-40a7-b90b-5a61f9c7b597","04c59ee8-4b48-4095-be0d-663485463f21")
##' search_checklist(query = queries)
##' }
##' @export

search_checklist <- function(query = NULL,mc.cores = 2){
  cat(sprintf("last Update: %s",Sys.Date()),sep = "\n")
  if (.Platform$OS.type == "windows") {
    mc.cores = 1
  }
  if (is_search_key_set()){
  if(length(query) == 1){
    x <- species(query)
  } else {
    x <- pbmclapply(query,species,mc.cores = mc.cores)
  }
  return(x)
  }else {
    cat("*******************************************************************************\n")
    cat("** You need to apply for the apiKey from http://sp2000.org.cn/api/document   ** \n** to run all search_* functions, and then run set_search_key('your apiKey') **")
    cat("\n*******************************************************************************\n")
  }
}

species <- function(query = NULL) {
  if (is_search_key_set()){
  url <- paste0('http://www.sp2000.org.cn/api/taxon/species/taxonID/', query, '/', Sys.getenv("sp2000_apiKey"))
  x <- fromJSON(url,flatten = TRUE)
  x$downloadDate <- as.Date(Sys.time())
  return(x)
  }else {
    cat("You need to apply for the apiKey from http://sp2000.org.cn/api/document \n to run all search_* functions, and then run set_search_key('your apiKey')")
  }
}

