#' Get Meals by Category
#'
#' Retrieves meals belonging to a specific category.
#'
#' @param category A character string specifying the category.
#' @return A dataframe containing meal names and their IDs.
#' @examples
#' get_meals_by_category("Seafood")
#' @export
get_meals_by_category <- function(category) {
  url <- paste0("https://www.themealdb.com/api/json/v1/1/filter.php?c=", category)

  response <- httr2::request(url) %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()

  if (is.null(response$meals)) {
    message("Invalid category or no meals found.")
    return(NULL)
  }

  return(response$meals)
}

