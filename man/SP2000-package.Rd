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
# Note: You need to apply for the apiKey <http://sp2000.org.cn/api/document>
to run search_* functions of this package.

## Load "SP2000"

library('SP2000')

## Set your key

set_search_key("your apiKey",db = "sp2000")

## Search family IDs via family name, supports Latin and Chinese names

familyid <- search_family_id(query = "Anguillidae")

## Search taxon IDs via familyID ,scientificName and commonName

query <- familyid$Anguillidae$data$record_id

taxonid <- search_taxon_id(query = query,name = "familyID")

queries = c("Anguilla marmorata","Anguilla japonica",
            "Anguilla bicolor","Anguilla nebulosa",
            "Anguilla luzonensis")

search_taxon_id(query = queries,name = "scientificName")

## Download detailed lists via species or infraspecies ID

query <- taxonid[["3851c5311bed46c19529cb155d37aa9b"]][["data"]][["namecode"]]

checklist <- search_checklist(query = query)


## Get Catalogue of Life Global checklist via species name and id

x <- get_col_global(query = "Anguilla", response = "full")

str(x)

x[["Anguilla"]][["meta"]][["total_number_of_results"]] [1]

## Find synonyms via species name from Catalogue of Life Global

find_synonyms(query = queries)

## Search Catalogue of Life Taiwan checklist

get_col_taiwan(query = "Anguillidae", level = "family")

## Query Redlist of Chinese Biodiversity

get_redlist_china(query = "Anguilla", option = "Scientific Names")

}
}

\references{
Ding LY, Li H, Tao J, Zhang JL, Huang MR, Yang K, Wang J, He DM, Ding CZ (2020) SP2000: An open-sourced R package for querying the Catalogue of Life. Biodiversity Science.

https://cran.r-project.org/package=SP2000

https://pypi.org/project/SP2000

}


\keyword{ package }
