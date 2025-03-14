library(testthat)
library(rmealdb)

test_that("get_random_meal returns a single meal list", {
  result <- get_random_meal()
  expect_true(is.list(result), info = "Result should be a list")
  expect_equal(length(result), 1, info = "Result should contain exactly one meal")
  expect_true("strMeal" %in% names(result[[1]]), info = "Meal should have a 'strMeal' field")
})

test_that("get_random_meal returns NULL and warns if no meal is returned", {
  # This test might not trigger often due to API reliability, but included for completeness
  skip("API rarely returns NULL, skipping unless mock needed")
  expect_warning(result <- get_random_meal(), "No meal returned from API")
  expect_null(result)
})