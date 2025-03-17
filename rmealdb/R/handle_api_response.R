#' Handle API Response
#'
#' Checks if the API response is valid and extracts data.
#'
#' @param response The HTTP response object from httr2::request()
#' @return A parsed JSON object or NULL if the response is invalid.
#' @export
handle_api_response <- function(response) {

  # Verify API response status.
  # If the response status code is not 200 (OK), return a warning and NULL.
  if (httr2::resp_status(response) != 200) {
    warning("API request failed. Status code: ", httr2::resp_status(response))
    return(NULL)
  }

  # Parse and return the JSON response body.
  return(httr2::resp_body_json(response))
}
