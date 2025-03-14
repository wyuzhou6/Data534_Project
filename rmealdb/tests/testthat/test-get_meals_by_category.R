library(testthat)
library(rmealdb)

test_that("get_meals_by_category returns a list for a valid category", {
  result <- get_meals_by_category("Seafood")
  expect_true(is.list(result), info = "Result should be a list")
  expect_true(length(result) > 0, info = "Result should contain at least one meal")
  expect_true(all(sapply(result, function(x) "strMeal" %in% names(x))),
              info = "Each meal should have a 'strMeal' field")
})

test_that("get_meals_by_category returns NULL and warns for an invalid category", {
  expect_warning(result <- get_meals_by_category("InvalidCategory"),
                 "Invalid category or no meals found")
  expect_null(result, info = "Result should be NULL for invalid category")
})

test_that("get_meals_by_category errors on invalid input", {
  expect_error(get_meals_by_category(""), "Category must be a non-empty character string")
  expect_error(get_meals_by_category(123), "Category must be a non-empty character string")
})