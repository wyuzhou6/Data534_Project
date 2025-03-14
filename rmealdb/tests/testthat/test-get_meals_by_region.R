library(testthat)
library(rmealdb)

test_that("get_meals_by_region returns a list for a valid region", {
  result <- get_meals_by_region("Italian")
  expect_true(is.list(result), info = "Result should be a list")
  expect_true(length(result) > 0, info = "Result should contain at least one meal")
  expect_true(all(sapply(result, function(x) "strMeal" %in% names(x))),
              info = "Each meal should have a 'strMeal' field")
})

test_that("get_meals_by_region returns NULL and warns for an invalid region", {
  expect_warning(result <- get_meals_by_region("InvalidRegion"),
                 "Invalid region or no meals found")
  expect_null(result, info = "Result should be NULL for invalid region")
})

test_that("get_meals_by_region errors on invalid input", {
  expect_error(get_meals_by_region(""), "Region must be a non-empty character string")
  expect_error(get_meals_by_region(123), "Region must be a non-empty character string")
})