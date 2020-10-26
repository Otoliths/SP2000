##' @title Search Catalogue of Life Taiwan checklist
##' @description Get Catalogue of Life Taiwan checklist via advanced query.
##' @rdname get_col_taiwan
##' @param query \code{string} The string to search for.
##' @param level \code{character} Query by category level, level=c("kingdom","phylum","class","order","family","genus","species"),the default value is "species".
##' @param option \code{character} Query format, option=c("contain","equal","beginning"),the default value is "equal".
##' @param include_synonyms \code{logic} Whether the results contain a synonym or not.
##' @importFrom XML xmlToDataFrame
##' @importFrom xml2 download_xml
##' @importFrom tibble as_tibble
##' @return object
##' @author Liuyong Ding \email{ly_ding@126.com}
##' @details Visit the website \url{https://taibnet.sinica.edu.tw/eng/taibnet_species_query.php} for more details.
##' @examples
##' \dontrun{
##' ##Search Catalogue of Life Taiwan checklist
##' get_col_taiwan(query="Anguilla",level="species",option = "contain")
##'
##' get_col_taiwan(query="Anguillidae",level="family")
##' }
##' @export

get_col_taiwan <- function(query, level = "species", option = "equal",include_synonyms = TRUE){
  cat(sprintf("Download date: %s",Sys.Date()),sep = "\n")
  query = gsub(" ","+",query, fixed=TRUE)
  level <- match.arg(level, c("kingdom","phylum","class","order","family","genus","species"))
  option <- match.arg(option, c("contain","equal","beginning"))
  if (level == "species"){
    level =  "name"
  }
  if (include_synonyms){
    url <- paste0(web(),"R1=",level,"&D1=&D2=",level,"&D3=",option,"&T1=",query,"&T2=&id=y&sy=y")
    CoLTaiwan <- tibble::as_tibble(XML::xmlToDataFrame(download_xml(url,file = tempfile())))
  }else{
    url <- paste0(web(),"R1=",level,"&D1=&D2=",level,"&D3=",option,"&T1=",query,"&T2=&id=y&sy=")
    CoLTaiwan <- tibble::as_tibble(XML::xmlToDataFrame(download_xml(url,file = tempfile())))
  }
  return(CoLTaiwan)
}

web <- function()"http://taibnet.sinica.edu.tw/eng/taibnet_xml.php?"

