#' Get a Random Meal
#'
#' Fetches a random meal from TheMealDB API.
#'
#' @return A list containing meal data as returned by the API, or NULL if no meal is returned.
#' @export
#' @examples
#' get_random_meal()
get_random_meal <- function() {
  url <- "https://www.themealdb.com/api/json/v1/1/random.php"
  tryCatch({
    response <- httr2::request(url) %>% 
      httr2::req_perform()
    data <- handle_api_response(response)
    if (is.null(data$meals)) {
      warning("No meal returned from API.")
      return(NULL)
    }
    return(data$meals)
  }, error = function(e) {
    warning("Error fetching random meal: ", e$message)
    return(NULL)
  })
}