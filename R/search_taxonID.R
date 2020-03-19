##' @title Search taxon IDs
##' @description Search taxon IDs via familyID ,scientificName and commonName.
##' @rdname search_taxonID
##' @name search_taxonID
##' @param query \code{string} familyID ,scientificName or commonName.
##' @param name \code{character} name=c("familyID","scientificName","commonName"),the default value is "scientificName".
##' @param mc.cores The number of cores to use, i.e. at most how many child processes will be run simultaneously. The option is initialized from environment variable MC_CORES if set. Must be at least one, and parallelization requires at least two cores,see [mclapply] for details.
##' @param apiKey \code{string} You need to apply for the apiKey from \url{http://sp2000.org.cn/api/document} to run this function.
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
##' @details Visit the website \url{http://sp2000.org.cn/api/document} for more details.
##' @examples
#' \dontrun{
#' apiKey <- "your apiKey"
#' search_taxonID(query = "Uncia uncia",name = "scientificName",apiKey = apiKey)
#' queries <- c("Anguilla marmorata","Uncia uncia")
#' search_taxonID(query = queries,name = "scientificName",apiKey = apiKey)
#'
#' x1 <- search_familyID(query = "Cyprinidae",apiKey = apiKey)
#' x2 <- search_taxonID(query = x1$familyIDs,name = "familyID",apiKey = apiKey)
#' x2$family <- rep(x1$family,dim(x2)[1])
#' }
##' @export

search_taxonID <- function(query = NULL,name = 'scientificName',mc.cores = 2,apiKey = NULL) {
  cat(sprintf("last Update: %s",Sys.Date()),sep = "\n")
  name <- match.arg(name, c("familyID","scientificName","commonName"))
  if (.Platform$OS.type == "windows") {
    mc.cores = 1
  }
  if(length(query) == 1){
    if(name == 'familyID'){
      x <- taxonID(query,name,apiKey)
      x <- tibble(familyID = query,taxonIDs = x)
      x$download.date <- as.Date(Sys.time())
    }
    if(name == 'scientificName'){
      x <- taxonID(query,name,apiKey)
      x <- tibble(scientificName = query,taxonIDs = x)
      x$download.date <- as.Date(Sys.time())
    }
    if(name == 'commonName'){
      x <- taxonID(query,name,apiKey)
      x <- tibble(commonName = query,taxonIDs = x)
      x$download.date <- as.Date(Sys.time())
    }
  } else {
    if(name == 'familyID'){
      x <- pbmclapply(query,taxonID,name,apiKey,mc.cores = mc.cores)
      x <- list.rbind(x)[,1]
      x <- tibble(familyID = query,taxonIDs = x)
      x$download.date <- as.Date(Sys.time())
    }
    if(name == 'scientificName'){
      x <- pbmclapply(query,taxonID,name,apiKey,mc.cores = mc.cores)
      x <- list.rbind(x)[,1]
      x <- tibble(scientificName = query,taxonIDs = x)
      x$download.date <- as.Date(Sys.time())
    }
    if(name == 'commonName'){
      x <- pbmclapply(query,taxonID,name,apiKey,mc.cores = mc.cores)
      x <- list.rbind(x)[,1]
      x <- tibble(commonName = query,taxonIDs = x)
      x$download.date <- as.Date(Sys.time())
    }
  }
  return(x)
}

taxonID <- function(query = NULL,name = 'scientificName',apiKey = NULL) {
  name <- match.arg(name, c("familyID","scientificName","commonName"))
  if (name == 'scientificName') {
    query <- gsub(" ","%20",query)
    url <- paste0('http://www.sp2000.org.cn/api/taxon/', name ,'/taxonID/', query, '/', apiKey)
    x <- fromJSON(url)
    x <- x$taxonIDs
  } else {
    url <- paste0('http://www.sp2000.org.cn/api/taxon/', name ,'/taxonID/', query, '/', apiKey)
    x <- fromJSON(url)
    x <- x$taxonIDs
  }
  return(x)
}
