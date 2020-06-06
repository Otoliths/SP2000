#' @title Download 'Catalogue of Life China': Annual Checklist
#' @description  Organized by the Biodiversity Committee of Chinese Academy of Sciences (BC-CAS), Catalogue of Life China Annual Checklist edition has been compiled by Species 2000 China Node.
#' @rdname download_col_china
#' @name download_col_china
#' @param version \code{integer} Release version of annual checklist,the default value is 2020.
#' @param OS \code{character} Supported operating system,c("MacOS", "Ubuntu" ,"Windows"),the default value is "MacOS".
#' @param dir a non-empty character vector giving the directory name by user,the default value is dir = tempdir(),see [tempdir()] for details.
#' @return URL
#' @author Liuyong Ding
#' @details Visit the website \url{http://sp2000.org.cn/download} for more details.
#' @importFrom utils download.file
#' @importFrom utils browseURL
#' @examples
#' \donttest{
#' dir <- tempdir()
#' download_col_china(version = "2020",OS = "MacOS", dir = dir)
#' }
#' @export
download_col_china <- function(version = "2020", OS = "MacOS", dir = tempdir()) {
  cat(sprintf("Download the date: %s",Sys.Date()),sep = "\n")
  version <- match.arg(version, 2018:2020)
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
  download.file(url, file.path(dir,outfile))
  cat(sprintf("Download path: %s",dir),sep = "\n")
  browseURL(url)
}

