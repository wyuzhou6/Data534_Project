#' Get All Meal Categories
#'
#' Lists all available meal categories from TheMealDB API.
#'
#' @return A dataframe containing category names and descriptions.
#' @examples
#' get_categories()
get_categories <- function() {
  url <- "https://www.themealdb.com/api/json/v1/1/categories.php"
  response <- httr::GET(url)
  data <- jsonlite::fromJSON(httr::content(response, "text", encoding = "UTF-8"))
  return(data$categories)
}
