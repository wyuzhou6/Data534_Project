#' Get Meals by Region
#'
#' Retrieves meals from a specific region/country.
#'
#' @param region A character string specifying the region.
#' @return A dataframe containing meal names and their IDs.
#' @examples
#' get_meals_by_region("Italian")
#' @export
get_meals_by_region <- function(region) {
  url <- paste0("https://www.themealdb.com/api/json/v1/1/filter.php?a=", region)

  response <- httr2::request(url) %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()

  if (is.null(response$meals)) {
    message("Invalid region or no meals found.")
    return(NULL)
  }

  return(response$meals)
<<<<<<< HEAD
}
=======
}
<<<<<<< HEAD
}
>>>>>>> Yubo
=======
>>>>>>> Yubo
