##' Query with the accceptedName,scientificName,chineseName and commonName", returning the webpage that meets the criteria
##'
##' @title Opening the webpage with query
##' @rdname openurl
##' @name openurl
##' @param query \code{string} the accceptedName,scientificName,chineseName or commonName
##' @param name \code{string} name=c("accceptedName","scientificName","chineseName","commonName"),the default value is "accceptedName"
##' @param language string currently only two languages are supported: Chinese and English,language=c("en","zh"), the default value is "en"
##' @author Liuyong Ding
##' @details Visit the website \url{http://col.especies.cn/pageservices/document} for more details
##' @examples
##'\dontrun{
##' open(query="Ailuropoda melanoleuca")
##' }
##' @export
openurl <- function(query=NULL,name="accceptedName",language='en') {
  url <- paste0('http://www.sp2000.org.cn/pageservices/species/', name,'/',query ,'/', language)
  utils::browseURL(url)
  invisible(url)
}





