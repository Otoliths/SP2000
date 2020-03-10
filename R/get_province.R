#' @title Statistics on Species or Infraspecies by Province
#' @description download the statistics datasets on species/infraspecies by province at \url{http://col.especies.cn/statistics/statistics_map}
#' @rdname  get_province
#' @name get_province
#' @return Statistics on species or infraspecies by province
#' @author Liuyong Ding
#' @details Visit the website \url{http://col.especies.cn/statistics/statistics_map} for more details
#' @importFrom jsonlite fromJSON
#' @examples
#' \dontrun{
#' x <- get_province()
#' head(x)
#' }
#' @export
get_province <- function() {
  url <- 'http://col.especies.cn/statistics/show_in_map_all'
  map_all <- fromJSON(url)
  map_all <- map_all$data
  names(map_all) <- c("province","species_counts")
  map_all$date <- as.Date(Sys.time())
  return(map_all)
}
