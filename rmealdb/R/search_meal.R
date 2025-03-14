#' Search for a Meal by Name
#'
#' Searches for meals in TheMealDB API by a given name.
#'
#' @param query A character string with the meal name to search for (e.g., "pasta").
#' @return A list containing meal data as returned by the API, or NULL if no results are found.
#' @export
#' @examples
#' search_meal("pasta")
search_meal <- function(query) {
  if (!is.character(query) || nchar(query) == 0) {
    stop("Query must be a non-empty character string.")
  }
  
  url <- sprintf("https://www.themealdb.com/api/json/v1/1/search.php?s=%s", query)
  tryCatch({
    response <- httr2::request(url) %>% 
      httr2::req_perform()
    data <- handle_api_response(response)
    if (is.null(data$meals)) {
      warning("No results found.")
      return(NULL)
    }
    return(data$meals)
  }, error = function(e) {
    warning("Error searching meals: ", e$message)
    return(NULL)
  })
}