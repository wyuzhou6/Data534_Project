library(testthat)
library(rmealdb)

test_that("get_meal_by_id returns a list for a valid ID", {
  result <- get_meal_by_id("52772")
  expect_true(is.list(result), info = "Result should be a list")
  expect_equal(length(result), 1, info = "Result should contain exactly one meal")
  expect_true("strMeal" %in% names(result[[1]]), info = "Meal should have a 'strMeal' field")
})

test_that("get_meal_by_id returns NULL and warns for an invalid ID", {
  expect_warning(result <- get_meal_by_id("999999"),
                 "Invalid meal ID")
  expect_null(result, info = "Result should be NULL for invalid ID")
})

test_that("get_meal_by_id errors on invalid input", {
  expect_error(get_meal_by_id(""), "Meal ID must be a non-empty character string")
  expect_error(get_meal_by_id(123), "Meal ID must be a non-empty character string")
})