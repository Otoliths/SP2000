#' @title Statistics on Species or Infraspecies by Province from Catalogue of Life China checklist
#' @description Download the statistics datasets on species/infraspecies by province at \url{http://sp2000.org.cn/statistics/statistics_map} for more details.
#' @rdname  get_province
#' @name get_province
#' @return Statistics on species or infraspecies by province.
#' @author Liuyong Ding
#' @details Visit the website \url{http://sp2000.org.cn/statistics/statistics_map} for more details.
#' @importFrom jsonlite fromJSON
#' @importFrom tibble tibble
#' @examples
#' \donttest{
#' get_province()
#'
#' }
#' @export
get_province <- function() {
  cat(sprintf("last Update: %s",Sys.Date()),sep = "\n")
  url <- 'http://sp2000.org.cn/statistics/show_in_map_all'
  map_all <- fromJSON(url)
  map_all <- map_all$data
  names(map_all) <- c("province","species_counts")
  map_all$date <- as.Date(Sys.time())
  return(tibble(map_all))
}
