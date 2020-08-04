##' @title Search taxon IDs
##' @description Search taxon IDs via familyID ,scientificName and commonName.
##' @rdname search_taxon_id
##' @name search_taxon_id
##' @param query \code{string} familyID ,scientificName or commonName.
##' @param name \code{character} name = c("familyID","scientificName","commonName"),the default value is "scientificName".
##' @param start \code{intenger} Record number to start at. If omitted, the results are returned from the first record (start=1). Use in combination with limit to page through results. Note that we do the paging internally for you, but you can manually set the start parameter.
##' @param limit \code{intenger} Number of records to return. This is passed across all sources,when you first query, set the limit to something smallish so that you can get a result quickly, then do more as needed.
##' @param mc.cores The number of cores to use, i.e. at most how many child processes will be run simultaneously. The option is initialized from environment variable MC_CORES if set. Must be at least one, and parallelization requires at least two cores,see \code{\link{mclapply}} for details.
##' @importFrom jsonlite fromJSON
##' @importFrom rlist list.rbind
##' @importFrom rlist list.filter
##' @importFrom tibble tibble
##' @importFrom utils data
##' @importFrom pbmcapply pbmclapply
##' @format query:
##' \describe{
##' \item{taxonIDs}{an array of species' ids}
##' \item{familyID}{family ID, unique value}
##' \item{scientificName}{the scientific name, or part of the scientific name, supports Latin names and Chinese}
##' \item{commonName}{common name, or part of common name}
##' }
##' @return dataframe
##' @author Liuyong Ding \email{ly_ding@126.com}
##' @details Visit the website \url{http://sp2000.org.cn/api/document} for more details
##' @examples
##' \dontrun{
##' ##Set your key
##' set_search_key <- "your apiKey"
##'
##' ##Search family IDs via family name
##' familyid <- search_family_id(query = "Anguillidae")
##'
##' ##Search taxon IDs via familyID
##' taxonid <- search_taxon_id(query = familyid$Anguillidae$data$record_id,name = "familyID")
##'
##' }
##' @export
search_taxon_id <- function(query = NULL, name = "scientificName", start = 1, limit = 20, mc.cores = 2){
  if (!is_search_key_set()){
    cat("*******************************************************************************\n")
    cat("** You need to apply for the apiKey from http://sp2000.org.cn/api/document   ** \n** to run all search_* functions, and then run set_search_key('your apiKey') **")
    cat("\n*******************************************************************************\n")
  }else{
    x1 <- taxonID(query[1],name = name, page = start)
    switch(as.character(x1$code),
           "200" = {
             cat(sprintf("Request returned successfully!!!"), sep = "\n")
             cat(sprintf("Download  date: %s", Sys.Date()), sep = "\n")
           },
           "400" = {cat("Error request - the parameter query is not valid")},
           "401" = {cat("Request return failed!!! \n The apikey is incorrect. Please reenter it!!! \n You need to apply for the apiKey from http://sp2000.org.cn/api/document \n Running set_search_key('your apiKey') to run all search_* functions" )})
    if (.Platform$OS.type == "windows") {mc.cores = 1}
    if (as.character(x1$code) == 200){
      #i <- 1:length(query)
      #limit(query=query,name=name)[[1]][["meta"]][["count"]]
      if (limit > 20){
      x <- pbmclapply(query,mc.cores = mc.cores,function(queries){
         x <- limits_taxonID(query = queries,name = name,limit = limit)
       })
      query <- gsub("+"," ",query)
      names(x) <- query
      cat(sprintf("Research type: %s",name), sep = "\n")
      # cat(sprintf("Records - Found: %s, Returned: %s",found1(query,data),returned1(query,data)), sep = "\n")
      # cat(sprintf("Queries: %s", paste0(queries1(query,data), collapse = ", ")),sep = "\n")

      }else{
        x <- pbmclapply(query,mc.cores = mc.cores,function(queries){
          x <- taxonID(query = queries,name = name, page = start)
          x$data$species$download_date <- as.Date(Sys.time())
          x <- list(meta = list(code=x$code,limit=x$data$limit,count=x$data$count,page=x$data$page,message=x$message),
                    data = x$data$species)
        })
        names(x) <- query
        cat(sprintf("Research type: %s",name), sep = "\n")
        # cat(sprintf("Records - Found: %s, Returned: %s",found1(query,data),returned1(query,data)), sep = "\n")
        # cat(sprintf("Queries: %s", paste0(queries1(query,data), collapse = ", ")),sep = "\n")
      }
    return(x)
  }
}
}

