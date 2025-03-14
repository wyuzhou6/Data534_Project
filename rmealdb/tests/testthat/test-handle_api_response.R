library(testthat)
library(rmealdb)

test_that("handle_api_response handles successful response", {
  mock_response <- structure(list(status = 200, body = list(meals = list(list(strMeal = "Test")))),
                             class = "httr2_response")
  with_mock(
    `httr2::resp_status` = function(resp) 200,
    `httr2::resp_body_json` = function(resp) list(meals = list(list(strMeal = "Test"))),
    {
      result <- handle_api_response(mock_response)
      expect_true(is.list(result), info = "Result should be a list")
      expect_equal(result$meals[[1]]$strMeal, "Test", info = "Should return parsed JSON")
    }
  )
})

test_that("handle_api_response returns NULL and warns for failed response", {
  mock_response <- structure(list(status = 404), class = "httr2_response")
  with_mock(
    `httr2::resp_status` = function(resp) 404,
    {
      expect_warning(result <- handle_api_response(mock_response),
                     "API request failed. Status code: 404")
      expect_null(result, info = "Result should be NULL for failed response")
    }
  )
})