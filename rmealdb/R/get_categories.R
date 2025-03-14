#' Get All Meal Categories
#'
#' Lists all available meal categories from TheMealDB API.
#'
#' @return A dataframe containing category names and descriptions.
#' @export
#' @examples
#'

#' get_categories()
library(tidyverse)   # Load the magrittr package for the pipe operator

get_categories <- function() {
  url <- "https://www.themealdb.com/api/json/v1/1/categories.php"

  response <- httr2::request(url) %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()

  categories <- response$categories
  df <- tibble(
    idCategory = map_chr(categories, "idCategory"),
    strCategory = map_chr(categories, "strCategory"),
    strCategoryThumb = map_chr(categories, "strCategoryThumb"),
    strCategoryDescription = map_chr(categories, "strCategoryDescription"))
  return(df)
}


