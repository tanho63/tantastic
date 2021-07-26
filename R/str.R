
#' Tan's str() function
#'
#' Wraps `utils::str()` but defaults to max.level = 2
#'
#' @param ... objects passed to str
#'
#' @return output of utils::str() but defaults to max.level = 2
#' @export
#'
#' @examples
#'
#' list(
#'   data = list(
#'     mtcars = mtcars,
#'     airquality = airquality
#'   )
#' ) %>%
#'   str()
str <- function(...) {
  utils::str(..., max.level = 2)
}
