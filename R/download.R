#' download Catalogue of Life China
#'
#' @title download
#' @param year \code{integer} since 2018
#' @param download \code{logic} TRUE or FALSE,the default value is FALSE
#' @return url
#' @author Liuyong Ding
#' @details Visit the website \url{http://col.especies.cn/download} for more details
#' @examples
#' \dontrun{
#' download(year=2019,download=F)
#' }
#' @export
download <- function(year=NULL, download=FALSE) {
  url <- paste0('http://col.especies.cn/CoL/CoLChina', year, '.zip')
  print(Sys.time())
  if (download) {
    outfile <- sub(".*/", "", url)
    download.file(url, destfile = outfile)
  }
  utils::browseURL("http://col.especies.cn/download")
  invisible(url)
}

