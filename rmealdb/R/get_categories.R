#' Get All Meal Categories
#'
#' Lists all available meal categories from TheMealDB API.
#'
#' @return A dataframe containing category names and descriptions.
#' @examples
#' @export
get_random_meal <- function() {
  # your code
}

#' get_categories()
get_categories <- function() {
  url <- "https://www.themealdb.com/api/json/v1/1/categories.php"

  response <- httr2::request(url) %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()

  return(response$categories)
}
