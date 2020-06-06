<!-- README.md is generated from README.Rmd. Please edit that file -->

## SP2000 <img src="inst/figures/logo.png" align="right" width="140" />

[![CRAN Version](http://www.r-pkg.org/badges/version/SP2000)](https://cran.r-project.org/package=SP2000)
[![codecov](https://badge.fury.io/gh/Otoliths%2FSP2000.svg)](https://badge.fury.io/for/gh/Otoliths/SP2000)
[![Build Status](https://travis-ci.org/Otoliths/SP2000.svg?branch=master)](https://travis-ci.org/easystats/SP2000)
![R-CMD-check](https://github.com/Otoliths/SP2000/workflows/R-CMD-check/badge.svg)
[![CI](https://github.com/Otoliths/SP2000/workflows/CI/badge.svg)](https://github.com/Otoliths/SP2000/actions?query=workflow%3ACI)
[![Rdoc](https://www.rdocumentation.org/badges/version/SP2000)](https://www.rdocumentation.org/packages/SP2000)

<!-- r badge_devel("Otoliths/sp2000", "blue") -->
[![](https://cranlogs.r-pkg.org/badges/grand-total/SP2000?color=orange)](https://cran.r-project.org/package=SP2000)
[![](https://cranlogs.r-pkg.org/badges/SP2000?color=orange)](https://cranlogs.r-pkg.org/downloads/total/last-month/SP2000)
[![](https://cranlogs.r-pkg.org/badges/last-week/SP2000?color=orange)](https://cranlogs.r-pkg.org/downloads/total/last-week/SP2000)


This [**SP2000**](https://cran.r-project.org/package=SP2000) package programatically download catalogue of the Chinese known species of animals, plants, fungi and micro-organisms. There are __122280__ species & infraspecific taxa in [2020 Annual Checklist of Catalogue of Life China](http://sp2000.org.cn/2019), including __110231__ species and __12049__ infraspecific taxa.This package also supports access to catalogue of life global <http://catalogueoflife.org> and catalogue of life Taiwan <http://taibnet.sinica.edu.tw/home_eng.php?>.



## Overview 

[![](https://img.shields.io/badge/Contact%20us%20on-WeChat-blue.svg)](https://gitee.com/LiuyongDing/latest_literature/raw/master/bad.png)
[![](https://img.shields.io/badge/Follow%20me%20on-WeChat-green.svg)](https://gitee.com/LiuyongDing/latest_literature/raw/master/img.png)

[**Species 2000**](http://sp2000.org.cn) China node is a regional node of the international species 2000 project, proposed by the international species 2000 Secretariat in October 20, 2006, was officially launched in February 7, 2006. Chinese Academy of Sciences, biological diversity Committee (BC-CAS), together with its partners, to support and manage the construction of species 2000 China node. The main task of the species 2000 China node, according to the species 2000 standard data format, the classification information of the distribution in China of all species to finish and check, the establishment and maintenance of Chinese biological species list, to provide free services to users around the world.


## Installation

### Current official release:
```r
install.packages("SP2000")
```

### Current beta / GitHub release:

Installation using R package
[**remotes**](https://cran.r-project.org/package=remotes):
```r
if (!requireNamespace("remotes", quietly=TRUE))
    install.packages("remotes")
    
remotes::install_github("Otoliths/SP2000")

#or
remotes::install_git("git://github.com/Otoliths/SP2000.git")

#or
remotes::install_gitlab("Otoliths/SP2000")

```

## Usage

##### Note: You need to apply for the [*apiKey*](http://sp2000.org.cn/api/document) to run search_* functions of this package.

Load the **SP2000** package
```r
library(SP2000)
```
###### Search family IDs via family name
```r
set_search_key <- "your apiKey"
familyid <- search_family_id(query = "Anguillidae")
familyid
```
```r
# last Update: 2020-06-06
# A tibble: 1 x 3
# family      familyIDs                        download.date
# <chr>       <chr>                            <date>       
#   1 Anguillidae 3851c5311bed46c19529cb155d37aa9b 2020-06-06   

```
###### Search taxon IDs via familyID
```r
taxonid1 <- search_taxon_id(query = familyid$familyIDs,name = "familyID")
taxonid1
```
```r
# last Update: 2020-06-06
# # A tibble: 5 x 3
# familyID                         taxonIDs                         download.date
# <chr>                            <chr>                            <date>       
# 1 3851c5311bed46c19529cb155d37aa9b 1bcb107bcbf74c6eb81554e398beb840 2020-06-06   
# 2 3851c5311bed46c19529cb155d37aa9b 9b9b328f6fa045089021ba38f912a0e8 2020-06-06   
# 3 3851c5311bed46c19529cb155d37aa9b cbf03e5022f94c3daad91843b9f0b1e7 2020-06-06   
# 4 3851c5311bed46c19529cb155d37aa9b e192fbc15df24049bcd0fd01d307affa 2020-06-06   
# 5 3851c5311bed46c19529cb155d37aa9b f542929f776246efa44e559c389139d8 2020-06-06    
```
###### Search taxon IDs via scientificName
```r
queries <- c("Anguilla marmorata","Anguilla japonica",
             "Anguilla bicolor","Anguilla nebulosa",
             "Anguilla luzonensis")
taxonid2 <- search_taxon_id(query = queries,name = "scientificName")
taxonid2
```
```r
# last Update: 2020-06-06
#  |=============================================================================================| 100%, Elapsed 00:01
# # A tibble: 5 x 3
# scientificName      taxonIDs                         download.date
# <chr>               <chr>                            <date>       
# 1 Anguilla marmorata  e192fbc15df24049bcd0fd01d307affa 2020-06-06   
# 2 Anguilla japonica   f542929f776246efa44e559c389139d8 2020-06-06   
# 3 Anguilla bicolor    1bcb107bcbf74c6eb81554e398beb840 2020-06-06   
# 4 Anguilla nebulosa   9b9b328f6fa045089021ba38f912a0e8 2020-06-06   
# 5 Anguilla luzonensis cbf03e5022f94c3daad91843b9f0b1e7 2020-06-06   

```
###### Download detailed lists via species or infraspecies ID
```r
x1 <- search_checklist(query = taxonid1$taxonIDs)
x2 <- search_checklist(query = taxonid2$taxonIDs)
class(x1)
class(x2)
```
```r
# last Update: 2020-06-06
# |======================================================================================| 100%, Elapsed 00:01
# [1] "list"
```

```r
list_df(x1,db = "colchina")
list_df(x2,db = "colchina")
```
```r
# # A tibble: 5 x 19
# ScientificName[… Synonyms chineseName[,1] CommonNames Kingdom[,1] Phylum[,1] Class[,1] Order[,1] Family[,1]
# <chr>            <list>   <chr>           <list>      <chr>       <chr>      <chr>     <chr>     <chr>     
# 1 Anguilla bicolo… <df[,2]… 双色鳗鲡        <chr [1]>   Animalia    Chordata   Actinopt… Anguilli… Anguillid…
# 2 Anguilla nebulo… <df[,1]… 云纹鳗鲡        <list [0]>  Animalia    Chordata   Actinopt… Anguilli… Anguillid…
# 3 Anguilla luzone… <df[,2]… 吕宋鳗鲡        <list [0]>  Animalia    Chordata   Actinopt… Anguilli… Anguillid…
# 4 Anguilla marmor… <df[,1]… 花鳗鲡          <list [0]>  Animalia    Chordata   Actinopt… Anguilli… Anguillid…
# 5 Anguilla japoni… <df[,2]… 鳗鲡            <chr [1]>   Animalia    Chordata   Actinopt… Anguilli… Anguillid…
# # … with 18 more variables: Genus[,1] <chr>, Species[,1] <chr>, Infraspecies[,1] <chr>, Distribution[,1] <chr>,
# #   Name[,1] <chr>, [,2] <chr>, [,3] <chr>, Email[,1] <chr>, [,2] <chr>, [,3] <chr>, Address[,1] <chr>,
# #   [,2] <chr>, [,3] <chr>, Institution[,1] <chr>, [,2] <chr>, [,3] <chr>, References <list>, Downloaddate <date>
```

###### Get Catalogue of Life Global checklist via species name and id
```r
x3 <- get_colglobal(query = queries, option = "name")
class(x3)
```
```r
# last Update: 2020-06-06
# |======================================================================================| 100%, Elapsed 00:01
# [1] "list"
```
```r
list_df(x3,db = "colglobal")
```
```r
# # A tibble: 9 x 5
# `Anguilla marmorata` `Anguilla japonica` `Anguilla bicolor` `Anguilla nebulosa` `Anguilla luzonensis`
# <named list>         <named list>        <named list>       <named list>        <named list>         
#   1 <chr [1]>            <chr [1]>           <chr [1]>          <chr [1]>           <chr [1]>            
#   2 <chr [1]>            <chr [1]>           <chr [1]>          <chr [1]>           <chr [1]>            
#   3 <int [1]>            <int [1]>           <int [1]>          <int [1]>           <int [1]>            
#   4 <int [1]>            <int [1]>           <int [1]>          <int [1]>           <int [1]>            
#   5 <int [1]>            <int [1]>           <int [1]>          <int [1]>           <int [1]>            
#   6 <chr [1]>            <chr [1]>           <chr [1]>          <chr [1]>           <chr [1]>            
#   7 <chr [1]>            <chr [1]>           <chr [1]>          <chr [1]>           <chr [1]>            
#   8 <chr [1]>            <chr [1]>           <chr [1]>          <chr [1]>           <chr [1]>            
#   9 <df[,24] [2 × 24]>   <df[,12] [1 × 12]>  <df[,24] [3 × 24]> <df[,24] [4 × 24]>  <df[,12] [1 × 12]> 
```

###### Find synonyms via species name from Catalogue of Life Global
```r
find_synonyms(queries)
```
```r
# last Update: 2020-06-06
# |=========================================================================================| 100%, Elapsed 00:05
# Find 8 results of synonyms for Anguilla marmorata are as follows: 
# Find 6 results of synonyms for Anguilla japonica are as follows: 
# Find 23 results of synonyms for Anguilla bicolor are as follows: 
# Find 4 results of synonyms for Anguilla nebulosa are as follows: 
# Find 1 results of synonyms for Anguilla luzonensis are as follows: 
# $`Anguilla marmorata`
# [1] "Anguilla fidjiensis"   "Anguilla hildebrandti" "Anguilla johannae"     "Anguilla labrosa"     
# [5] "Anguilla marmolata"    "Anguilla mauritiana"   "Muraena manillensis"   "Muraena mossambica"   
# 
# $`Anguilla japonica`
# [1] "Anguilla angustidens" "Anguilla breviceps"   "Anguilla manabei"     "Anguilla nigricans"  
# [5] "Anguilla remifera"    "Muraena pekinensis"  
# 
# $`Anguilla bicolor`
# [1] "Anguilla amblodon"          "Anguilla australis"         "Anguilla bicolor bicolor"  
# [4] "Anguilla bicolor pacifica"  "Anguilla bicolour"          "Anguilla bicolour bicolour"
# [7] "Anguilla bleekeri"          "Anguilla cantori"           "Anguilla dussumieri"       
# [10] "Anguilla malabarica"        "Anguilla malgumora"         "Anguilla mauritiana"       
# [13] "Anguilla moa"               "Anguilla mowa"              "Anguilla pacifica"         
# [16] "Anguilla sidat"             "Anguilla spengeli"          "Anguilla virescens"        
# [19] "Muraena halmaherensis"      "Muraena macrocephala"       "Muraena moa"               
# [22] "Muraena mossambica"         "Muraena virescens"         
# 
# $`Anguilla nebulosa`
# [1] "Anguilla bengalensis"       "Anguilla elphinstonei"      "Anguilla nebulosa nebulosa"
# [4] "Muraena maculata"          
# 
# $`Anguilla luzonensis`
# [1] "Anguilla huangi"                        
```

###### Search Catalogue of Life Taiwan checklist
```r
get_col_taiwan(query="Anguilla",tree="name",option = "contain")
```
```r
# last Update: 2020-06-06
# # A tibble: 5 x 23
# name_code kingdom kingdom_c phylum phylum_c class class_c order order_c family family_c genus genus_c species
# <chr>     <chr>   <chr>     <chr>  <chr>    <chr> <chr>   <chr> <chr>   <chr>  <chr>    <chr> <chr>   <chr>  
# 1 380710    Animal… 動物界    Chord… 脊索動物門… Acti… 條鰭魚綱… Angu… 鰻形目  Angui… 鰻鱺科   Angu… 鰻鱺屬  bicolor
# 2 395489    Animal… 動物界    Chord… 脊索動物門… Acti… 條鰭魚綱… Angu… 鰻形目  Angui… 鰻鱺科   Angu… 鰻鱺屬  celebe…
# 3 380711    Animal… 動物界    Chord… 脊索動物門… Acti… 條鰭魚綱… Angu… 鰻形目  Angui… 鰻鱺科   Angu… 鰻鱺屬  japoni…
# 4 395491    Animal… 動物界    Chord… 脊索動物門… Acti… 條鰭魚綱… Angu… 鰻形目  Angui… 鰻鱺科   Angu… 鰻鱺屬  luzone…
# 5 380712    Animal… 動物界    Chord… 脊索動物門… Acti… 條鰭魚綱… Angu… 鰻形目  Angui… 鰻鱺科   Angu… 鰻鱺屬  marmor…
# # … with 9 more variables: infraspecies_marker <chr>, infraspecies <chr>, infraspecies2_marker <chr>,
# #   infraspecies2 <chr>, author <chr>, author2 <chr>, common_name_c <chr>, endemic <chr>, dataprovider <chr>
# 

```

###### Query Redlist of Chinese Biodiversity
```r
get_redlist_china(query = "Anguilla", option = "Scientific Names")
```
```r
# last Update: 2020-06-06
# # A tibble: 4 x 11
# `Chinese Family… Family `Chinese Names` ScientificNames Status `Assessment Cri… Endemic Taxon `Chinese Taxon`
# <chr>            <chr>  <chr>           <chr>           <chr>  <chr>            <chr>   <chr> <chr>          
# 1 鳗鲡科           Angui… 日本鳗鲡        Anguilla japon… EN     A2bcd            NA      Inla… 内陆鱼类       
# 2 鳗鲡科           Angui… 花鳗鲡          Anguilla marmo… EN     A2bcd            NA      Inla… 内陆鱼类       
# 3 鳗鲡科           Angui… 双色鳗鲡        Anguilla bicol… NT     NA               NA      Inla… 内陆鱼类       
# 4 鳗鲡科           Angui… 云纹鳗鲡        Anguilla nebul… NT     NA               NA      Inla… 内陆鱼类       
# # … with 2 more variables: Group <chr>, `Chinese Group` <chr>
```
```r
sessionInfo()
```
```r
# R version 4.0.0 (2020-04-24)
# Platform: x86_64-apple-darwin17.0 (64-bit)
# Running under: macOS Catalina 10.15.5
# 
# Matrix products: default
# BLAS:   /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib
# LAPACK: /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRlapack.dylib
# 
# locale:
#   [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
# 
# attached base packages:
#   [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
#   [1] SP2000_0.0.10
# 
# loaded via a namespace (and not attached):
# [1] Rcpp_1.0.4.6      rstudioapi_0.11   magrittr_1.5      rlang_0.4.6       fansi_0.4.1       tools_4.0.0      
# [7] parallel_4.0.0    DT_0.13           data.table_1.12.8 utf8_1.1.4        cli_2.0.2         htmltools_0.4.0  
# [13] ellipsis_0.3.1    assertthat_0.2.1  digest_0.6.25     tibble_3.0.1      lifecycle_0.2.0   crayon_1.3.4     
# [19] pbmcapply_1.5.0   purrr_0.3.4       htmlwidgets_1.5.1 vctrs_0.3.0       curl_4.3          rlist_0.4.6.1    
# [25] glue_1.4.1        compiler_4.0.0    pillar_1.4.4      XML_3.99-0.3      jsonlite_1.6.1    pkgconfig_2.0.3 
```

## Contribution

Contributions to this package are welcome. 
The preferred method of contribution is through a GitHub pull request. 
Feel also free to contact us by creating [**an issue**](https://github.com/Otoliths/sp2000/issues).

## Acknowledgment

The development of this [**SP2000**](https://cran.r-project.org/package=SP2000) package were supported by the Biodiversity Survey and Assessment Project of the Ministry of Ecology and Environment, China ([**2019HJ2096001006**](http://www.mee.gov.cn/xxgk/zfcg/zbxx09/201906/t20190620_707171.shtml)) and the Yunnan University's Research Innovation Fund for Graduate Students.


### How to cite this package
```r
citation("SP2000")
```
```r
To cite package ‘SP2000’ in publications use:

  Liuyong Ding (2020). SP2000: Catalogue of Life Toolkit. R package version 0.0.10.
  https://github.com/Otoliths/SP2000

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {SP2000: Catalogue of Life Toolkit},
    author = {Liuyong Ding},
    year = {2020},
    note = {R package version 0.0.10},
    url = {https://github.com/Otoliths/SP2000},
  }
```
### [How to cite this work](http://sp2000.org.cn/info/info_how_to_cite)

```r
Catalogue of Life China: 
The Biodiversity Committee of Chinese Academy of Sciences, 2020, Catalogue of Life China: 2020 Annual Checklist, Beijing, China

How to cite individual databases included in this work, for example:

Animal: 
JI Liqiang, et al, 2020, China Checklist of Animals, In the Biodiversity Committee of Chinese Academy of Sciences ed., Catalogue of Life China: 2020 Annual Checklist, Beijing, China

Plant: 
QIN Haining, et al, 2020, China Checklist of Higher Plants, In the Biodiversity Committee of Chinese Academy of Sciences ed., Catalogue of Life China: 2020 Annual Checklist, Beijing, China

Fungi: 
YAO Yijian, et al, 2020, China Checklist of Fungi, In the Biodiversity Committee of Chinese Academy of Sciences ed., Catalogue of Life China: 2020 Annual Checklist, Beijing, China

How to cite taxon included in this work, for example:

Aix galericulata: 
LEI Fumin, et al, 2020. Aix galericulata in Catalogue of Life China: 2020 Annual Checklist, Beijing, China. http://sp2000.org.cn/species/show_species_details/f3bc32a7-50ec-41cc-91ee-a990b9196838
```
