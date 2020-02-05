#' download the top20 species from \url{http://col.especies.cn}
#'
#' @title download the top20 species
#' @rdname  get_top20
#' @name get_top20
#' @return top20 species
#' @author Liuyong Ding
#' @details Visit the website \url{http://col.especies.cn} for more details
#' @examples
#' \dontrun{
#' x <- get_top20()
#' head(x)
#' }
#' @export

get_top20 <- function() {
  url <- 'http://col.especies.cn/record/speciesView/top20?_=1580870992724'
  top20 <- jsonlite::fromJSON(url)
  top20$url <- gsub("species/show_species_details/", "", top20$url)
  top20$target <- gsub("_top","top20",top20$target)
  names(top20) <- c("species","taxonIDs","rank")
  top20$date <- as.Date(Sys.time())
  return(top20)
}





