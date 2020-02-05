#' download the statistics datasets on species/infraspecies by province at \url{http://col.especies.cn/statistics/statistics_map}
#'
#' @title Statistics on Species or Infraspecies by Province
#' @rdname  statistics_map
#' @name statistics_map
#' @return Statistics on species or infraspecies by province
#' @author Liuyong Ding
#' @details Visit the website \url{http://col.especies.cn/statistics/statistics_map} for more details
#' @examples
#' \dontrun{
#' x <- statistics_map()
#' head(x)
#' }
#' @export

statistics_map <- function() {
  url <- 'http://col.especies.cn/statistics/show_in_map_all'
  map_all <- jsonlite::fromJSON(url)
  map_all <- map_all$data
  names(map_all) <- c("province","species_counts")
  map_all$date <- as.Date(Sys.time())
  return(map_all)
}




