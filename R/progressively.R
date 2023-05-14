#' Progressively
#'
#' This function helps add progress-reporting to any function - given function `f()`
#' and progressor `p()`, it will return a new function that calls `f()` and then
#' (on-exiting) will call `p()` after every iteration. Now superseded by purrr's
#' map `.progress` arguments.
#'
#' This is inspired by purrr's `safely`, `quietly`, and `possibly` function decorators.
#'
#' @param f a function to add progressr functionality to.
#' @param p a progressor function similar to that created by `progressr::progressor()`
#'
#' @return a function that does the same as `f` but it calls `p()` after iteration.
#'
#' @examples
#' \donttest{
#' try({
#' urls <- c("https://github.com/nflverse/nflverse-data/releases/download/test/combines.csv",
#'             "https://github.com/nflverse/nflverse-data/releases/download/test/combines.csv")
#' read_test_files <- function(urls){
#'   p <- progressr::progressor(along = urls)
#'   lapply(urls, progressively(read.csv, p))
#' }
#'
#' progressr::with_progress(read_test_files(urls))
#' # superseded by
#' purrr::map(urls, read.csv, .progress = TRUE)
#' })
#' }
#'
#' @export
progressively <- function(f, p = NULL){
  if(!is.null(p) && !rlang::is_function(p)) stop("`p` must be a function!")
  if(is.null(p)) p <- function(...) NULL
  f <- rlang::as_function(f)

  function(...){
    on.exit(p("loading..."))
    f(...)
  }

}
