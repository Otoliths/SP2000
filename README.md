<!-- README.md is generated from README.Rmd. Please edit that file -->

# SP2000 <img src="inst/figures/SP2000 China logo.jpg" align="right" width="200" />

[![codecov](https://badge.fury.io/gh/Otoliths%2Fsp2000.svg)](https://badge.fury.io/for/gh/Otoliths/sp2000)
[![CRAN](http://www.r-pkg.org/badges/version/sp2000)](https://cran.r-project.org/package=sp2000)
[![downloads](http://cranlogs.r-pkg.org/badges/sp2000)](https://cran.r-project.org/package=sp2000)
[![Build Status](https://travis-ci.org/Otoliths/sp2000.svg?branch=master)](https://travis-ci.org/easystats/sp2000)
[![codecov](https://codecov.io/gh/Otoliths/sp2000/branch/master/graph/badge.svg)](https://codecov.io/gh/Otoliths/sp2000)

## Overview

Species 2000 (http://sp2000.org.cn) China node is a regional node of the international species 2000 project, proposed by the international species 2000 Secretariat in October 20, 2006, was officially launched in February 7, 2006. Chinese Academy of Sciences, biological diversity Committee (BC-CAS), together with its partners, to support and manage the construction of species 2000 China node. The main task of the species 2000 China node, according to the species 2000 standard data format, the classification information of the distribution in China of all species to finish and check, the establishment and maintenance of Chinese biological species list, to provide free services to users around the world. Note:firstly,You need to apply for the apiKey from http://sp2000.org.cn/api/document to run these functions of this package.



## Install SP2000 package

```{r , eval=F}
# Install dependence packages
packages <- c("jsonlite", "tibble","pbmcapply","purrr","rlist")
package.check <- lapply(packages, FUN = function(x) {
  if (!require(x, character.only = TRUE)) {
    install.packages(x, dependencies = TRUE, repos = "http://cran.us.r-project.org")
    library(x, character.only = TRUE)
  }
})

# Install devtools if not previously installed
if(!"devtools" %in% installed.packages()[,"Package"]) install.packages("devtools")

# Install sp2000 from Github if not previously installed
if(!"sp2000" %in% installed.packages()[,"Package"]) devtools::install_github("Otoliths/SP2000")
```

```{r , eval=F}
# Load the SP2000 package
library(SP2000)
```


## Usage

```{r , eval=F}
#Search family IDs via family name, supports Latin and Chinese names
apiKey <- "your apiKey"
search_familyID(query = "Cyprinidae",apiKey = apiKey)
queries <- c("Rosaceae","Cyprinidae")
search_familyID(query = queries,apiKey = apiKey)
```

```{r , eval=F}
#Search taxon IDs via familyID ,scientificName and commonName
apiKey <- "your apiKey"
search_taxonID(query = "Uncia uncia",name = "scientificName",apiKey = apiKey)
queries <- c("Anguilla marmorata","Uncia uncia")
search_taxonID(query = queries,name = "scientificName",apiKey = apiKey)
search_taxonID(query = "bf72e220caf04592a68c025fc5c2bfb7",name = "familyID",apiKey = apiKey)
```

```{r , eval=F}
# download detailed lists via species or infraspecies ID
apiKey <- "your apiKey"
queries <- c("025397f9-9891-40a7-b90b-5a61f9c7b597","04c59ee8-4b48-4095-be0d-663485463f21",
           "4c539380-8d0a-4cbf-b612-1e6df5850295","522c1cfd-0d2c-490f-b8f8-0c7459f6dba5",
           "6d04dcf5-f390-472d-b674-4f09e43713ed","89c29448-a48f-46cb-a573-ee51dd47e7b0",
           "a3452c0c-6d75-465b-b110-537e4ac15f80","a69df232-07e4-4f06-9651-a4e52796f01a",
           "b8c6a086-3d28-4876-8e8a-ca96e667768d","c1dbe9f7-e02f-4f05-a1ca-1487a41075bd",
           "d5938c75-e51a-4737-aaef-4f342fa8b364","f95f766f-7b96-464a-bff5-43b1adafcf50",
           "faaf346f-49f4-400a-947b-edb6b0f6bd5e")           
x2 <- search_checklist(query = queries,apiKey = apiKey)
```

```{r , eval=F}
# checklist lists convert data frame
x3 <- lis_tdf(x2)
```

## How to cite this work

```{r , eval=F}
Catalogue of Life China: 
The Biodiversity Committee of Chinese Academy of Sciences, 2019, Catalogue of Life China: 2019 Annual Checklist, Beijing, China

How to cite individual databases included in this work, for example:

Animal: 
JI Liqiang, et al, 2019, China Checklist of Animals, In the Biodiversity Committee of Chinese Academy of Sciences ed., Catalogue of Life China: 2019 Annual Checklist, Beijing, China

Plant: 
QIN Haining, et al, 2019, China Checklist of Higher Plants, In the Biodiversity Committee of Chinese Academy of Sciences ed., Catalogue of Life China: 2019 Annual Checklist, Beijing, China

Fungi: 
YAO Yijian, et al, 2019, China Checklist of Fungi, In the Biodiversity Committee of Chinese Academy of Sciences ed., Catalogue of Life China: 2019 Annual Checklist, Beijing, China

How to cite taxon included in this work, for example:

Aix galericulata: 
LEI Fumin, et al, 2019. Aix galericulata in Catalogue of Life China: 2019 Annual Checklist, Beijing, China. http://sp2000.org.cn/species/show_species_details/f3bc32a7-50ec-41cc-91ee-a990b9196838
```
