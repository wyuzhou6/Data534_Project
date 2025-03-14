#' Handle API Response
#'
#' Checks if the API response is valid and extracts data.
#'
#' @param response The HTTP response object from httr2.
#' @return A parsed JSON object or NULL if the response is invalid.
#' @examples
#' handle_api_response(response)
#' @export
#' 
handle_api_response <- function(response) {
  # Check if the HTTP response status is not successful (status code 200)
  if (httr2::resp_status(response) != 200) {
    # Display a message indicating the failure with the status code
    message("API request failed. Status code: ", httr2::resp_status(response))
    # Return NULL to indicate failure in retrieving data
    return(NULL)
  }
  # Parse and return the JSON content from the response if successful
  httr2::resp_body_json(response)
}