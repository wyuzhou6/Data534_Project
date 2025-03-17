#' Get a Random Meal
#'
#' Fetches a random meal from TheMealDB API.
#'
#' @return A list containing meal data as returned by the API, or NULL if no meal is returned.
#' @export
#' @examples
#' get_random_meal()
get_random_meal <- function() {
  # Define API URL for fetching a random meal.
  url <- "https://www.themealdb.com/api/json/v1/1/random.php"
  tryCatch({

    # Send request to the API and retrieve response.
    response <- httr2::request(url) %>%
      httr2::req_perform()

    # Process API response.
    data <- handle_api_response(response)

    # Handle cases where no meal is returned.
    if (is.null(data$meals)) {
      warning("No meal returned from API.")
      return(NULL)
    }
    return(data$meals)
  }, error = function(e) {

    # Gracefully handle API request errors.
    warning("Error fetching random meal: ", e$message)
    return(NULL)
  })
}
