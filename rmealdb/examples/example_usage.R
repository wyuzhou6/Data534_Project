# Example usage of the rmealdb package
library(rmealdb)
library(tibble)
library(purrr)

# Helper function to convert JSON list to tibble
clean_data <- function(item) {
  item <- as.list(item)
  item[sapply(item, is.null)] <- NA
  tibble::as_tibble(item)
}

# Example 1: Get all categories
cat("Example 1: Fetching all meal categories\n")
categories <- get_categories()
categories_df <- purrr::map_dfr(categories, clean_data)
print(head(categories_df))

# Example 2: Get meals by region (Italian)
cat("\nExample 2: Fetching meals from Italian region\n")
italian_meals <- get_meals_by_region("Italian")
italian_meals_df <- purrr::map_dfr(italian_meals, clean_data)
print(head(italian_meals_df))

# Example 3: Search for meals by name (pasta)
cat("\nExample 3: Searching for meals with 'pasta'\n")
pasta_meals <- search_meal("pasta")
pasta_meals_df <- purrr::map_dfr(pasta_meals, clean_data)
print(head(pasta_meals_df))

# Example 4: Get meal by ID
cat("\nExample 4: Fetching meal by ID '52772'\n")
meal <- get_meal_by_id("52772")
meal_df <- purrr::map_dfr(meal, clean_data)
print(meal_df)

# Example 5: Get a random meal
cat("\nExample 5: Fetching a random meal\n")
random_meal <- get_random_meal()
random_meal_df <- purrr::map_dfr(random_meal, clean_data)
print(random_meal_df)

# Example 6: Get meals by category (Seafood)
cat("\nExample 6: Fetching meals in 'Seafood' category\n")
seafood_meals <- get_meals_by_category("Seafood")
seafood_meals_df <- purrr::map_dfr(seafood_meals, clean_data)
print(head(seafood_meals_df))