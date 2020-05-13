##' @title Catalogue of Life China list(s) convert data frame
##' @description Checklist lists convert data frame.
##' @rdname list_df
##' @name list_df
##' @param x \code{list} object, See [search_checklist] for more details.
##' @importFrom tibble tibble
##' @importFrom rlist list.rbind
##' @importFrom rlist list.stack
##' @importFrom purrr transpose
##' @format A data frame with 19 variables:
##' \describe{
##' \item{ScientificName}{The scientific name (the accepted name) includes the name and the date of the name}
##' \item{Synonyms}{Synonyms name, Latin}
##' \item{ChineseName}{Chinese name}
##' \item{CommonNames}{Common name}
##' \item{Kingdom}{Kingdom at taxonTree}
##' \item{Phylum}{Phylum at taxonTree}
##' \item{Class}{Class at taxonTree}
##' \item{Order}{Order at taxonTree}
##' \item{Family}{Family at taxonTree}
##' \item{Genus}{Genus at taxonTree}
##' \item{Species}{Species at taxonTree}
##' \item{Infraspecies}{Infraspecies at taxonTree}
##' \item{Distribution}{Distribution of species or infraspecies}
##' \item{Name}{Full name of reviewer in English or Chinese}
##' \item{Email}{Organization of the reviewer in  English or Chinese}
##' \item{Address}{Email address of the reviewer}
##' \item{Institution}{Address of the reviewer in  English or Chinese}
##' \item{References}{References}
##' \item{Download}{Download date}
##' }
##' @author Liuyong Ding
##' @source Visit the website \url{http://sp2000.org.cn/api/document} for more details
##' @examples
##' \dontrun{
##' queries <- c("025397f9-9891-40a7-b90b-5a61f9c7b597","04c59ee8-4b48-4095-be0d-663485463f21")
##' x1 <- search_checklist(query = queries)
##' x2 <- list_df(x1)
##' for(i in 1:length(x2$References)){
##' x2$References[[i]] <- as.matrix(x2$References[[i]])
##' x2$References[[i]] <- diag(x2$References[[i]])
##' x2$References[[i]] <- paste(x2$References[[i]][1:length(x2$References[[i]])],collapse=";")
##' }
##' }
##' @export
list_df <- function(x){
  data <- tibble(
    ScientificName = do.call("rbind", transpose(x)[["scientificName"]]),
    Synonyms = transpose(x)[["Synonyms"]],
    chineseName = do.call("rbind", transpose(x)[["chineseName"]]),
    CommonNames = transpose(x)[["CommonNames"]],
    Kingdom = do.call("rbind", transpose(transpose(x)[["taxonTree"]])[["kingdom"]]),
    Phylum = do.call("rbind", transpose(transpose(x)[["taxonTree"]])[["phylum"]]),
    Class = do.call("rbind", transpose(transpose(x)[["taxonTree"]])[["class"]]),
    Order = do.call("rbind", transpose(transpose(x)[["taxonTree"]])[["order"]]),
    Family = do.call("rbind", transpose(transpose(x)[["taxonTree"]])[["family"]]),
    Genus = do.call("rbind", transpose(transpose(x)[["taxonTree"]])[["genus"]]),
    Species = do.call("rbind", transpose(transpose(x)[["taxonTree"]])[["species"]]),
    Infraspecies = do.call("rbind", transpose(transpose(x)[["taxonTree"]])[["infraspecies"]]),
    Distribution = list.rbind(as.character(transpose(x)[["Distribution"]])),
    Name = do.call("rbind",transpose(transpose(x)[["SpecialistInfo"]])[["name"]]),
    Email = do.call("rbind",transpose(transpose(x)[["SpecialistInfo"]])[["E-Mail"]]),
    Address = do.call("rbind",transpose(transpose(x)[["SpecialistInfo"]])[["Address"]]),
    Institution = do.call("rbind",transpose(transpose(x)[["SpecialistInfo"]])[["Institution"]]),
    References = transpose(x)[["Refs"]],
    Downloaddate = rep(as.Date(Sys.time()),length(x))
  )
  return(data)
}
