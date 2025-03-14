library(testthat)
library(rmealdb)

test_that("search_meal returns a list for a valid query", {
  result <- search_meal("pasta")
  expect_true(is.list(result), info = "Result should be a list")
  expect_true(length(result) > 0, info = "Result should contain at least one meal")
  expect_true(all(sapply(result, function(x) "strMeal" %in% names(x))),
              info = "Each meal should have a 'strMeal' field")
})

test_that("search_meal returns NULL and warns for an empty result", {
  expect_warning(result <- search_meal("xyzabc123"),
                 "No results found")
  expect_null(result, info = "Result should be NULL for no matches")
})

test_that("search_meal errors on invalid input", {
  expect_error(search_meal(""), "Query must be a non-empty character string")
  expect_error(search_meal(123), "Query must be a non-empty character string")
})