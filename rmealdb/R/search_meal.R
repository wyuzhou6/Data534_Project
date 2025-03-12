#' Search for a meal by name
#'
#' This function searches for meals in TheMealDB API by a given name.
#'
#' @param query A character string with the meal name to search for.
#' @return A dataframe containing meals that match the search query.
#' @examples
#' search_meal("pasta")
search_meal <- function(query) {
  url <- paste0("https://www.themealdb.com/api/json/v1/1/search.php?s=", query)
  response <- httr::GET(url)
  data <- jsonlite::fromJSON(httr::content(response, "text", encoding = "UTF-8"))
  
  if (is.null(data$meals)) {
    message("No results found.")
    return(NULL)
  }
  
  return(data$meals)
}
