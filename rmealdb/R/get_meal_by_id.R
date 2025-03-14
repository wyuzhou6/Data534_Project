library(tidyverse)
library(httr2)

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
  
  # Get the API response
  response <- httr2::request(url) %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()
  
  # Check if meal exists
  if (is.null(response$meals)) {
    message("Invalid meal ID.")
    return(NULL)
  }
  
  # Extract the first meal (API returns a list with one meal)
  meal <- response$meals[[1]]
  
  # Create basic details data frame
  basic_df <- tibble(
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
  
  # Combine basic details with ingredients as a nested column
  final_df <- basic_df %>%
    mutate(ingredients = list(ingredients_df))
  
  return(final_df)
}

# Test the function
result <- get_meal_by_id("52772")
print(result)