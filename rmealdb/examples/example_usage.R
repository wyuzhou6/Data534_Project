# Example usage of the rmealdb package
# This script demonstrates how to fetch meal data using the MealDB API via the rmealdb package.
# The examples include fetching categories, searching for meals, retrieving meals by region,
# and other common queries.
# Load required packages
library(rmealdb)
library(tibble)  # For data wrangling
library(purrr)   # For functional programming


# Function: clean_data
# Description: Converts a list (API response) into a tibble while handling NULL values.
# Arguments:
#   - item: A list object representing a meal or category entry.
# Returns:
#   - A tibble with all NULL values replaced by NA.
clean_data <- function(item) {
  item <- as.list(item)
  item[sapply(item, is.null)] <- NA
  tibble::as_tibble(item)
}


# Example 1: Fetching all meal categories
# This example retrieves all available meal categories from the API and converts them into a tibble.
cat("Example 1: Fetching all meal categories\n")
categories <- get_categories()
categories_df <- purrr::map_dfr(categories, clean_data)
print(head(categories_df))


# Example 2: Fetching meals from a specific region
# This example retrieves all meals from the 'Italian' region.
# Modify the argument to fetch meals from different regions.
cat("\nExample 2: Fetching meals from Italian region\n")
italian_meals <- get_meals_by_region("Italian")
italian_meals_df <- purrr::map_dfr(italian_meals, clean_data)
print(head(italian_meals_df))


# Example 3: Searching for meals by keyword
# This example searches for meals that contain 'pasta' in their name.
# Adjust the search term to find other types of meals.
cat("\nExample 3: Searching for meals with 'pasta'\n")
pasta_meals <- search_meal("pasta")
pasta_meals_df <- purrr::map_dfr(pasta_meals, clean_data)
print(head(pasta_meals_df))


# Example 4: Fetching meal details using a specific meal ID
# This example retrieves details for meal ID '52772'. Replace the ID to fetch details for other meals.
cat("\nExample 4: Fetching meal by ID '52772'\n")
meal <- get_meal_by_id("52772")
meal_df <- purrr::map_dfr(meal, clean_data)
print(meal_df)


# Example 5: Fetching a random meal
# This example retrieves details for a randomly selected meal.
cat("\nExample 5: Fetching a random meal\n")
random_meal <- get_random_meal()
random_meal_df <- purrr::map_dfr(random_meal, clean_data)
print(random_meal_df)


# Example 6: Fetching meals by category
# This example fetches all meals that belong to the 'Seafood' category.
# Modify the category name to retrieve meals from other categories.
cat("\nExample 6: Fetching meals in 'Seafood' category\n")
seafood_meals <- get_meals_by_category("Seafood")
seafood_meals_df <- purrr::map_dfr(seafood_meals, clean_data)
print(head(seafood_meals_df))

