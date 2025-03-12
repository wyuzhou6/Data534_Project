library(testthat)

test_that("Search meal returns valid data", {
  result <- search_meal("pasta")
  expect_true(is.data.frame(result))
  expect_true("strMeal" %in% colnames(result))
})

test_that("Search meal returns NULL when not found", {
  result <- search_meal("abcdefgxyz")
  expect_null(result)
})
