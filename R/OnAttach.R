.onAttach <- function(libname, pkgname){
    packageStartupMessage(sprintf("Welcome to R Package SP2000 %s !!!
                                  \nTo cite SP2000 in publications, please use:
                                  \nDing LY, Li H, Tao J, Zhang JL, Huang MR, Yang K, Wang J, He DM, Ding CZ (2020) SP2000: A package written in R and Python for downloading catalogue of life. Biodiversity Science.
                                  \n\nTo start with the SP2000, please digit:
                                  \nhttps://cran.r-project.org/package=SP2000
                                  \nhttps://pypi.org/project/SP2000",
                                  utils::packageVersion("SP2000")),sep = "\n")

    syst <- Sys.info()[['sysname']]
    if(syst == "Windows"){
        # Ensure that Chinese Characters could be displayed properly.
        suppressMessages(Sys.setlocale(category = "LC_ALL", locale = "Chinese"))
    }
}

