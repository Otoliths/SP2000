#' @title SP2000 API keys
#' @description Apply for the apiKey variable to be used by all search_* functions,
#' register for \url{http://sp2000.org.cn/api/document} and use an API key. This function allows users to set this key.
#' @rdname api_key
#' @param key \code{string} Value to set apiKey to (i.e. your API key).
#' @return A logical of length one, TRUE is the value was set FALSE if not.
#' value is returned inside invisible(), i.e. it is not printed to screen
#' when the function is called.
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
