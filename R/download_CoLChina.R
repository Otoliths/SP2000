#' @title Download 'Catalogue of Life China': Annual Checklist
#' @description Organized by the Biodiversity Committee of Chinese Academy of Sciences, 'Catalogue of Life China' 2019 Annual Checklist edition has been compiled by 'Species 2000' China Node. It is funded by the Strategic Priority Research Program of the Chinese Academy of Sciences (Grant No. XDA19050202). It is released at Beijing on May, 2019.
#' @rdname download_CoLChina
#' @name download_CoLChina
#' @param version \code{integer} Release version of annual checklist,the default value is 2019
#' @param format \code{character} Release version of format,the default value is zip
#' @param download \code{logic} TRUE or FALSE,the default value is FALSE
#' @param dir a non-empty character vector giving the directory name by user,the default value is dir = tempdir(),see [tempdir()] for details
#' @return URL
#' @author Liuyong Ding
#' @details Visit the website \url{http://sp2000.org.cn/download} for more details
#' @importFrom utils download.file
#' @importFrom utils browseURL
#' @examples
#' \donttest{
#' dir <- tempdir()
#' download_CoLChina(version = "2019",format = "zip",download = TRUE,dir = dir)
#' }
#' @export
download_CoLChina <- function(version = "2019", format = "zip" ,download = FALSE,dir = tempdir()) {
  cat(sprintf("Download the date: %s",Sys.Date()),sep = "\n")
  version <- match.arg(version, 2018:2019)
  format <- match.arg(format, c("zip", "iso"))
  url <- paste0('http://sp2000.org.cn/CoL/CoLChina',version, '.',format)
  if (download) {
    outfile <- sub(".*/", "", url)
    download.file(url, file.path(dir,outfile))
    cat(sprintf("Download path: %s",getwd()),sep = "\n")
  }
  browseURL("http://sp2000.org.cn/download")
  invisible(url)
}
