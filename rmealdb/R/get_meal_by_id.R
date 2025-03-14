#' Get Meal by ID
#'
#' Fetches a meal's details based on its ID from TheMealDB API.
#'
#' @param meal_id A character string specifying the meal ID (e.g., "52772").
#' @return A list containing meal data as returned by the API, or NULL if the ID is invalid.
#' @export
#' @examples
#' get_meal_by_id("52772")
get_meal_by_id <- function(meal_id) {
  if (!is.character(meal_id) || nchar(meal_id) == 0) {
    stop("Meal ID must be a non-empty character string.")
  }
  
  url <- sprintf("https://www.themealdb.com/api/json/v1/1/lookup.php?i=%s", meal_id)
  tryCatch({
    response <- httr2::request(url) %>% 
      httr2::req_perform()
    data <- handle_api_response(response)
    if (is.null(data$meals)) {
      warning("Invalid meal ID.")
      return(NULL)
    }
    return(data$meals)
  }, error = function(e) {
    warning("Error fetching meal by ID: ", e$message)
    return(NULL)
  })
}