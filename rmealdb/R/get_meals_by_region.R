#' Get Meals by Region
#'
#' Fetches a list of meals from a specific region/country using TheMealDB API.
#'
#' @param region A character string specifying the meal region (e.g., "Italian").
#' @return A list containing meal data as returned by the API, or NULL if no meals are found.
#' @export
#' @importFrom magrittr %>%
#' @examples
#' get_meals_by_region("Italian")
get_meals_by_region <- function(region) {

  # Validate input: Ensure region is a non-empty string.
  if (!is.character(region) || nchar(region) == 0) {
    stop("Region must be a non-empty character string.")
  }

  # Construct API URL for filtering meals by region.
  url <- sprintf("https://www.themealdb.com/api/json/v1/1/filter.php?a=%s", region)
  tryCatch({
    # Send request to the API and retrieve response.
    response <- httr2::request(url) %>%
      httr2::req_perform()

    # Process API response.
     data <- handle_api_response(response)

     # Handle cases where no meals match the specified region.
     if (is.null(data$meals)) {
      warning("Invalid region or no meals found.")
      return(NULL)
    }
    return(data$meals)
  }, error = function(e) {

    # Gracefully handle API request errors.
    warning("Error fetching meals by region: ", e$message)
    return(NULL)
  })
}
