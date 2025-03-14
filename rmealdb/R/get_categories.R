#' Get All Meal Categories
#'
#' Lists all available meal categories from TheMealDB API.
#'
#' @return A list containing category data as returned by the API, or NULL if no categories are found.
#' @export
#' @examples
#' get_categories()
get_categories <- function() {
  url <- "https://www.themealdb.com/api/json/v1/1/categories.php"
  tryCatch({
    response <- httr2::request(url) %>% 
      httr2::req_perform()
    data <- handle_api_response(response)
    if (is.null(data$categories)) {
      warning("No categories returned from API.")
      return(NULL)
    }
    return(data$categories)
  }, error = function(e) {
    warning("Error fetching categories: ", e$message)
    return(NULL)
  })
}