#' Get a Random Meal
#'
#' This function fetches a random meal from TheMealDB API.
#'
#' @return A dataframe containing details of a randomly selected meal.
#' @examples
#' get_random_meal()
#' @export
get_random_meal <- function() {
  url <- "https://www.themealdb.com/api/json/v1/1/random.php"

  response <- httr2::request(url) %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()

  return(response$meals)
}