##' @title Catalogue of Life list(s) convert data frame
##' @description Checklist lists convert data frame.
##' @rdname list_df
##' @name list_df
##' @param x \code{list} Results returned by the function \code{\link{search_checklist}} and \code{\link{get_col_global}}.
##' @param db \code{character} db = c("colchina","colglobal")
##' @importFrom tibble as_tibble
##' @importFrom rlist list.rbind
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
##' @author Liuyong Ding \email{ly_ding@126.com}
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
##' taxonid <- search_taxon_id(query = familyid$Anguillidae$data$record_id, name = "familyID")
##'
##' #Download detailed lists via species or infraspecies ID
##' query <- taxonid[["3851c5311bed46c19529cb155d37aa9b"]][["data"]][["namecode"]]
##' x1 <- search_checklist(query = query)
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
  switch(
    db,
    colchina = {
      data <- transpose(x)
      data$meta <- transpose(data$meta)
    } ,
    colglobal = {
      data <- transpose(x)
      data$meta <- transpose(data$meta)
    }
  )
  return(data)
}


