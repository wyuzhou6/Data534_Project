#' Get a Random Meal
#'
#' This function fetches a random meal from TheMealDB API.
#'
#' @return A dataframe containing details of a randomly selected meal.
#' @examples
#' get_random_meal()
get_random_meal <- function() {
  url <- "https://www.themealdb.com/api/json/v1/1/random.php"
  response <- httr::GET(url)
  data <- jsonlite::fromJSON(httr::content(response, "text", encoding = "UTF-8"))
  return(data$meals)
}
