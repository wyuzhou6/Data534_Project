#' Search for a Meal by Name
#'
#' This function searches for meals in TheMealDB API by a given name.
#'
#' @param query A character string with the meal name to search for.
#' @return A dataframe containing meals that match the search query.
#' @examples
#' search_meal("pasta")
#' @export
search_meal <- function(query) {
  url <- paste0("https://www.themealdb.com/api/json/v1/1/search.php?s=", query)

  response <- httr2::request(url) %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()

  if (is.null(response$meals)) {
    message("No results found.")
    return(NULL)
  }

  return(response$meals)
}