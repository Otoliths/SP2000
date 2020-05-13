#' @title Query Redlist of China’s Biodiversity
#' @description Query Redlist of China’s Biodiversity of Vertebrate, Higher Plants and Macrofungi.
#' @rdname get_RedlistChina
#' @param query \code{string} The string to query for.
#' @param option \code{character} There is one required parameter, which is either Chinese Names or Scientific Names. Give eithera Chinese Names or Scientific Names. If an Scientific Names is given, the Chinese Names parameter may not be used. Only exact matches found the name given will be returned. option=c("Chinese Names","Scientific Names").
#' @param taxon \code{character} There is one required parameter, taxon=c("Amphibians","Angiospermae","Ascomycetes","Basidiomycetes","Birds","Bryophyta","Gymnospermae","Inland Fishes","Lichens","Mammals","Pteridophyta","Reptiles").
#' @param datatable \code{logic} TRUE or FALSE,the default value is FALSE.
#' @importFrom downloader download
#' @importFrom DT datatable
#' @importFrom tibble tibble
#' @format assessment status:
#' \describe{
#' \item{EX}{Extinct}
#' \item{EW}{Extinct in the wild}
#' \item{RE}{Regional Extinct}
#' \item{CR}{Critically Endangered}
#' \item{EN}{Endangered}
#' \item{VU}{Vulnerable}
#' \item{NT}{Near Threatened}
#' \item{LC}{Least Concern}
#' \item{DD}{Data Deficient}
#' }
#' @return object
#' @details Visit the website \url{http://www.mee.gov.cn} for more details.
#' @examples
#' #query assessment status via Chinese Names or Scientific Names
#' get_RedlistChina(query = "Anguilla", option = "Scientific Names")
#' get_RedlistChina(query = "Anguilla nebulosa", option = "Scientific Names")
#'
#'#creates an HTML widget to display rectangular data
#' get_RedlistChina(taxon = "Inland Fishes", datatable = TRUE)
#' @export
get_RedlistChina <- function(query = NULL,option = NULL,taxon = "Amphibians",datatable = FALSE){
  cat(sprintf("last Update: %s",Sys.Date()),sep = "\n")
  option <- match.arg(option, c("Chinese Names","Scientific Names"))
  taxon <- match.arg(taxon, c("Amphibians","Angiospermae","Ascomycetes","Basidiomycetes","Birds","Bryophyta",
                              "Gymnospermae","Inland Fishes","Lichens","Mammals","Pteridophyta","Reptiles"))
  rds <- tempfile(pattern=".rds")
  downloader::download(update_dataset(),destfile = rds, quiet = TRUE)
  RedlistChina <- readRDS(rds)
  if (datatable & taxon == taxon){
    data = subset(RedlistChina,RedlistChina$Taxon == taxon)
    print(table(data[,c(2,8,10)]))
    datatable(data)
  } else{
    if (option == "Chinese Names"){
      names(RedlistChina)[3] <- "ChineseNames"
      i <- grep("Anguilla", RedlistChina$ChineseNames)
    }
    if (option == "Scientific Names"){
      names(RedlistChina)[4] <- "ScientificNames"
      i <- grep(query, RedlistChina$ScientificNames)
    }
    return(tibble(RedlistChina[i,]))
  }

}

update_dataset <- function() 'https://gitee.com/LiuyongDing/latest_literature/raw/master/RedlistChina.rds'
