#' Search for meals by name
#'
#' This function queries TheMealDB API to find meals that contain a specific keyword
#' in their name. It returns basic information about the matching meals.
#'
#' @param query A character string with the meal name to search for (e.g., "pasta").
#' @return A list containing meal data as returned by the API, or NULL if no results are found.
#' @export
#' @examples
#' search_meal("pasta")
search_meal <- function(query) {

  # validate input: Ensure the search query is a non-empty string.
  if (!is.character(query) || nchar(query) == 0) {
    stop("Query must be a non-empty character string.")
  }

  # Construct API URL for searching meals by name.
  url <- sprintf("https://www.themealdb.com/api/json/v1/1/search.php?s=%s", query)
  tryCatch({
    # Send request to the API and retrieve response.
    response <- httr2::request(url) %>%
      httr2::req_perform()

     # Process API response.
    data <- handle_api_response(response)

    # Handle cases where no meals are found.
    if (is.null(data$meals)) {
      warning("No results found.")
      return(NULL)
    }
    return(data$meals)
  }, error = function(e) {

    # Gracefully handle API request errors.
    warning("Error searching meals: ", e$message)
    return(NULL)
  })
}
