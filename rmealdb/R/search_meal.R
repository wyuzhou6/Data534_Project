library(tidyverse)
library(httr2)

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

  # Get the API response
  response <- httr2::request(url) %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()

  # Check if meals exist
  if (is.null(response$meals)) {
    message("No results found.")
    return(NULL)
  }

  # Extract meals list
  meals <- response$meals

  # Function to process a single meal into a row
  process_meal <- function(meal) {
    # Basic details
    basic <- tibble(
      idMeal = meal$idMeal %||% NA_character_,
      strMeal = meal$strMeal %||% NA_character_,
      strCategory = meal$strCategory %||% NA_character_,
      strArea = meal$strArea %||% NA_character_,
      strInstructions = meal$strInstructions %||% NA_character_,
      strMealThumb = meal$strMealThumb %||% NA_character_,
      strTags = meal$strTags %||% NA_character_,
      strYoutube = meal$strYoutube %||% NA_character_,
      strSource = meal$strSource %||% NA_character_
    )

    # Handle ingredients and measures (up to 20 possible)
    ingredients <- map_chr(1:20, ~meal[[paste0("strIngredient", .x)]] %||% "")
    measures <- map_chr(1:20, ~meal[[paste0("strMeasure", .x)]] %||% "")

    # Create ingredients data frame
    ingredients_df <- tibble(
      ingredient = ingredients,
      measure = measures
    ) %>%
      filter(ingredient != "")  # Remove empty ingredients

    # Combine with ingredients as a nested column
    basic %>% mutate(ingredients = list(ingredients_df))
  }

  # Apply to all meals and combine into one data frame
  df <- map_dfr(meals, process_meal)

  return(df)
}

# Test the function


if (interactive()) {
result <- search_meal("pasta")
print(result)
}