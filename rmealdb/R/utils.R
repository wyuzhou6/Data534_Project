#' Handle API Response
#'
#' Checks if the API response is valid and extracts data.
#'
#' @param response The HTTP response object from httr::GET()
#' @return A parsed JSON object or NULL if the response is invalid.
handle_api_response <- function(response) {
  if (httr::status_code(response) != 200) {
    message("API request failed. Status code: ", httr::status_code(response))
    return(NULL)
  }
  jsonlite::fromJSON(httr::content(response, "text", encoding = "UTF-8"))
}
