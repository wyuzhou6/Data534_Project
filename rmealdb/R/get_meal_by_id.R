#' Get Meal Details by ID
#'
#' Fetches detailed meal information using a unique ID.
#'
#' @param id A character string representing the meal ID.
#' @return A dataframe containing meal details.
#' @examples
#' get_meal_by_id("52772")
#' @export
get_meal_by_id <- function(id) {
  url <- paste0("https://www.themealdb.com/api/json/v1/1/lookup.php?i=", id)

  response <- httr2::request(url) %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()

  if (is.null(response$meals)) {
    message("Invalid meal ID.")
    return(NULL)
  }

  return(response$meals)
}
