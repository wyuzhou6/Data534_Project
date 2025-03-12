library(testthat)

test_that("Get random meal returns data", {
  result <- get_random_meal()
  expect_true(is.data.frame(result))
  expect_true("strMeal" %in% colnames(result))
})