taxonID <- function(query = NULL, name, page) {
  if (is_search_key_set()){
    switch(name,
           familyID = {
             url <- paste0(web_v2(), "getSpeciesByFamilyId?apiKey=",Sys.getenv("sp2000_apiKey"),"&familyId=",query, "&page=", page)
             x <- fromJSON(url)
           },
           scientificName = {
             query <- gsub(" ","+",query)
             url <- paste0(web_v2(), "getSpeciesByScientificName?apiKey=",Sys.getenv("sp2000_apiKey"),"&scientificName=",query, "&page=", page)
             x <- fromJSON(url)
           },
           commonName = {
             url <- paste0(web_v2(), "getSpeciesByCommonName?apiKey=",Sys.getenv("sp2000_apiKey"),"&commonName=",query, "&page=", page)
             x <- fromJSON(url)
           }
    )
  }
}

web_v2 <- function()"http://www.sp2000.org.cn/api/v2/"

# queries1 <- function(query,x){
#   if (length(query) > 3){
#     paste0(query[1:3],"(",sapply(1:3,function(i)dim(x[[query[3]]][["data"]])[1]),")")
#   }else{
#     paste0(query,"(",sapply(1:length(query),function(i)dim(x[[query[i]]][["data"]])[1]),")")
#   }
# }
#
#
# found1 <- function(query,x){
#   sum(sapply(1:length(query),function(i){
#     x[[query[i]]][["meta"]][["count"]][1]
#   }))
# }
#
#
# returned1 <- function(query,x){
#   sum(sapply(1:length(query),function(i){
#     dim(x[[query[i]]][["data"]][["accepted_name_info"]])[1]
#   }))
# }

queries1 <- function(query,x){
  if (length(query) > 3){
    paste0(query[1:3],"(",sapply(1:3,function(i)dim(x[[query[i]]][["data"]][["accepted_name_info"]])[1]),")")
  }else{
    paste0(query,"(",sapply(1:length(query),function(i)dim(x[[query[i]]][["data"]][["accepted_name_info"]])[1]),")")
  }
}

