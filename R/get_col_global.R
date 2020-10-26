##' @title Search Catalogue of Life Global checklist
##' @description Get Catalogue of Life Global checklist via species name and id.
##' @rdname get_col_global
##' @param query \code{string} The string to search for.
##' @param option \code{character} There is one required parameter, which is either name or id. Give eithera name or an ID. If an ID is given, the name parameter may not be used, and vice versa. option=c("id","name"),the default value is "name". Only exact matches found the name given will be returned, unless a wildcard (*) is appended. Wildcards are allowed only at the end of the string. This offers the option to e.g. search for genus* to retrieve the genus plus all its (infra)species. The name must be at least 3 characters long, not counting the wildcard character. The record ID of the specific record to return (only for scientific names of species or infraspecific taxa).
##' @param response \code{character} Type of response returned. Valid values are response=terse and response=full. if the response parameter is omitted, the results are returned in the default terse format. If format=terse then a minimum set of results are returned (this is faster and smaller, enough for name lookup), if format=full then all available information is returned, response=c("full","terse"),the default value is "terse".
##' @param start \code{integer} Record number to start at. If omitted, the results are returned from the first record (start=0). Use in combination with limit to page through results. Note that we do the paging internally for you, but you can manually set the start parameter.
##' @param limit \code{integer} Number of records to return. This is useful if the total number of results is larger than the maximum number of results returned by a single Web service query (currently the maximum number of results returned by a single query is 500 for terse queries and 50 for full queries,the default value is 500.Note that there is a hard maximum of 10,000, which is calculated as the limit+start, so start=99,00 and limit=2000 won't work.
##' @param mc.cores The number of cores to use, i.e. at most how many child processes will be run simultaneously. The option is initialized from environment variable MC_CORES if set. Must be at least one, and parallelization requires at least two cores,see \code{\link{mclapply}} for details.
##' @importFrom jsonlite fromJSON
##' @importFrom rlist list.rbind
##' @importFrom rlist list.filter
##' @importFrom tibble tibble
##' @importFrom pbmcapply pbmclapply
##' @return object
##' @author Liuyong Ding \email{ly_ding@126.com}
##' @details Visit the website \url{http://webservice.catalogueoflife.org/col/webservice} for more details.
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
get_col_global <- function(query, option = "name", response = "terse",start = 0,  limit = 500, mc.cores = 2){
  cat(sprintf("Download  date: %s",Sys.Date()),sep = "\n")
  cat(sprintf("Research type: %s",option), sep = "\n")
  if (.Platform$OS.type == "windows") {
    mc.cores = 1
  }
  x <- pbmclapply(query,mc.cores = mc.cores,limits_col_global,option,response,start,limit)
  names(x)<- query
  #cat(sprintf("Records - Found: %s, Returned: %s",found3(query,x),returned3(query,x)), sep = "\n")
  return(x)
}

webservice <- function() "http://webservice.catalogueoflife.org/col/webservice?"


col_global <- function(query, option = "name",response = "terse", start = 0){
  option <- match.arg(option, c("id","name"))
  response <- match.arg(response, c("full","terse"))
  switch (option,
          name = {
            species_name_no_spaces = gsub(" ","+",query, fixed=TRUE)
            url = paste(webservice(), "name=", species_name_no_spaces, "&format=json&","response=",response,"&","start=",start,sep = "")
            dbentry = jsonlite::fromJSON(url, flatten=TRUE)
          },
          id = {
            url = paste0(webservice(), "id=", query, "&format=json&","response=",response,"&","start=",start)
            dbentry = jsonlite::fromJSON(url, flatten=TRUE)
          }
  )
  return(dbentry)
}


limits_col_global <- function(query, option = "name",response = "terse", start, limit){
  number_of_results_returned <- "number_of_results_returned"
  switch(response,
         terse = {
           if(limit > 500){
             #c(start,seq(500,limit,500))
             x <- lapply(seq(start,limit,500),function(i){
               col_global(query = query,option = option, response = response, start = i)
             })
             x1 <- rlist::list.filter(x, number_of_results_returned > 0)
             x <- clean(x,response = response)
           }else {
             x <- col_global(query = query,option = option, response = response, start = start)
             x <- list(meta = list(id = x$id,
                                   name = x$name,
                                   total_number_of_results = x$total_number_of_results,
                                   number_of_results_returned = x$number_of_results_returned,
                                   start = x$start,
                                   error_mexage = x$error_mexage,
                                   version = x$version,
                                   rank = x$rank),
                       data = x$results)
             x$data <- tibble::as_tibble(x$data)
           }
         },
         full = {
           if (limit > 50){
             x <- lapply(seq(start,limit,50),function(i){
               col_global(query = query,option = option, response = response, start = i)
             })
             x <- rlist::list.filter(x, number_of_results_returned > 0)
             x <- clean(x,response = response)

           }else{
             x <- col_global(query = query,option = option, response = response, start = start)
             x <- list(meta = list(id = x$id,
                                   name = x$name,
                                   total_number_of_results = x$total_number_of_results,
                                   number_of_results_returned = x$number_of_results_returned,
                                   start = x$start,
                                   error_mexage = x$error_mexage,
                                   version = x$version,
                                   rank = x$rank),
                       data = x$results)
             x$data <- tibble::as_tibble(x$data)

           }
         }
  )
  return(x)
}

clean <- function(x,response){
  switch (response,
          terse = {
            ss <- purrr::transpose(x)
            ss$results <- purrr::transpose(ss$results)
            for (i in 1:8) {
              ss[[names(ss)[i]]] <- rlist::list.ungroup(ss[[names(ss)[i]]])
            }
            # for (j in names(ss$results)[c(1:11,12:19,20:26)]) {
            #   ss[["results"]][[j]] <- rlist::list.ungroup(ss[["results"]][[j]])
            # }
            # for (k in names(ss$results)[c(17,19)]) {
            #   ss[["results"]][[k]] <- rlist::list.ungroup(purrr::transpose(ss[["results"]][[k]]))
            # }
            ss <- list(meta = list(id = ss$id,
                                   name = ss$name,
                                   total_number_of_results = ss$total_number_of_results,
                                   number_of_results_returned = ss$number_of_results_returned,
                                   start = ss$start,
                                   error_message = ss$error_message,
                                   version = ss$version,
                                   rank = ss$rank),
                       data = ss$results)
            #ss$data <- tibble::as_tibble(ss$data)
          },
          full = {
            ss <- purrr::transpose(x)
            ss$results <- purrr::transpose(ss$results)
            for (i in 1:8) {
              ss[[names(ss)[i]]] <- rlist::list.ungroup(ss[[names(ss)[i]]])
            }
            # for (j in names(ss$results)[c(1:7,10:15,17:21,25:42,48)]) {
            #   ss[["results"]][[j]] <- rlist::list.ungroup(ss[["results"]][[j]])
            # }
            # for (k in names(ss$results)[c(8:9,16,22:24,43:47)]) {
            #   ss[["results"]][[k]] <- rlist::list.ungroup(purrr::transpose(ss[["results"]][[k]]))
            # }
            ss <- list(meta = list(id = ss$id,
                                   name = ss$name,
                                   total_number_of_results = ss$total_number_of_results,
                                   number_of_results_returned = ss$number_of_results_returned,
                                   start = ss$start,
                                   error_message = ss$error_message,
                                   version = ss$version,
                                   rank = ss$rank),
                       data = ss$results)
            #ss$data <- tibble::as_tibble(ss$data)
          }
  )
  return(ss)
}
