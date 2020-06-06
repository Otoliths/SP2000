\name{SP2000-package}
\alias{SP2000-package}
\alias{SP2000}
\docType{package}
\title{\packageTitle{SP2000}}
\description{
This package is designed for mining the checklist of animals, plants, fungi and micro-organisms both in and outside China.
}
\details{
\packageDESCRIPTION{SP2000}
\packageIndices{SP2000}
}

\author{Maintainer: \packageMaintainer{SP2000}}

\examples{
\dontrun{
#Note: You need to apply for the apiKey <http://sp2000.org.cn/api/document>
to run search_* functions of this package.

##Load "SP2000"

library('SP2000')

##Set your key

set_search_key <- "your apiKey"

##Search family IDs via family name, supports Latin and Chinese names

familyid <- search_family_id(query = "Anguillidae")

##Search taxon IDs via familyID ,scientificName and commonName

taxonid <- search_taxon_id(query = familyid$familyIDs,name = "familyID")

queries = c("Anguilla marmorata","Anguilla japonica",
            "Anguilla bicolor","Anguilla nebulosa",
            "Anguilla luzonensis")

search_taxon_id(query = queries,name = "scientificName")

#Download detailed lists via species or infraspecies ID

checklist1 <- search_checklist(query = taxonid$taxonIDs)

checklist1 <- list_df(checklist1,db = "colchina")

##Get Catalogue of Life Global checklist via species name and id

checklist2 <- get_col_global(query = queries, option = "name")

str(checklist2)

checklist2 <- list_df(checklist2,db = "colglobal")

##Find synonyms via species name from Catalogue of Life Global

find_synonyms(query = queries)

##Search Catalogue of Life Taiwan checklist

get_col_taiwan(query = "Anguilla",tree = "name",option = "contain")

##Query Redlist of Chinese Biodiversity

get_redlist_china(query = "Anguilla", option = "Scientific Names")

}
}

\references{
Ding LY, Li H, Tao J, Zhang JL, Huang MR, Yang K, Wang J, He DM, Ding CZ (2020) SP2000: A package written in R and Python for downloading catalogue of life. Biodiversity Science.

https://cran.r-project.org/package=SP2000

https://pypi.org/project/SP2000

}


\keyword{ package }
