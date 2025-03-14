#' Get Meals by Category
#'
#' Retrieves meals belonging to a specific category.
#'
#' @param category A character string specifying the category.
#' @return A dataframe containing meal names and their IDs.
#' @examples
#' @export
#' get_meals_by_category("Seafood")
get_meals_by_category <- function(category) {
  url <- paste0("https://www.themealdb.com/api/json/v1/1/filter.php?c=", category)
  response <- httr::GET(url)
  data <- jsonlite::fromJSON(httr::content(response, "text", encoding = "UTF-8"))
  
  if (is.null(data$meals)) {
    message("Invalid category or no meals found.")
    return(NULL)
  }
  
  return(data$meals)
}
