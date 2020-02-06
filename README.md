<!-- README.md is generated from README.Rmd. Please edit that file -->

# sp2000 <img src="man/figures/logo.png" align="right" width="120" />

## Overview

Species 2000 (http://col.especies.cn) China node is a regional node of the international species 2000 project, proposed by the international species 2000 Secretariat in October 20, 2006, was officially launched in February 7, 2006.Chinese Academy of Sciences, biological diversity Committee (BC-CAS), together with its partners, to support and manage the construction of species 2000 China node. The main task of the species 2000 China node, according to the species 2000 standard data format, the classification information of the distribution in China of all species to finish and check, the establishment and maintenance of Chinese biological species list, to provide free services to users around the world. Note:firstly,You need to apply for the apiKey from http://col.especies.cn/api/document to run these functions of this package.



## Install sp2000 package

```{r , eval=F}
# Install dependence packages
packages <- c("jsonlite", "tibble","parallel","purrr","rlist")
package.check <- lapply(packages, FUN = function(x) {
  if (!require(x, character.only = TRUE)) {
    install.packages(x, dependencies = TRUE, repos = "http://cran.us.r-project.org")
    library(x, character.only = TRUE)
  }
})

# Install remotes if not previously installed
if(!"devtools" %in% installed.packages()[,"Package"]) install.packages("devtools")

# Install sp2000 from Github if not previously installed
if(!"sp2000" %in% installed.packages()[,"Package"]) devtools::install_github("Otoliths/sp2000")
```

```{r , eval=F}
# Load the sp2000 package
library(sp2000)
```


## Examples

```{r , eval=F}
#download taxon IDs via familyID ,scientificName and commonName
taxonID(query="鳗鲡",name="commonName",apiKey="")

query <- c("鳗鲡","裂腹鱼")

taxonIDs <- lapply(query,taxonID,name='commonName')

(taxonIDs <- purrr::transpose(taxonIDs))
```

```{r , eval=F}
# download detailed lists via species or infraspecies ID
x1 <- sp2000(query="025397f9-9891-40a7-b90b-5a61f9c7b597",apiKey=" ")

query <- c("025397f9-9891-40a7-b90b-5a61f9c7b597","04c59ee8-4b48-4095-be0d-663485463f21",
           "4c539380-8d0a-4cbf-b612-1e6df5850295","522c1cfd-0d2c-490f-b8f8-0c7459f6dba5",
           "6d04dcf5-f390-472d-b674-4f09e43713ed","89c29448-a48f-46cb-a573-ee51dd47e7b0",
           "a3452c0c-6d75-465b-b110-537e4ac15f80","a69df232-07e4-4f06-9651-a4e52796f01a",
           "b8c6a086-3d28-4876-8e8a-ca96e667768d","c1dbe9f7-e02f-4f05-a1ca-1487a41075bd",
           "d5938c75-e51a-4737-aaef-4f342fa8b364","f95f766f-7b96-464a-bff5-43b1adafcf50",
           "faaf346f-49f4-400a-947b-edb6b0f6bd5e")
           
x2 <- sp2000(query=query,apiKey=" ")
```

```{r , eval=F}
# lists convert data frame
x3 <- listdf(x2)
```
