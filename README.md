# Data534_Project
# rmealdb

An R package to interact with TheMealDB API. 


## Installation
```{r}
# Install dependencies
install.packages(c("httr", "jsonlite", "testthat"))
```
## Usage
```{r}
library(rmealdb)

# Search for a meal
search_meal("pasta")

# Get a random meal
get_random_meal()

# Get meal details by ID
get_meal_by_id("52772")

# List all categories
get_categories()

# Get meals by category
get_meals_by_category("Seafood")

# Get meals by region
get_meals_by_region("Italian")
```
