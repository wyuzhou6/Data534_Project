#' Fetch meal details by ID
#'
#' This function retrieves detailed information about a specific meal
#' using its unique ID from TheMealDB API. It returns key details such as
#' ingredients, instructions, and an image.
#'
#' @param meal_id A character string specifying the meal ID (e.g., "52772").
#' @return A list containing meal data as returned by the API, or NULL if the ID is invalid.
#' @export
#' @examples
get_meal_by_id <- function(meal_id) {

  # tep 1: Validate input - Ensure meal_id is a non-empty string
  # This prevents function failures due to incorrect input types.
  if (!is.character(meal_id) || nchar(meal_id) == 0) {
    stop("Meal ID must be a non-empty character string.")
  }

   # Step 2: Construct the API request URL with the provided meal ID.
  # We use sprintf() for better readability and formatting.
  url <- sprintf("https://www.themealdb.com/api/json/v1/1/lookup.php?i=%s", meal_id)
  tryCatch({

    # Step 3: Perform the API request using httr2.
    # The API is queried with the constructed URL, and the response
    response <- httr2::request(url) %>%
      httr2::req_perform()

    # Step 4: Process the API response.
    # The function `handle_api_response()` extracts JSON data.
    data <- handle_api_response(response)

    # Step 5: Validate API response.
    # If the API response does not contain a valid "meals" field, return NULL.
     if (is.null(data$meals)) {
      warning("Invalid meal ID.")
      return(NULL)
    }
    return(data$meals)
  }, error = function(e) {

    # Step 7: Handle errors gracefully.
    # If an error occurs during the API request, return a warning message.
    warning("Error fetching meal by ID: ", e$message)
    return(NULL)
  })
}
