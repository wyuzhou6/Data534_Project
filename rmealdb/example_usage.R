library(rmealdb)

pasta_meals <- search_meal("pasta")
print(pasta_meals)

random_meal <- get_random_meal()
print(random_meal)

meal_details <- get_meal_by_id("52772")
print(meal_details)

categories <- get_categories()
print(categories)

seafood_meals <- get_meals_by_category("Seafood")
print(seafood_meals)

italian_meals <- get_meals_by_region("Italian")
print(italian_meals)
