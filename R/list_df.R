##' @title Catalogue of Life list(s) convert data frame
##' @description Checklist lists convert data frame.
##' @rdname list_df
##' @name list_df
##' @param x \code{list} The result returned by the function [search_checklist] or [get_col_global].
##' @param db \code{character} db = c("colchina","colglobal")
##' @importFrom tibble tibble
##' @importFrom tibble as_tibble
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
##' ##Set your key
##' set_search_key <- "your apiKey"
##'
##' ##Search family IDs via family name
##' familyid <- search_family_id(query = "Anguillidae")
##'
##' ##Search taxon IDs via familyID
##' taxonid <- search_taxon_id(query = familyid$familyIDs,name = "familyID")
##'
##' #Download detailed lists via species or infraspecies ID
##' x1 <- search_checklist(query = taxonid$taxonIDs)
##' str(x1)
##' x1 <- list_df(x1,db = "colchina")
##'
##' #Get Catalogue of Life Global checklist via species name
##' x2 <- get_col_global(query = c("Anguilla marmorata","Anguilla japonica",
##'                                "Anguilla bicolor","Anguilla nebulosa",
##'                                "Anguilla luzonensis"),
##'                                option = "name")
##' str(x2)
##' x2 <- list_df(x2,db = "colglobal")
##' }
##' @export
list_df <- function(x,db = c("colchina","colglobal")){
  db <- match.arg(db, c("colchina","colglobal"))
  if(db == "colchina"){
    name <- c("Synonyms","scientificName","Refs","Distribution","taxonTree","chineseName","CommonNames","SpecialistInfo","downloadDate")
    for (i in 1:length(x)) {
      if(is.element("Synonyms", names(x[[i]]))== FALSE){
        x[[i]]$Synonyms = data.frame(synonyms = NA)
      }
      if(is.element("Distribution", names(x[[i]]))== FALSE){
        x[[i]][["Distribution"]] = Distribution = NA
      }
    }
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
  }else{
    data <- as_tibble(transpose(x))
  }
  return(data)
}


