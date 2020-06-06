##' @title Search taxon IDs
##' @description Search taxon IDs via familyID ,scientificName and commonName.
##' @rdname search_taxon_id
##' @name search_taxon_id
##' @param query \code{string} familyID ,scientificName or commonName.
##' @param name \code{character} name = c("familyID","scientificName","commonName"),the default value is "scientificName".
##' @param mc.cores The number of cores to use, i.e. at most how many child processes will be run simultaneously. The option is initialized from environment variable MC_CORES if set. Must be at least one, and parallelization requires at least two cores,see [mclapply] for details.
##' @importFrom jsonlite fromJSON
##' @importFrom rlist list.rbind
##' @importFrom tibble tibble
##' @importFrom pbmcapply pbmclapply
##' @format query:
##' \describe{
##' \item{taxonIDs}{an array of species' ids}
##' \item{familyID}{family ID, unique value}
##' \item{scientificName}{the scientific name, or part of the scientific name, supports Latin names and Chinese}
##' \item{commonName}{common name, or part of common name}
##' }
##' @return dataframe
##' @author Liuyong Ding
##' @details Visit the website \url{http://sp2000.org.cn/api/document} for more details
##' @examples
##' \dontrun{
##' ##Set your key
##' set_search_key <- "your apiKey"
##'
##' ##Search family IDs via family name
##' familyid <- search_family_id(query = "Anguillidae")
##'
##' ##Search taxon IDs via familyID
##' taxonid <- search_taxon_id(query = familyid$familyIDs,name = "familyID")
##'
##' ##Search taxon IDs via scientificName
##' taxonid <- search_taxon_id(query = c("Anguilla marmorata","Anguilla japonica",
##'                                      "Anguilla bicolor","Anguilla nebulosa",
##'                                      "Anguilla luzonensis"),
##'                                      name = "scientificName")
##'
##' }
##' @export

search_taxon_id <- function(query = NULL,name = 'scientificName',mc.cores = 2) {
  cat(sprintf("last Update: %s",Sys.Date()),sep = "\n")
  name <- match.arg(name, c("familyID","scientificName","commonName"))
  if(.Platform$OS.type == "windows") {
    mc.cores = 1
  }
if (is_search_key_set()){
  if(length(query) == 1){
    if(name == 'familyID'){
      x <- taxonID(query,name)
      x <- tibble(familyID = query,taxonIDs = x)
      x$download.date <- as.Date(Sys.time())
    }
    if(name == 'scientificName'){
      x <- taxonID(query,name)
      x <- tibble(scientificName = query,taxonIDs = x)
      x$download.date <- as.Date(Sys.time())
    }
    if(name == 'commonName'){
      x <- taxonID(query,name)
      x <- tibble(commonName = query,taxonIDs = x)
      x$download.date <- as.Date(Sys.time())
    }
  } else {
    if(name == 'familyID'){
      x <- pbmclapply(query,taxonID,name,mc.cores = mc.cores)
      x <- list.rbind(x)[,1]
      x <- tibble(familyID = query,taxonIDs = x)
      x$download.date <- as.Date(Sys.time())
    }
    if(name == 'scientificName'){
      x <- pbmclapply(query,taxonID,name,mc.cores = mc.cores)
      x <- list.rbind(x)[,1]
      x <- tibble(scientificName = query,taxonIDs = x)
      x$download.date <- as.Date(Sys.time())
    }
    if(name == 'commonName'){
      x <- pbmclapply(query,taxonID,name,mc.cores = mc.cores)
      x <- list.rbind(x)[,1]
      x <- tibble(commonName = query,taxonIDs = x)
      x$download.date <- as.Date(Sys.time())
    }
  }
  return(x)
  }else {
    cat("*******************************************************************************\n")
    cat("** You need to apply for the apiKey from http://sp2000.org.cn/api/document   ** \n** to run all search_* functions, and then run set_search_key('your apiKey') **")
    cat("\n*******************************************************************************\n")
  }
}

taxonID <- function(query = NULL,name = 'scientificName') {
  name <- match.arg(name, c("familyID","scientificName","commonName"))
  if (is_search_key_set()){
      if (name == 'scientificName') {
         query <- gsub(" ","%20",query)
         url <- paste0('http://www.sp2000.org.cn/api/taxon/', name ,'/taxonID/', query, '/',  Sys.getenv("sp2000_apiKey"))
         x <- fromJSON(url)
         x <- x$taxonIDs
      } else {
        url <- paste0('http://www.sp2000.org.cn/api/taxon/', name ,'/taxonID/', query, '/', Sys.getenv("sp2000_apiKey"))
        x <- fromJSON(url)
        x <- x$taxonIDs
             }
      return(x)
  }
}
