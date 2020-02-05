##' detailed lists convert data frame
##'
##' @title detailed lists convert data frame
##' @rdname listdf
##' @name listdf
##' @param x \code{list} lists
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
##' @source Visit the website \url{http://col.especies.cn/api/document} for more details
##' @examples
##'\dontrun{
##' query <- c("025397f9-9891-40a7-b90b-5a61f9c7b597","04c59ee8-4b48-4095-be0d-663485463f21","4c539380-8d0a-4cbf-b612-1e6df5850295","522c1cfd-0d2c-490f-b8f8-0c7459f6dba5","6d04dcf5-f390-472d-b674-4f09e43713ed","89c29448-a48f-46cb-a573-ee51dd47e7b0","a3452c0c-6d75-465b-b110-537e4ac15f80","a69df232-07e4-4f06-9651-a4e52796f01a","b8c6a086-3d28-4876-8e8a-ca96e667768d","c1dbe9f7-e02f-4f05-a1ca-1487a41075bd","d5938c75-e51a-4737-aaef-4f342fa8b364","f95f766f-7b96-464a-bff5-43b1adafcf50","faaf346f-49f4-400a-947b-edb6b0f6bd5e")
##' x1 <- sp2000(query=query,apiKey=" ")
##' x2 <- listdf(x1)
##' }
##' @export
listdf <- function(x){
  data <- tibble(ScientificName=do.call("rbind", transpose(x)[["scientificName"]]),
                 Synonyms=transpose(x)[["Synonyms"]],
                 #Synonyms=transpose(transpose(x)[["Synonyms"]])[["synonym"]]
                 chineseName=do.call("rbind", transpose(x)[["chineseName"]]),
                 CommonNames=transpose(x)[["CommonNames"]],
                 Kingdom=do.call("rbind", transpose(transpose(x)[["taxonTree"]])[["kingdom"]]),
                 Phylum=do.call("rbind", transpose(transpose(x)[["taxonTree"]])[["phylum"]]),
                 Class=do.call("rbind", transpose(transpose(x)[["taxonTree"]])[["class"]]),
                 Order=do.call("rbind", transpose(transpose(x)[["taxonTree"]])[["order"]]),
                 Family=do.call("rbind", transpose(transpose(x)[["taxonTree"]])[["family"]]),
                 Genus=do.call("rbind", transpose(transpose(x)[["taxonTree"]])[["genus"]]),
                 Species=do.call("rbind", transpose(transpose(x)[["taxonTree"]])[["species"]]),
                 Infraspecies=do.call("rbind", transpose(transpose(x)[["taxonTree"]])[["infraspecies"]]),
                 Distribution=list.rbind(as.character(transpose(x)[["Distribution"]])),
                 Name=do.call("rbind",transpose(transpose(x)[["SpecialistInfo"]])[["name"]]),
                 Email=do.call("rbind",transpose(transpose(x)[["SpecialistInfo"]])[["E-Mail"]]),
                 Address=do.call("rbind",transpose(transpose(x)[["SpecialistInfo"]])[["Address"]]),
                 Institution=do.call("rbind",transpose(transpose(x)[["SpecialistInfo"]])[["Institution"]]),
                 References=transpose(x)[["Refs"]],
                 Download= rep(as.Date(Sys.time()),length(x))
  )
  return(data)
}

packages <- c("jsonlite", "tibble","parallel","purrr","rlist")
package.check <- lapply(packages, FUN = function(x) {
  if (!require(x, character.only = TRUE)) {
    install.packages(x, dependencies = TRUE, repos = "http://cran.us.r-project.org")
    library(x, character.only = TRUE)
  }
})
