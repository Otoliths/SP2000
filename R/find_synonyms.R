##' @title Find synonyms via species name
##' @description Find synonyms via species name from Catalogue of Life Global.
##' @rdname find_synonyms
##' @param query \code{character} species name,The function is similar to \code{\link{get_col_global}}.
##' @param mc.cores The number of cores to use, i.e. at most how many child processes will be run simultaneously. The option is initialized from environment variable MC_CORES if set. Must be at least one, and parallelization requires at least two cores,see \code{\link{mclapply}} for details.
##' @importFrom jsonlite fromJSON
##' @importFrom rlist list.rbind
##' @importFrom pbmcapply pbmclapply
##' @return object
##' @author Liuyong Ding \email{ly_ding@126.com}
##' @details Visit the website \url{http://webservice.catalogueoflife.org/col/webservice} for more details.
##' @references \url{https://github.com/lutteropp/SpeciesSynonymFinder/blob/master/find_synonyms.r}
##' @examples
##' \dontrun{
##' ##Get Catalogue of Life Global checklist via species name
##' x1 <- get_col_global(query = c("Anguilla marmorata","Anguilla japonica",
##'                               "Anguilla bicolor","Anguilla nebulosa",
##'                               "Anguilla luzonensis"),
##'                                option = "name")
##' str(x1)
##'
##' ##full queries
##' x2 <- get_col_global(query = "Anguilla", response = "full")
##'
##'
##' ##Find synonyms via species name
##' find_synonyms(query = c("Anguilla marmorata","Anguilla japonica",
##'                         "Anguilla bicolor","Anguilla nebulosa",
##'                         "Anguilla luzonensis"))
##' }
##' @export
find_synonyms <- function(query, mc.cores = 2) {
  cat(sprintf("Download  date: %s",Sys.Date()),sep = "\n")
  if (.Platform$OS.type == "windows") {
    mc.cores = 1
  }
  if(length(query) == 1){
    x <- synonyms(query)
  }else{
    x <- pbmclapply(query,synonyms,mc.cores = mc.cores)
    names(x)<- query
    for (i in 1:length(x)) {
      cat(sprintf("Find %s results of synonyms for %s are as follows: ",length(x[[query[i]]]), query[i]),sep = "\n")
    }
  }
  return(x)
}

synonyms <- function(query) {
  synonyms = list()
  species_name_no_spaces = gsub(" ","+",query, fixed=TRUE)
  url = paste0(webservice(),"name=",species_name_no_spaces, "&format=json&response=full")
  dbentry = jsonlite::fromJSON(url, flatten=TRUE)
  if (length(dbentry$results) == 0) {
    print(paste("Unfortunately, no results were found for ", query, ". Please check your spelling."), sep="")
  } else {
    #cat(sprintf("Find the results of synonyms for %s are as follows: ", query),sep = "\n")
    for (i in 1:length(dbentry$results)) {
      name = paste(dbentry$results[i,]$name)
      if (name == query) {
        status = paste(dbentry$results[i,]$name_status)
        if (status == "synonym") {
          #print(paste("Adding", dbentry$results[i,]$accepted_name.name))
          synonyms = c(synonyms,c(paste(dbentry$results[i,]$accepted_name.name)))
        } else { #accepted name
          for (j in 1:length(dbentry$results[i,]$synonyms[[1]]$name)) {
            #print(paste("Adding", dbentry$results[i,]$synonyms[[1]]$name[j]))
            synonyms = c(synonyms,c(paste(dbentry$results[i,]$synonyms[[1]]$name[j])))
          }
        }
      }
    }
  }
  cat(sprintf("Find %s results of synonyms for %s are as follows: ",length(unique(rlist::list.rbind(synonyms)[,1])), query),sep = "\n")
  return(unique(rlist::list.rbind(synonyms)[,1]))
}

webservice <- function() "http://webservice.catalogueoflife.org/col/webservice?"

