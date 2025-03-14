library(testthat)
library(rmealdb)

test_that("get_categories returns a list of categories", {
  result <- get_categories()
  expect_true(is.list(result), info = "Result should be a list")
  expect_true(length(result) > 0, info = "Result should contain at least one category")
  expect_true(all(sapply(result, function(x) "strCategory" %in% names(x))),
              info = "Each category should have a 'strCategory' field")
})

test_that("get_categories returns NULL and warns if no categories returned", {
  # This test might not trigger often due to API reliability, but included for completeness
  skip("API rarely returns NULL, skipping unless mock needed")
  expect_warning(result <- get_categories(), "No categories returned from API")
  expect_null(result)
})