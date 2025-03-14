library(tidyverse)
library(httr2)

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

  # Get the API response
  response <- httr2::request(url) %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()

  # Check if meals exist
  if (is.null(response$meals)) {
    message("Invalid category or no meals found.")
    return(NULL)
  }

  # Extract meals list
  meals <- response$meals

  # Convert to data frame
  df <- tibble(
    idMeal = map_chr(meals, "idMeal", .default = NA_character_),
    strMeal = map_chr(meals, "strMeal", .default = NA_character_),
    strMealThumb = map_chr(meals, "strMealThumb", .default = NA_character_)
  )

  return(df)
}

# Test the function
result <- get_meals_by_category("Seafood")
print(result)
