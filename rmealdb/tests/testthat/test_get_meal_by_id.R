library(testthat)

test_that("Get meal by ID returns valid data", {
  result <- get_meal_by_id("52772")
  expect_true(is.data.frame(result))
  expect_true("strMeal" %in% colnames(result))
})

test_that("Invalid meal ID returns NULL", {
  result <- get_meal_by_id("00000")
  expect_null(result)
})
