##' @title Opening the Catalogue of Life China checklist web pages with query
##' @description  Query with the accceptedName,scientificName,chineseName and commonName, returning the web pages that meets the criteria.
##' @rdname open_URL
##' @name open_URL
##' @param query \code{string} the accceptedName,scientificName,chineseName or commonName.
##' @param name \code{string} name = c("accceptedName","scientificName","chineseName","commonName"),the default value is "accceptedName".
##' @param language \code{string} currently only two languages are supported: Chinese and English,language=c("en","zh"), the default value is "en".
##' @author Liuyong Ding
##' @details Visit the website \url{http://sp2000.org.cn/pageservices/document} for more details.
##' @importFrom utils browseURL
##' @examples
##'\donttest{
##' open_URL(query = "Anguilla marmorata",name = "scientificName",language = 'en')
##' open_URL(query = "Anguilla marmorata",name = "scientificName",language = 'zh')
##' }
##' @export
open_URL <- function(query = NULL,name = "accceptedName",language = 'en') {
  name <- match.arg(name, c("accceptedName","scientificName","chineseName","commonName"))
  language <- match.arg(language, c("en","zh"))
  url <- paste0('http://www.sp2000.org.cn/pageservices/species/', name,'/',query ,'/', language)
  browseURL(url)
  invisible(url)
  print(url)
}





