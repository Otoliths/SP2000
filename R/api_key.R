#' @title SP2000 API keys
#' @description Apply for the apiKey variable to be used by all search_* functions,
#' register for \url{http://sp2000.org.cn/api/document} and use an API key. This function allows users to set this key.
#' Note: The daily API visits of ordinary users are 2000,
#' If you want to apply for increasing the daily API request limit,
#' please fill in the application form \url{http://col.especies.cn/doc/API.docx} and send an email to \email{SP2000CN@ibcas.ac.cn} entitled "Application for increasing API Request Times".
#' @rdname api_key
#' @param key \code{string} Value to set apiKey to (i.e. your API key).
#' @return A logical of length one, TRUE is the value was set FALSE if not.
#' value is returned inside invisible(), i.e. it is not printed to screen
#' when the function is called.
#' @author Liuyong Ding \email{ly_ding@126.com}
#' @examples
#' \dontrun{
#' #Set the apiKey variable to be used by all search_* functions
#' set_search_key("your apiKey")
#'
#'}
#' @export
set_search_key <- function(key){
  Sys.setenv(sp2000_apiKey = key)
}

is_search_key_set <- function(){
  !identical(Sys.getenv('sp2000_apiKey'), "")
}
