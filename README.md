<!-- README.md is generated from README.Rmd. Please edit that file -->

## SP2000 <img src="inst/figures/logo.png" align="right" width="140" />

[![CRAN Version](http://www.r-pkg.org/badges/version/SP2000)](https://cran.r-project.org/package=SP2000)
[![codecov](https://badge.fury.io/gh/Otoliths%2FSP2000.svg)](https://badge.fury.io/for/gh/Otoliths/SP2000)
[![R-CMD-check](https://github.com/Otoliths/SP2000/workflows/R-CMD-check/badge.svg)](https://github.com/Otoliths/SP2000/actions?query=workflow%3AR-CMD-check)
[![Rdoc](https://www.rdocumentation.org/badges/version/SP2000)](https://www.rdocumentation.org/packages/SP2000)

<!-- r badge_devel("Otoliths/sp2000", "blue") -->
[![](https://cranlogs.r-pkg.org/badges/grand-total/SP2000?color=orange)](https://cran.r-project.org/package=SP2000)
[![](https://cranlogs.r-pkg.org/badges/SP2000?color=orange)](https://cranlogs.r-pkg.org/downloads/total/last-month/SP2000)
[![](https://cranlogs.r-pkg.org/badges/last-week/SP2000?color=orange)](https://cranlogs.r-pkg.org/downloads/total/last-week/SP2000)


This [**SP2000**](https://cran.r-project.org/package=SP2000) package programatically download catalogue of the Chinese known species of animals, plants, fungi and micro-organisms. There are __122280__ species & infraspecific taxa in [2020 Annual Checklist of Catalogue of Life China](http://sp2000.org.cn/2019), including __110231__ species and __12049__ infraspecific taxa.This package also supports access to catalogue of life global <http://catalogueoflife.org> , China animal scientific database <http://zoology.especies.cn> and catalogue of life Taiwan <http://taibnet.sinica.edu.tw/home_eng.php?>.



## Overview 

[![](https://img.shields.io/badge/Contact%20us%20on-WeChat-blue.svg)](https://gitee.com/LiuyongDing/latest_literature/raw/master/bad.png)
[![](https://img.shields.io/badge/Follow%20me%20on-WeChat-green.svg)](https://gitee.com/LiuyongDing/latest_literature/raw/master/img.png)

[**Species 2000**](http://sp2000.org.cn) China node is a regional node of the international species 2000 project, proposed by the international species 2000 Secretariat in October 20, 2006, was officially launched in February 7, 2006. Chinese Academy of Sciences, biological diversity Committee (BC-CAS), together with its partners, to support and manage the construction of species 2000 China node. The main task of the species 2000 China node, according to the species 2000 standard data format, the classification information of the distribution in China of all species to finish and check, the establishment and maintenance of Chinese biological species list, to provide free services to users around the world.


### Libraries

You might be able to avoid reading all this documentation if you instead use one of the several excellent libraries that have been written for the Catalogue of Life API. For example:

- [SP2000](https://github.com/Otoliths/SP2000) (R, developed by Liuyong Ding)
- [general](https://github.com/CatalogueOfLife/general) (R,developed by CoL Global Team)
- [colpluz](https://github.com/ropensci/colpluz) (R,developed by ropensci)
- [SP2000](https://github.com/ynulihao/SP2000) (Python,developed by Hao Li)
- [coldpy](https://github.com/gdower/coldpy) (Python)
- [coldp](https://github.com/CatalogueOfLife/coldp) (SQL)
- [data](https://github.com/CatalogueOfLife/data) (SQL)
- [backend](https://github.com/CatalogueOfLife/backend) (Java)
- [clearinghouse-ui](https://github.com/CatalogueOfLife/clearinghouse-ui) (Java)
- [portal](https://github.com/CatalogueOfLife/portal) (Java)
- [taicol-db-docker](https://github.com/TaiBIF/taicol-db-docker) (Shell)
- [zbank](https://github.com/ropensci/zbank) (R,developed by ropensci)


## Installation

### Current official release:
```r
install.packages("SP2000")
```

### Current beta / GitHub release:

Installation using R package
[**remotes**](https://cran.r-project.org/package=remotes):
```r
if (!requireNamespace("remotes", quietly = TRUE))
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
set_search_key("your apiKey",db = "sp2000")

familyid <- search_family_id(query = "Anguillidae")
str(familyid)
```
```r
List of 1
 $ Anguillidae:List of 2
  ..$ meta:List of 5
  .. ..$ code   : int 200
  .. ..$ limit  : int 20
  .. ..$ count  : int 1
  .. ..$ page   : int 1
  .. ..$ message: chr "success"
  ..$ data: tibble [1 × 14] (S3: tbl_df/tbl/data.frame)
  .. ..$ family_c     : chr "鳗鲡科"
  .. ..$ phylum_c     : chr "脊索动物门"
  .. ..$ superfamily  : logi NA
  .. ..$ kingdom      : chr "Animalia"
  .. ..$ record_id    : chr "3851c5311bed46c19529cb155d37aa9b"
  .. ..$ phylum       : chr "Chordata"
  .. ..$ kingdom_c    : chr "动物界"
  .. ..$ family       : chr "Anguillidae"
  .. ..$ class        : chr "Actinopterygii"
  .. ..$ class_c      : chr "辐鳍鱼纲"
  .. ..$ order_c      : chr "鳗鲡目"
  .. ..$ order        : chr "Anguilliformes"
  .. ..$ superfamily_c: logi NA
  .. ..$ download_date: Date[1:1], format: "2020-08-04"
```
###### Search taxon IDs via familyID
```r
taxonid1 <- search_taxon_id(query = familyid$Anguillidae$data$record_id,name = "familyID")
str(taxonid1[["3851c5311bed46c19529cb155d37aa9b"]][["meta"]])
```
```r
List of 5
 $ code   : int 200
 $ limit  : int 20
 $ count  : int 5
 $ page   : int 1
 $ message: chr "success"  
```
###### Search taxon IDs via scientificName
```r
queries <- c("Anguilla marmorata","Anguilla japonica",
             "Anguilla bicolor","Anguilla nebulosa",
             "Anguilla luzonensis")
taxonid2 <- search_taxon_id(query = queries,name = "scientificName")
str(taxonid2[["Anguilla marmorata"]])
```
```r
List of 2
 $ meta:List of 5
  ..$ code   : int 200
  ..$ limit  : int 20
  ..$ count  : int 1
  ..$ page   : int 1
  ..$ message: chr "success"
 $ data:'data.frame':	1 obs. of  5 variables:
  ..$ accepted_name_info:'data.frame':	1 obs. of  11 variables:
  .. ..$ searchCodeStatus: chr "accepted name"
  .. ..$ namecode        : chr "e192fbc15df24049bcd0fd01d307affa"
  .. ..$ scientificName  : chr "Anguilla marmorata"
  .. ..$ author          : chr "Quoy et Gaimard，1824"
  .. ..$ Refs            :List of 1
  .. .. ..$ :'data.frame':	2 obs. of  2 variables:
  .. .. .. ..$ [1]: chr [1:2] "" NA
  .. .. .. ..$ [2]: chr [1:2] NA ""
  .. ..$ Distribution    : chr "Zhejiang(浙江)"
  .. ..$ taxonTree       :'data.frame':	1 obs. of  8 variables:
  .. .. ..$ phylum      : chr "Chordata"
  .. .. ..$ genus       : chr "Anguilla"
  .. .. ..$ species     : chr "marmorata"
  .. .. ..$ infraspecies: chr ""
  .. .. ..$ family      : chr "Anguillidae"
  .. .. ..$ kingdom     : chr "Animalia"
  .. .. ..$ class       : chr "Actinopterygii"
  .. .. ..$ order       : chr "Anguilliformes"
  .. ..$ chineseName     : chr "花鳗鲡"
  .. ..$ searchCode      : chr "e192fbc15df24049bcd0fd01d307affa"
  .. ..$ CommonNames     :List of 1
  .. .. ..$ : list()
  .. ..$ SpecialistInfo  :List of 1
  .. .. ..$ :'data.frame':	3 obs. of  4 variables:
  .. .. .. ..$ E-Mail     : chr [1:3] "zhangcg@ioz.ac.cn" "zoskt@gate.sinica.edu.tw" ""
  .. .. .. ..$ Address    : chr [1:3] "1 Beichen West Road, Chaoyang District, Beijing 100101, P.R.China(北京市朝阳区北辰西路1号院5号 中国科学院动物研究所)" "()" "No.999, Huchenghuan Rd , Nanhui New City, Shanghai, P.R. China(上海市浦东新区沪城环路999号)"
  .. .. .. ..$ name       : chr [1:3] "Zhang Chunguang(张春光)" "Shao, Kwang-Tsao(邵广昭)" "Wu Hanlin(伍汉霖)"
  .. .. .. ..$ Institution: chr [1:3] "Institute of Zoology, Chinese Academy of Sciences(中国科学院动物研究所)" "(中央研究院生物多樣性研究中心)" "College of Life Science & Technology, Shanghai Ocean University(上海海洋大学生命科学与技术学院)"
  ..$ name_code         : chr "e192fbc15df24049bcd0fd01d307affa"
  ..$ name_status       : chr "accepted name"
  ..$ scientific_name   : chr "Anguilla marmorata"
  ..$ download_date     : Date[1:1], format: "2020-08-04"
```
###### Download detailed lists via species or infraspecies ID
```r
x1 <- search_checklist(query = taxonid1[["3851c5311bed46c19529cb155d37aa9b"]][["data"]][["namecode"]])
x2 <- search_checklist(query = taxonid2[["Anguilla marmorata"]][["data"]][["name_code"]])

```
```r
str(x1[["Anguilla marmorata"]])
```

```r
List of 2
 $ meta:List of 2
  ..$ code   : int 200
  ..$ message: chr "success"
 $ data:List of 12
  ..$ searchCodeStatus: chr "accepted name"
  ..$ namecode        : chr "e192fbc15df24049bcd0fd01d307affa"
  ..$ scientificName  : chr "Anguilla marmorata"
  ..$ author          : chr "Quoy et Gaimard，1824"
  ..$ Refs            : chr [1:2] "" ""
  ..$ Distribution    : chr "Zhejiang(浙江)"
  ..$ taxonTree       : tibble [1 × 8] (S3: tbl_df/tbl/data.frame)
  .. ..$ phylum      : chr "Chordata"
  .. ..$ genus       : chr "Anguilla"
  .. ..$ species     : chr "marmorata"
  .. ..$ infraspecies: chr ""
  .. ..$ family      : chr "Anguillidae"
  .. ..$ kingdom     : chr "Animalia"
  .. ..$ class       : chr "Actinopterygii"
  .. ..$ order       : chr "Anguilliformes"
  ..$ chineseName     : chr "花鳗鲡"
  ..$ searchCode      : chr "e192fbc15df24049bcd0fd01d307affa"
  ..$ CommonNames     : list()
  ..$ SpecialistInfo  :'data.frame':	3 obs. of  4 variables:
  .. ..$ E-Mail     : chr [1:3] "zhangcg@ioz.ac.cn" "zoskt@gate.sinica.edu.tw" ""
  .. ..$ Address    : chr [1:3] "1 Beichen West Road, Chaoyang District, Beijing 100101, P.R.China(北京市朝阳区北辰西路1号院5号 中国科学院动物研究所)" "()" "No.999, Huchenghuan Rd , Nanhui New City, Shanghai, P.R. China(上海市浦东新区沪城环路999号)"
  .. ..$ name       : chr [1:3] "Zhang Chunguang(张春光)" "Shao, Kwang-Tsao(邵广昭)" "Wu Hanlin(伍汉霖)"
  .. ..$ Institution: chr [1:3] "Institute of Zoology, Chinese Academy of Sciences(中国科学院动物研究所)" "(中央研究院生物多樣性研究中心)" "College of Life Science & Technology, Shanghai Ocean University(上海海洋大学生命科学与技术学院)"
  ..$ download_date   : Date[1:1], format: "2020-08-04"
```

```r
str(x2)
```

```r
List of 1
 $ Anguilla marmorata:List of 2
  ..$ meta:List of 2
  .. ..$ code   : int 200
  .. ..$ message: chr "success"
  ..$ data:List of 12
  .. ..$ searchCodeStatus: chr "accepted name"
  .. ..$ namecode        : chr "e192fbc15df24049bcd0fd01d307affa"
  .. ..$ scientificName  : chr "Anguilla marmorata"
  .. ..$ author          : chr "Quoy et Gaimard，1824"
  .. ..$ Refs            : chr [1:2] "" ""
  .. ..$ Distribution    : chr "Zhejiang(浙江)"
  .. ..$ taxonTree       : tibble [1 × 8] (S3: tbl_df/tbl/data.frame)
  .. .. ..$ phylum      : chr "Chordata"
  .. .. ..$ genus       : chr "Anguilla"
  .. .. ..$ species     : chr "marmorata"
  .. .. ..$ infraspecies: chr ""
  .. .. ..$ family      : chr "Anguillidae"
  .. .. ..$ kingdom     : chr "Animalia"
  .. .. ..$ class       : chr "Actinopterygii"
  .. .. ..$ order       : chr "Anguilliformes"
  .. ..$ chineseName     : chr "花鳗鲡"
  .. ..$ searchCode      : chr "e192fbc15df24049bcd0fd01d307affa"
  .. ..$ CommonNames     : list()
  .. ..$ SpecialistInfo  :'data.frame':	3 obs. of  4 variables:
  .. .. ..$ E-Mail     : chr [1:3] "zhangcg@ioz.ac.cn" "zoskt@gate.sinica.edu.tw" ""
  .. .. ..$ Address    : chr [1:3] "1 Beichen West Road, Chaoyang District, Beijing 100101, P.R.China(北京市朝阳区北辰西路1号院5号 中国科学院动物研究所)" "()" "No.999, Huchenghuan Rd , Nanhui New City, Shanghai, P.R. China(上海市浦东新区沪城环路999号)"
  .. .. ..$ name       : chr [1:3] "Zhang Chunguang(张春光)" "Shao, Kwang-Tsao(邵广昭)" "Wu Hanlin(伍汉霖)"
  .. .. ..$ Institution: chr [1:3] "Institute of Zoology, Chinese Academy of Sciences(中国科学院动物研究所)" "(中央研究院生物多樣性研究中心)" "College of Life Science & Technology, Shanghai Ocean University(上海海洋大学生命科学与技术学院)"
  .. ..$ download_date   : Date[1:1], format: "2020-08-04"
```

###### Get Catalogue of Life Global checklist via species name and id
```r
x3 <- get_col_global(query = queries, option = "name")
head(x3[["Anguilla marmorata"]][["data"]])
```
```r
# A tibble: 2 x 24
  id    name  rank  name_status record_scrutiny… online_resource is_extinct source_database
  <chr> <chr> <chr> <chr>       <list>           <chr>           <chr>      <chr>          
1 433e… Angu… Spec… accepted n… <list [0]>       "http://www.fi… false      FishBase       
2 1a44… Angu… Spec… misapplied… <NULL>           ""              NA         FishBase       
# … with 16 more variables: source_database_url <chr>, bibliographic_citation <chr>, name_html <chr>,
#   url <chr>, accepted_name.id <chr>, accepted_name.name <chr>, accepted_name.rank <chr>,
#   accepted_name.name_status <chr>, accepted_name.record_scrutiny_date <list>,
#   accepted_name.online_resource <chr>, accepted_name.is_extinct <chr>,
#   accepted_name.source_database <chr>, accepted_name.source_database_url <chr>,
#   accepted_name.bibliographic_citation <chr>, accepted_name.name_html <chr>,
#   accepted_name.url <chr>
```
```r
str(list_df(x3,db = "colglobal")[["meta"]])
```
```r
List of 8
 $ id                        :List of 5
  ..$ Anguilla marmorata : chr ""
  ..$ Anguilla japonica  : chr ""
  ..$ Anguilla bicolor   : chr ""
  ..$ Anguilla nebulosa  : chr ""
  ..$ Anguilla luzonensis: chr ""
 $ name                      :List of 5
  ..$ Anguilla marmorata : chr "Anguilla marmorata"
  ..$ Anguilla japonica  : chr "Anguilla japonica"
  ..$ Anguilla bicolor   : chr "Anguilla bicolor"
  ..$ Anguilla nebulosa  : chr "Anguilla nebulosa"
  ..$ Anguilla luzonensis: chr "Anguilla luzonensis"
 $ total_number_of_results   :List of 5
  ..$ Anguilla marmorata : int 2
  ..$ Anguilla japonica  : int 1
  ..$ Anguilla bicolor   : int 3
  ..$ Anguilla nebulosa  : int 4
  ..$ Anguilla luzonensis: int 1
 $ number_of_results_returned:List of 5
  ..$ Anguilla marmorata : int 2
  ..$ Anguilla japonica  : int 1
  ..$ Anguilla bicolor   : int 3
  ..$ Anguilla nebulosa  : int 4
  ..$ Anguilla luzonensis: int 1
 $ start                     :List of 5
  ..$ Anguilla marmorata : int 0
  ..$ Anguilla japonica  : int 0
  ..$ Anguilla bicolor   : int 0
  ..$ Anguilla nebulosa  : int 0
  ..$ Anguilla luzonensis: int 0
 $ error_mexage              :List of 5
  ..$ Anguilla marmorata : NULL
  ..$ Anguilla japonica  : NULL
  ..$ Anguilla bicolor   : NULL
  ..$ Anguilla nebulosa  : NULL
  ..$ Anguilla luzonensis: NULL
 $ version                   :List of 5
  ..$ Anguilla marmorata : chr "1.9 rev 2126ab0"
  ..$ Anguilla japonica  : chr "1.9 rev 2126ab0"
  ..$ Anguilla bicolor   : chr "1.9 rev 2126ab0"
  ..$ Anguilla nebulosa  : chr "1.9 rev 2126ab0"
  ..$ Anguilla luzonensis: chr "1.9 rev 2126ab0"
 $ rank                      :List of 5
  ..$ Anguilla marmorata : chr ""
  ..$ Anguilla japonica  : chr ""
  ..$ Anguilla bicolor   : chr ""
  ..$ Anguilla nebulosa  : chr ""
  ..$ Anguilla luzonensis: chr ""
```

###### Find synonyms via species name from Catalogue of Life Global
```r
find_synonyms(queries)
```
```r
# last Update: 2020-08-04
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
get_col_taiwan(query = "Anguilla",level = "species",option = "contain")
```
```r
# last Update: 2020-08-04
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
# last Update: 2020-08-04
# # A tibble: 4 x 11
# `Chinese Family… Family `Chinese Names` ScientificNames Status `Assessment Cri… Endemic Taxon `Chinese Taxon`
# <chr>            <chr>  <chr>           <chr>           <chr>  <chr>            <chr>   <chr> <chr>          
# 1 鳗鲡科           Angui… 日本鳗鲡        Anguilla japon… EN     A2bcd            NA      Inla… 内陆鱼类       
# 2 鳗鲡科           Angui… 花鳗鲡          Anguilla marmo… EN     A2bcd            NA      Inla… 内陆鱼类       
# 3 鳗鲡科           Angui… 双色鳗鲡        Anguilla bicol… NT     NA               NA      Inla… 内陆鱼类       
# 4 鳗鲡科           Angui… 云纹鳗鲡        Anguilla nebul… NT     NA               NA      Inla… 内陆鱼类       
# # … with 2 more variables: Group <chr>, `Chinese Group` <chr>
```

##### Note: You need to apply for the [*apiKey*](http://zoology.especies.cn/database/api) to run zoology_* functions of this package.
###### Query details of species in China Animal Scientific Database

```r
##Set your key
set_search_key("your apiKey",db = "zoology")

## Query China Animal Scientific Database lists
zoology_dbase_name()
```

```r
Request returned successfully!!!
last Update: 2020-10-26
China Animal Scientific Database - Found: 13
1:中国动物志数据库
2:中国动物图谱数据库
3:中国经济动物数据库
4:中国鸟类数据库
5:中国哺乳动物数据库
6:中国蝴蝶数据库
7:中国蜜蜂数据库
8:中国内陆水体鱼类数据库
9:中国两栖动物
10:中国爬行动物数据库
11:中国直翅目与革翅目昆虫数据库
12:中国蜚蠊目数据库
13:中国双尾纲与原尾纲数据库
```
```r
## Query description type information of Chinese Bird Database
zoology_description_type(query = "Aix galericulata",dbname = 4)
```

```r
Request returned successfully!!!
last Update: 2020-10-26
   id       type
1   1   形态描述
2 152   生境信息
3 159   鸣声描述
4 205 地理区分布
5 208   国外分布
6 209   国内分布
7 301   保护信息
```
```r
## Query details of species in Chinese Bird Database
zoology_description(query = "Aix galericulata",dbname = 4,destype = 209)
```
```r
Request returned successfully!!!
last Update: 2020-10-26
$`Aix galericulata`
$`Aix galericulata`$meta
$`Aix galericulata`$meta$scientificName
[1] "Aix galericulata"


$`Aix galericulata`$data
                                                           refs                           descontent
1 郑光美, 2011, 中国鸟类分类与分布名录. 北京：科学出版社. pp456 All except Xinjiang, Xizang, Qinghai
2 郑光美, 2011, 中国鸟类分类与分布名录. 北京：科学出版社. pp456       除新疆、西藏、青海外，见于各省
                    destitle
1 Aix galericulata的国内分布
2 Aix galericulata的国内分布
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
#   [1] SP2000_0.1.0
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

The development of this [**SP2000**](https://cran.r-project.org/package=SP2000) package were supported by the Biodiversity Survey and Assessment Project of the Ministry of Ecology and Environment, China ([**2019HJ2096001006**](http://www.mee.gov.cn/xxgk/zfcg/zbxx09/201906/t20190620_707171.shtml)),Yunnan University's "Double First Class" Project [**C176240405**]and the Yunnan University's Research Innovation Fund for Graduate Students[**2019227**]. 

### How to cite this package
```r
citation("SP2000")
```
```r
To cite package ‘SP2000’ in publications use:

  Liuyong Ding (2020). SP2000: Catalogue of Life Toolkit. R package version 0.1.0.
  https://github.com/Otoliths/SP2000

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {SP2000: Catalogue of Life Toolkit},
    author = {Liuyong Ding},
    year = {2020},
    note = {R package version 0.1.0},
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
