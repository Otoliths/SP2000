##' download taxon IDs via familyID ,scientificName and commonName
##'
##' @title using taxonID to download taxon IDs
##' @rdname taxonID
##' @name taxonID
##' @param query \code{string} familyID ,scientificName or commonName
##' @param name \code{string} name=c("familyID","scientificName","commonName"),the default value is "scientificName"
##' @param apiKey \code{string} You need to apply for the apiKey from \url{http://col.especies.cn/api/document} to run this function
##' @format query:
##' \describe{
##' \item{taxonIDs}{an array of species' ids}
##' \item{familyID}{family ID, unique value}
##' \item{scientificName}{the scientific name, or part of the scientific name, supports Latin names and Chinese}
##' \item{commonName}{common name, or part of common name}
##' }
##' @author Liuyong Ding
##' @details Visit the website \url{http://col.especies.cn/api/document} for more details
##' @examples
##'\dontrun{
##' taxonID(query="鳗鲡",name="commonName",apiKey="")
##'
##' query <- c("鳗鲡","裂腹鱼")
##' taxonIDs <- lapply(query,taxonID,name='commonName')
##' (taxonIDs <- purrr::transpose(taxonIDs))
##' }
##' @export

taxonID <- function(query=NULL,name='scientificName',apiKey=NULL) {
  start_time <- Sys.time()
  url <- paste0('http://www.sp2000.org.cn/api/taxon/', mame ,'/taxonID/', query, '/', apiKey)
  if (name=='scientificName') {
    utils::browseURL(url)
    invisible(url)
  }
  x <- jsonlite::fromJSON(url)
  return(x)
  print(Sys.time()-start_time)
}

packages <- c("jsonlite", "tibble","parallel","purrr","rlist","utils")
package.check <- lapply(packages, FUN = function(x) {
  if (!require(x, character.only = TRUE)) {
    install.packages(x, dependencies = TRUE, repos = "http://cran.us.r-project.org")
    library(x, character.only = TRUE)
  }
})
