#' Get Meals by Region
#'
#' Retrieves meals from a specific region/country.
#'
#' @param region A character string specifying the region.
#' @return A dataframe containing meal names and their IDs.
#' @examples
#' get_meals_by_region("Italian")
get_meals_by_region <- function(region) {
  url <- paste0("https://www.themealdb.com/api/json/v1/1/filter.php?a=", region)
  response <- httr::GET(url)
  data <- jsonlite::fromJSON(httr::content(response, "text", encoding = "UTF-8"))
  
  if (is.null(data$meals)) {
    message("Invalid region or no meals found.")
    return(NULL)
  }
  
  return(data$meals)
}
