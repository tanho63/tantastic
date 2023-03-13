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
#' @examples
#'
#' \donttest{
#' read_rosters <- function(){
#'   urls <- c("https://github.com/nflverse/nflfastR-roster/raw/master/data/seasons/roster_2020.csv",
#'             "https://github.com/nflverse/nflfastR-roster/raw/master/data/seasons/roster_2021.csv")
#'
#'   p <- progressr::progressor(along = urls)
#'   lapply(urls, progressively(read.csv, p))
#' }
#'
#' progressr::with_progress(read_rosters())
#' }
#'
#' @return a function that does the same as `f` but it calls `p()` after iteration.
#'
#' @seealso `vignette("Using nflreadr in packages")`
#' @seealso <https://nflreadr.nflverse.com/articles/exporting_nflreadr.html> for web version of vignette
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
