##' @title Search taxon IDs
##' @description Search taxon IDs via familyID ,scientificName and commonName.
##' @rdname search_taxonid
##' @name search_taxonid
##' @param query \code{string} familyID ,scientificName or commonName.
##' @param name \code{character} name=c("familyID","scientificName","commonName"),the default value is "scientificName".
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
#' \dontrun{
#' search_taxonid(query = "Uncia uncia",name = "scientificName")
#' queries <- c("Anguilla marmorata","Uncia uncia")
#' search_taxonid(query = queries,name = "scientificName")
#'
#' x1 <- search_familyid(query = "Cyprinidae")
#' x2 <- search_taxonid(query = x1$familyIDs,name = "familyID")
#' x2$family <- rep(x1$family,dim(x2)[1])
#' }
##' @export

search_taxonid <- function(query = NULL,name = 'scientificName',mc.cores = 2) {
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
