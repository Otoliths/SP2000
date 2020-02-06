##' download family IDs via family name, supports Latin and Chinese names
##'
##' @title using familyID to download family IDs
##' @rdname familyID
##' @name familyID
##' @param query \code{string} Family name, or part of family name, supports Latin and Chinese names
##' @param apiKey \code{string} You need to apply for the apiKey from \url{http://col.especies.cn/api/document} to run this function
##' @return fids string  Array of family ids
##' @author Liuyong Ding
##' @details Visit the website \url{http://col.especies.cn/api/document} for more details
##' @examples
##'\dontrun{
##' familyID(query="鳗鲡",apiKey="")
##'
##' query <- c("鳗鲡","鲤")
##' fids <- lapply(query,familyID)
##' (fids <- purrr::transpose(fids))
##' }
##' @export
familyID <- function(query=NULL,apiKey=NULL) {
  start_time <- Sys.time()
  url <- paste0('http://www.sp2000.org.cn/api/family/familyName/familyID/', query, '/', apiKey)
  x <- jsonlite::fromJSON(url,flatten = TRUE)
  return(x)
  print(Sys.time()-start_time)
}

packages <- c("jsonlite", "tibble","parallel","purrr","rlist")
package.check <- lapply(packages, FUN = function(x) {
  if (!require(x, character.only = TRUE)) {
    install.packages(x, dependencies = TRUE, repos = "http://cran.us.r-project.org")
    library(x, character.only = TRUE)
  }
})
