##' @title Search Catalogue of Life Global checklist
##' @description Get Catalogue of Life Global checklist via species name and id.
##' @rdname get_col_global
##' @param query \code{string} The string to search for.
##' @param option \code{character} There is one required parameter, which is either name or id. Give eithera name or an ID. If an ID is given, the name parameter may not be used, and vice versa. option=c("id","name"),the default value is "name". Only exact matches found the name given will be returned, unless a wildcard (*) is appended. Wildcards are allowed only at the end of the string. This offers the option to e.g. search for genus* to retrieve the genus plus all its (infra)species. The name must be at least 3 characters long, not counting the wildcard character. The record ID of the specific record to return (only for scientific names of species or infraspecific taxa).
##' @param response \code{character} Type of response returned. Valid values are response=terse and response=full. if the response parameter is omitted, the results are returned in the default terse format. If format=terse then a minimum set of results are returned (this is faster and smaller, enough for name lookup), if format=full then all available information is returned, response=c("full","terse"),the default value is "terse".
##' @param start \code{integer} The first record to return. If omitted, the results are returned from the first record (start=0). This is useful if the total number of results is larger than the maximum number of results returned by a single Web service query (currently the maximum number of results returned by a single query is 500 for terse queries and 50 for full queries,the default value is 0.
##' @param mc.cores The number of cores to use, i.e. at most how many child processes will be run simultaneously. The option is initialized from environment variable MC_CORES if set. Must be at least one, and parallelization requires at least two cores,see [mclapply()] for details.
##' @importFrom jsonlite fromJSON
##' @importFrom rlist list.rbind
##' @importFrom tibble tibble
##' @importFrom pbmcapply pbmclapply
##' @return object
##' @author Liuyong Ding
##' @details Visit the website \url{http://webservice.catalogueoflife.org/col/webservice} for more details.
##' @examples
##' \donttest{
##' ##Get Catalogue of Life Global checklist via species name
##' x <- get_col_global(query = c("Anguilla marmorata","Anguilla japonica",
##'                               "Anguilla bicolor","Anguilla nebulosa",
##'                               "Anguilla luzonensis"),
##'                               option = "name")
##' str(x)
##'
##' ##Find synonyms via species name
##' find_synonyms(query = c("Anguilla marmorata","Anguilla japonica",
##'                         "Anguilla bicolor","Anguilla nebulosa",
##'                         "Anguilla luzonensis"))
##' }
##' @export
get_col_global <- function(query, option = "name",response = "terse", start = 0,mc.cores = 2){
  cat(sprintf("last Update: %s",Sys.Date()),sep = "\n")
  if (.Platform$OS.type == "windows") {
    mc.cores = 1
  }
    x <- pbmclapply(query,col_global,option,response,start,mc.cores = mc.cores)
    names(x)<- query
    return(x)
}

col_global <- function(query, option = "name",response = "terse", start = 0){
  option <- match.arg(option, c("id","name"))
  if (option == "name"){
    species_name_no_spaces = gsub(" ","+",query, fixed=TRUE)
    response <- match.arg(response, c("full","terse"))
    url = paste(webservice(), "name=", species_name_no_spaces, "&format=json&","response=",response,"&","start=",start,sep = "")
    dbentry = jsonlite::fromJSON(url, flatten=TRUE)
  } else{
    url = paste0(webservice(), "id=", query, "&format=json&","response=",response,"&","start=",start)
    dbentry = jsonlite::fromJSON(url, flatten=TRUE)
  }
  return(dbentry)
}

webservice <- function() "http://webservice.catalogueoflife.org/col/webservice?"




