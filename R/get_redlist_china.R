#' @title Query Redlist of Chinese Biodiversity
#' @description Query Redlist of China’s Biodiversity of Vertebrate, Higher Plants and Macrofungi.
#' @rdname get_redlist_china
#' @param query \code{string} The string to query for.
#' @param option \code{character} There is one required parameter, which is either Chinese Names or Scientific Names. Give eithera Chinese Names or Scientific Names. If an Scientific Names is given, the Chinese Names parameter may not be used. Only exact matches found the name given will be returned. option=c("Chinese Names","Scientific Names").
#' @param taxon \code{character} There is one required parameter, taxon=c("Amphibians","Angiospermae","Ascomycetes","Basidiomycetes","Birds","Bryophyta","Gymnospermae","Inland Fishes","Lichens","Mammals","Pteridophyta","Reptiles").
#' @param viewDT \code{logic} TRUE or FALSE,the default value is FALSE.
#' @importFrom utils download.file
#' @importFrom DT datatable
#' @importFrom DT formatStyle
#' @importFrom DT styleEqual
#' @importFrom DT %>%
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
#' \donttest{
#' #query assessment status via Chinese Names or Scientific Names
#' get_redlist_china(query = "Anguilla", option = "Scientific Names")
#' get_redlist_china(query = "Anguilla nebulosa", option = "Scientific Names")
#'
#' #creates an HTML widget to display rectangular data
#' get_redlist_china(taxon = "Inland Fishes", viewDT = TRUE)
#' }
#' @export
get_redlist_china <- function(query = NULL,option = NULL,taxon = "Amphibians",viewDT = FALSE){
  cat(sprintf("last Update: %s",Sys.Date()),sep = "\n")
  option <- match.arg(option, c("Chinese Names","Scientific Names"))
  taxon <- match.arg(taxon, c("Amphibians","Angiospermae","Ascomycetes","Basidiomycetes","Birds","Bryophyta",
                              "Gymnospermae","Inland Fishes","Lichens","Mammals","Pteridophyta","Reptiles"))
  rds <- tempfile(pattern=".rds")
  url = 'https://gitee.com/LiuyongDing/latest_literature/raw/master/RedlistChina.rds'
  download.file(url,destfile = rds, quiet = TRUE)
  RedlistChina <- readRDS(rds)
  if (viewDT & taxon == taxon){
    data = RedlistChina[which(RedlistChina$Taxon == taxon),]
    print(table(data[,c(2,8,10)]))
    DT::datatable(data,filter = 'top',extensions = c("AutoFill",'Buttons',"ColReorder"),selection = "multiple",
                  options = list(
                  #language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Chinese.json'),
                  searchHighlight = TRUE,scrollX = TRUE,
                  autoFill = TRUE,pageLength = 5, autoWidth = TRUE,colReorder = TRUE,
                  dom = 'Bfrtlip',
                  buttons = c('copy', 'csv', 'excel')
    )) %>% formatStyle(
      'Status',
      color = styleEqual(c("EX","EW","RE","CR","EN","VU","NT","LC","DD"), rep("white",9)),
      backgroundColor = styleEqual(c("EX","EW","RE","CR","EN","VU","NT","LC","DD"),
                                      c("#010101","#525252","#919191","#D74D3B","#DE7F44","#FEF75E","#A3D2A5","#5B8D2A","#6CB4B7"))
    )
  } else{
    if (option == "Chinese Names"){
      names(RedlistChina)[3] <- "ChineseNames"
      i <- grep("Anguilla", RedlistChina$ChineseNames)
    }
    if (option == "Scientific Names"){
      names(RedlistChina)[4] <- "ScientificNames"
      i <- grep(query, RedlistChina$ScientificNames)
    }
    return(tibble::tibble(RedlistChina[i,]))
  }

}

update_dataset <- function() 'https://gitee.com/LiuyongDing/latest_literature/raw/master/RedlistChina.rds'
