##' @title Search Catalogue of Life Taiwan checklist
##' @description Get Catalogue of Life Taiwan checklist via advanced query.
##' @rdname get_coltaiwan
##' @param query \code{string} The string to search for.
##' @param tree \code{character} Query by category tree, tree=c("kingdom","phylum","class","order","family","genus","name"),the default value is "name".
##' @param option \code{character} Query format, option=c("contain","equal","beginning"),the default value is "equal".
##' @param include_synonyms \code{logic} Whether the results contain a synonym or not.
##' @importFrom XML xmlToDataFrame
##' @importFrom tibble as_tibble
##' @return object
##' @author Liuyong Ding
##' @details Visit the website \url{http://taibnet.sinica.edu.tw/eng/taibnet_species_query.php?} for more details.
##' @examples
##' \donttest{
##' get_coltaiwan(query="Anguilla",tree="name",option = "contain")
##'
##' get_coltaiwan(query="Giganthorhynchidae",tree="family")
##' }
##' @export

get_coltaiwan <- function(query,tree,option = "equal",include_synonyms = TRUE){
  cat(sprintf("last Update: %s",Sys.Date()),sep = "\n")
  query = gsub(" ","+",query, fixed=TRUE)
  tree <- match.arg(tree, c("kingdom","phylum","class","order","family","genus","name"))
  option <- match.arg(option, c("contain","equal","beginning"))
  if (include_synonyms){
    url <- paste0(web(),"R1=",tree,"&D1=&D2=",tree,"&D3=",option,"&T1=",query,"+&T2=&id=y&sy=y")
    CoLTaiwan <- tibble::as_tibble(XML::xmlToDataFrame(url))
  }else{
    url <- paste0(web(),"R1=",tree,"&D1=&D2=",tree,"&D3=",option,"&T1=",query,"+&T2=&id=y&sy=")
    CoLTaiwan <- tibble::as_tibble(XML::xmlToDataFrame(url))
  }
  return(CoLTaiwan)
}

web <- function()"http://taibnet.sinica.edu.tw/eng/taibnet_xml.php?"
