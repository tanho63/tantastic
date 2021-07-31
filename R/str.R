
#' Tan's str() function
#'
#' Wraps `utils::str()` but defaults to max.level = 2
#'
#' @param ... objects passed to str
#' @param max.level sets max.level - by default, 2
#'
#' @return output of utils::str() but defaults to max.level = 2
#' @export
#'
#' @examples
#'
#' list(
#'   data = list(
#'     mtcars = tibble::tibble(mtcars),
#'     airquality = tibble::tibble(airquality)
#'   )
#' ) %>%
#'   str()
str <- function(..., max.level = 2) {
  utils::str(..., max.level = max.level)
}
