##' @title Search Catalogue of Life China checklist
##' @description Get checklist via species or infraspecies ID.
##' @rdname search_checklist
##' @name search_checklist
##' @param query \code{string} One or more queries, see \code{\link{search_family_id}} and \code{\link{search_taxon_id}} for more details.
##' @param mc.cores The number of cores to use, i.e. at most how many child processes will be run simultaneously. The option is initialized from environment variable MC_CORES if set. Must be at least one, and parallelization requires at least two cores,see \code{\link{mclapply}} for details.
##' @return Catalogue of Life China list(s)
##' @author Liuyong Ding \email{ly_ding@126.com}
##' @details Visit the website \url{http://sp2000.org.cn/api/document} for more details.
##' @importFrom pbmcapply pbmclapply
##' @importFrom jsonlite fromJSON
##' @importFrom rlist list.extract
##' @examples
##' \dontrun{
##' ##Set your key
##' set_search_key("your apiKey",db = "sp2000")
##'
##' ##Search family IDs via family name
##' familyid <- search_family_id(query = "Anguillidae")
##'
##' ##Search taxon IDs via familyID
##' taxonid <- search_taxon_id(query = familyid$Anguillidae$data$record_id,name = "familyID")
##'
##' #Download detailed lists via species or infraspecies ID
##' query <- taxonid[["3851c5311bed46c19529cb155d37aa9b"]][["data"]][["namecode"]]
##' x <- search_checklist(query = query)
##' str(x)
##' }
##' @export

search_checklist <- function(query = NULL, mc.cores = 2) {
  if (!is_search_key_set()){
    cat("*******************************************************************************\n")
    cat("** You need to apply for the apiKey from http://sp2000.org.cn/api/document   ** \n** to run all search_* functions, and then run set_search_key('your apiKey') **")
    cat("\n*******************************************************************************\n")
  }else{
    x1 <- species(query[1])
    switch(as.character(x1$code),
           "200" = {
             cat(sprintf("Request returned successfully!!!"), sep = "\n")
             cat(sprintf("Download  date: %s", Sys.Date()), sep = "\n")
           },
           "400" = {cat("Error request - the parameter query is not valid")},
           "401" = {cat("Request return failed!!! \n The apikey is incorrect. Please reenter it!!! \n You need to apply for the apiKey from http://sp2000.org.cn/api/document \n Running set_search_key('your apiKey') to run all search_* functions" )})
    if (.Platform$OS.type == "windows") {
      mc.cores = 1
    }
    if (as.character(x1$code) == 200){
      data <- pbmclapply(query,mc.cores = mc.cores,function(queries){
        x <- species(query = queries)
        x$data$download_date <- as.Date(Sys.time())
        x$data$taxonTree <- as_tibble(x$data$taxonTree)
        x$data$Refs <- Refs(x$data$Refs)
        x <- list(meta = list(code=x$code,message=x$message),
                  data = x$data)
      })
      names(data) <- get_scientificName(query)
      cat(sprintf("Records - Found: %s",length(query)), sep = "\n")
      #cat(sprintf("Scientific name: %s", paste0(get_scientificName_count(query), collapse = ", ")),sep = "\n")
      return(data)
    }
  }
}

get_scientificName <- function(x){
  sapply(1:length(x),function(i){
    list.extract(transpose(lapply(x,species))[["data"]][[i]], "scientificName")
  })
}

Refs <- function(x){
  c(diag(as.matrix(x)))
}

species <- function(query = NULL) {
  if (is_search_key_set()){
  url <- paste0('http://www.sp2000.org.cn/api/v2/getSpeciesByNameCode?apiKey=',Sys.getenv("sp2000_apiKey"),"&nameCode=",query)
  x <- fromJSON(url,flatten = TRUE)
  return(x)
  }
}
