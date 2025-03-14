#' Get Meals by Category
#'
#' Fetches a list of meals for a given category from TheMealDB API.
#'
#' @param category A character string specifying the meal category (e.g., "Seafood").
#' @return A list containing meal data as returned by the API, or NULL if no meals are found.
#' @export
#' @examples
#' get_meals_by_category("Seafood")
get_meals_by_category <- function(category) {
  if (!is.character(category) || nchar(category) == 0) {
    stop("Category must be a non-empty character string.")
  }
  
  url <- sprintf("https://www.themealdb.com/api/json/v1/1/filter.php?c=%s", category)
  tryCatch({
    response <- httr2::request(url) %>% 
      httr2::req_perform()
    data <- handle_api_response(response)
    if (is.null(data$meals)) {
      warning("Invalid category or no meals found.")
      return(NULL)
    }
    return(data$meals)
  }, error = function(e) {
    warning("Error fetching meals by category: ", e$message)
    return(NULL)
  })
}