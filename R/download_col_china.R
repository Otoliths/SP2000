#' @title Download 'Catalogue of Life China': Annual Checklist
#' @description  Organized by the Biodiversity Committee of Chinese Academy of Sciences (BC-CAS), Catalogue of Life China Annual Checklist edition has been compiled by Species 2000 China Node.
#' @rdname download_col_china
#' @name download_col_china
#' @param version \code{integer} Release version of annual checklist,the default value is 2020.
#' @param OS \code{character} Supported operating system,c("MacOS", "Ubuntu" ,"Windows"),the default value is "MacOS".
#' @param dir a non-empty character vector giving the directory name by user,the default value is dir = tempdir(),see \code{\link{tempdir}} for details.
#' @param method Method to be used for downloading files. Current download methods are "internal", "wininet" (Windows only) "libcurl", "wget" and "curl", and there is a value "auto", see \code{\link{download.file}} for details.
#' @return URL
#' @author Liuyong Ding \email{ly_ding@126.com}
#' @details Visit the website \url{http://sp2000.org.cn/download} for more details.
#' @importFrom utils download.file
#' @importFrom utils browseURL
#' @examples
#' \dontrun{
#' dir <- tempdir()
#' download_col_china(version = "2020",OS = "MacOS", dir = dir)
#' }
#' @export
download_col_china <- function(version = "2020", OS = "MacOS", dir = tempdir(), method) {
  cat(sprintf("Download date: %s",Sys.Date()),sep = "\n")
  version <- match.arg(version, 2018:as.integer(substr(Sys.Date(), 1, 4)))
  OS <- match.arg(OS, c("MacOS", "Ubuntu" ,"Windows"))
  if (version %in% c("2018","2019") ){
    url <- paste0('http://sp2000.org.cn/CoL/CoLChina',version, '.',"iso")
  }
  if (version == "2020" & OS == "MacOS"){
    url <- paste0('http://sp2000.org.cn/CoL/CoLChina',version,"-v20.1.12_mac_64", '.',"iso")
  }
  if (version == "2020" & OS == "Ubuntu"){
    url <- paste0('http://sp2000.org.cn/CoL/CoLChina',version,"-v20.1.12_linux_64", '.',"iso")
  }
  if (version == "2020" & OS == "Windows"){
    url <- paste0('http://sp2000.org.cn/CoL/CoLChina',version,"-v20.1.12_win_x86_64", '.',"iso")
  }
  outfile <- sub(".*/", "", url)
  download.file(url, file.path(dir,outfile),method)
  cat(sprintf("Download path: %s",dir),sep = "\n")
  browseURL(url)
}

