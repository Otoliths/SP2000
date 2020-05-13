##' @title Find synonyms via species name
##' @description Find synonyms via species name from Catalogue of Life Global.
##' @param query \code{character} species name,The function is similar to \link{get_CoLGlobal}.
##' @rdname find_Synonyms
##' @importFrom jsonlite fromJSON
##' @importFrom rlist list.rbind
##' @return object
##' @author Liuyong Ding
##' @details Visit the website \url{http://webservice.catalogueoflife.org/col/webservice} for more details.
##' @examples
##'\dontrun{
##' dbentry1 <- get_CoLGlobal(query = "4fdb38d6220462049eab9e3f285144e0", option = "id")
##' str(dbentry1)
##' head(dbentry1$results)
##'
##' dbentry2 <- get_CoLGlobal(query = "Platalea leucorodia", option = "name")
##' str(dbentry2)
##' head(dbentry2$results)
##'
##' Synonyms <- find_Synonyms("Anguilla anguilla")
##'}
##' @export
find_Synonyms <- function(query) {
  cat(sprintf("last Update: %s",Sys.Date()),sep = "\n")
  synonyms = list()
  species_name_no_spaces = gsub(" ","+",query, fixed=TRUE)
  url = paste0(webservice(),"name=",species_name_no_spaces, "&format=json&response=full")
  dbentry = jsonlite::fromJSON(url, flatten=TRUE)
  if (length(dbentry$results) == 0) {
    print(paste("Unfortunately, no results were found for ", query, ". Please check your spelling."), sep="")
  } else {
    cat(sprintf("Find the results of synonyms for %s are as follows: ", query),sep = "\n")
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
  return(rlist::list.rbind(synonyms)[,1])
}

webservice <- function() "http://webservice.catalogueoflife.org/col/webservice?"

