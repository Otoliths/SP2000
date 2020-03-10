#' @title Download Catalogue of Life China: Annual Checklist
#' @description Organized by the Biodiversity Committee of Chinese Academy of Sciences, catalogue of Life China 2019 Annual Checklist edition has been compiled by Species 2000 China Node. It is funded by the Strategic Priority Research Program of the Chinese Academy of Sciences (Grant No. XDA19050202). It is released at Beijing on May, 2019.
#' @rdname download_CoLChina
#' @name download_CoLChina
#' @param version \code{integer} Release version of annual checklist,the default value is 2019
#' @param format \code{character} Release version of format,the default value is zip
#' @param download \code{logic} TRUE or FALSE,the default value is FALSE
#' @return URL
#' @author Liuyong Ding
#' @details Visit the website \url{http://col.especies.cn/download} for more details
#' @importFrom utils download.file
#' @importFrom utils browseURL
#' @examples
#' \dontrun{
#' download_CoLChina(version = "2019",format = "zip",download = TRUE)
#' }
#' @export
download_CoLChina <- function(version = "2019", format = "zip" ,download = FALSE) {
  cat(sprintf("last Update: %s",Sys.Date()),sep = "\n")
  version <- match.arg(version, 2018:2019)
  format <- match.arg(format, c("zip", "iso"))
  url <- paste0('http://col.especies.cn/CoL/CoLChina',version, '.',format)
  if (download) {
    outfile <- sub(".*/", "", url)
    download.file(url, destfile = outfile)
    cat(sprintf("Save the path: %s",getwd()),sep = "\n")
  }
  browseURL("http://col.especies.cn/download")
  invisible(url)
}
