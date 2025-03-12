#' Get Meal Details by ID
#'
#' Fetches detailed meal information using a unique ID.
#'
#' @param id A character string representing the meal ID.
#' @return A dataframe containing meal details.
#' @examples
#' get_meal_by_id("52772")
get_meal_by_id <- function(id) {
  url <- paste0("https://www.themealdb.com/api/json/v1/1/lookup.php?i=", id)
  response <- httr::GET(url)
  data <- jsonlite::fromJSON(httr::content(response, "text", encoding = "UTF-8"))
  
  if (is.null(data$meals)) {
    message("Invalid meal ID.")
    return(NULL)
  }
  
  return(data$meals)
}