limits_taxonID <- function(query,name,limit){
    #page <- ceiling(lapply(query,taxonID,name = name,page=1)[[1]][["data"]][["count"]]/20)
  page <- ceiling(limit/20)
  ss <- lapply(1:page,function(page){
    x <- lapplytaxonID(query = query,name = name, page = page)
  })
  ss <- rlist::list.filter(ss,dim(data)[1] > 0)
  ss <- purrr::transpose(ss)
  ss$meta <- rlist::list.stack(ss$meta)
  ss$data <- purrr::transpose(ss$data)
  ss$data$name_status <- rlist::list.ungroup(ss$data$name_status)
  ss$data$name_code <- rlist::list.ungroup(ss$data$name_code)
  ss$data$scientific_name <- rlist::list.ungroup(ss$data$scientific_name)
  ss$data$download_date <- Sys.Date()
  ss$data$accepted_name_info <- purrr::transpose(ss$data$accepted_name_info)
  ss$data$accepted_name_info$searchCodeStatus <- rlist::list.ungroup(ss$data$accepted_name_info$searchCodeStatus)
  ss[["data"]][["accepted_name_info"]][["namecode"]] <- rlist::list.ungroup(ss[["data"]][["accepted_name_info"]][["namecode"]])
  ss[["data"]][["accepted_name_info"]][["scientificName"]] <- rlist::list.ungroup(ss[["data"]][["accepted_name_info"]][["scientificName"]])
  ss[["data"]][["accepted_name_info"]][["author"]] <- rlist::list.ungroup(ss[["data"]][["accepted_name_info"]][["author"]])
  ss[["data"]][["accepted_name_info"]][["Distribution"]] <- rlist::list.ungroup(ss[["data"]][["accepted_name_info"]][["Distribution"]])
  ss[["data"]][["accepted_name_info"]][["chineseName"]] <- rlist::list.ungroup(ss[["data"]][["accepted_name_info"]][["chineseName"]])
  ss[["data"]][["accepted_name_info"]][["searchCode"]] <- rlist::list.ungroup(ss[["data"]][["accepted_name_info"]][["searchCode"]])
  ss$data$accepted_name_info$CommonNames <- rlist::list.ungroup(ss$data$accepted_name_info$CommonNames)
  ss$data$accepted_name_info$taxonTree <- purrr::transpose(ss$data$accepted_name_info$taxonTree)
  ss$data$accepted_name_info$taxonTree$phylum <- rlist::list.ungroup(ss$data$accepted_name_info$taxonTree$phylum)
  ss$data$accepted_name_info$taxonTree$genus <- rlist::list.ungroup(ss$data$accepted_name_info$taxonTree$genus)
  ss$data$accepted_name_info$taxonTree$species <- rlist::list.ungroup(ss$data$accepted_name_info$taxonTree$species)
  ss$data$accepted_name_info$taxonTree$infraspecies <- rlist::list.ungroup(ss$data$accepted_name_info$taxonTree$infraspecies)
  ss$data$accepted_name_info$taxonTree$family <- rlist::list.ungroup(ss$data$accepted_name_info$taxonTree$family)
  ss$data$accepted_name_info$taxonTree$kingdom <- rlist::list.ungroup(ss$data$accepted_name_info$taxonTree$kingdom)
  ss$data$accepted_name_info$taxonTree$class <- rlist::list.ungroup(ss$data$accepted_name_info$taxonTree$class)
  ss$data$accepted_name_info$taxonTree$order <- rlist::list.ungroup(ss$data$accepted_name_info$taxonTree$order)
  ss$data$accepted_name_info$taxonTree <- as_tibble(ss$data$accepted_name_info$taxonTree)
  ss$data$accepted_name_info$Refs <- rlist::list.ungroup(ss$data$accepted_name_info$Refs)
  ss$data$accepted_name_info$SpecialistInfo <- rlist::list.ungroup(ss$data$accepted_name_info$SpecialistInfo)
  ss$data$accepted_name_info$SpecialistInfo <- purrr::transpose(ss$data$accepted_name_info$SpecialistInfo)
  ss[["data"]][["accepted_name_info"]][["SpecialistInfo"]][["E-Mail"]] <- rlist::list.ungroup(ss[["data"]][["accepted_name_info"]][["SpecialistInfo"]][["E-Mail"]])
  ss$data$accepted_name_info$SpecialistInfo$Address <- rlist::list.ungroup(ss$data$accepted_name_info$SpecialistInfo$Address)
  ss$data$accepted_name_info$SpecialistInfo$name <- rlist::list.ungroup(ss$data$accepted_name_info$SpecialistInfo$name)
  ss$data$accepted_name_info$SpecialistInfo$Institution <- rlist::list.ungroup(ss$data$accepted_name_info$SpecialistInfo$Institution)
  ss$data$accepted_name_info$SpecialistInfo <- as_tibble(ss$data$accepted_name_info$SpecialistInfo)
  ss$data$accepted_name_info$Synonyms <- rlist::list.ungroup(ss$data$accepted_name_info$Synonyms)
  ss$data$accepted_name_info <- as_tibble(ss$data$accepted_name_info)
    return(ss)
  }


lapplytaxonID <- function(query = NULL, name, page){
  x <- lapply(query,function(i){
    taxonID(i,name, page)
  })
  names(x) <- query
  x[[query]][["data"]][["species"]][["download_date"]] <- as.Date(Sys.time())
  x <- list(meta = list(code=x[[query]][["code"]],
                        limit=x[[query]][["data"]][["limit"]],
                        count=x[[query]][["data"]][["count"]],
                        page=x[[query]][["data"]][["page"]],
                        message=x[[query]][["message"]]),
            data = x[[query]][["data"]][["species"]])
}


# limit <- function(query,name){
#   lapply(1:length(query),function(x){
#     lapplytaxonID(query = query[x], name = name, page=1)
#   })
# }
# taxonid <- search_taxon_id(query = "Actinidia",name = "scientificName", mc.cores=1, limit = 200)
