#' @title Query Redlist of Chinese Biodiversity
#' @description Query Redlist of China’s Biodiversity of Vertebrate, Higher Plants and Macrofungi.
#' @rdname get_redlist_china
#' @param query \code{string} The string to query for.
#' @param option \code{character} There is one required parameter, which is either Chinese Names or Scientific Names. Give eithera Chinese Names or Scientific Names. If an Scientific Names is given, the Chinese Names parameter may not be used. Only exact matches found the name given will be returned. option=c("Chinese Names","Scientific Names"),,the default value is "Scientific Names".
#' @param group \code{character} There is one required parameter, group=c("Amphibians","Birds","Inland Fishes","Mammals","Reptiles","Plants","Fungi").
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
#' @details Visit the website \url{http://zoology.especies.cn/} for more details.
#' @author Liuyong Ding \email{ly_ding@126.com}
#' @author Ke Yang \email{ydyangke@163.com}
#' @references \url{http://zoology.especies.cn/}
#' @references \url{http://www.fungalinfo.net}
#' @references \url{http://www.iplant.cn/rep/protlist}
#' @references \url{http://www.mee.gov.cn}
#' @examples
#' \dontrun{
#' #query assessment status via Chinese Names or Scientific Names
#' get_redlist_china(query = "Anguilla", option = "Scientific Names")
#' get_redlist_china(query = "Anguilla nebulosa", option = "Scientific Names")
#'
#' #creates an HTML widget to display rectangular data
#' get_redlist_china(group = "Inland Fishes", viewDT = TRUE)
#' }
#' @export
get_redlist_china <- function(query = NULL,option = "Scientific Names",group = "Amphibians",viewDT = FALSE){
  cat(sprintf("Download  date: %s",Sys.Date()),sep = "\n")
  option <- match.arg(option, c("Chinese Names","Scientific Names"))
  group <- match.arg(group, c("Amphibians","Birds","Fungi","Inland Fishes","Mammals","Plants","Reptiles"))
  rds <- tempfile(pattern=".rds")
  download.file(update_dataset(),destfile = rds, quiet = TRUE)
  RedlistChina <- readRDS(rds)
  if (viewDT & group == group){
    data = RedlistChina[which(RedlistChina$group == group),]
    print(table(data[,c(2,8,10)]))
    DT::datatable(data,filter = 'top',extensions = c("AutoFill",'Buttons',"ColReorder"),selection = "multiple",
                  options = list(
                  #language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Chinese.json'),
                  searchHighlight = TRUE,scrollX = TRUE,
                  autoFill = TRUE,pageLength = 5, autoWidth = TRUE,colReorder = TRUE,
                  dom = 'Bfrtlip',
                  buttons = c('copy', 'csv', 'excel')
    )) %>% formatStyle(
      'status',
      color = styleEqual(c("EX","EW","RE","CR","EN","VU","NT","LC","DD"), rep("white",9)),
      backgroundColor = styleEqual(c("EX","EW","RE","CR","EN","VU","NT","LC","DD"),
                                      c("#010101","#525252","#919191","#D74D3B","#DE7F44","#FEF75E","#A3D2A5","#5B8D2A","#6CB4B7"))
    )
  } else{
    if (option == "Chinese Names"){
      names(RedlistChina)[3] <- "species_c"
      i <- grep("Anguilla", RedlistChina$species_c)
    }
    if (option == "Scientific Names"){
      names(RedlistChina)[4] <- "species"
      i <- grep(query, RedlistChina$species)
    }
    return(tibble::tibble(RedlistChina[i,]))
  }

}

update_dataset <- function() 'https://gitee.com/LiuyongDing/latest_literature/raw/master/RedlistChina_0.1.0.rds'











