#' Read a sequence of Shiny Inputs
#'
#' @param inputid a vector of inputids to read
#' @param nullarg the value to return if the input value is \code{NULL} i.e. missing
#' @param type one of \code{('chr','dbl','lgl','int')} - specifies type of atomic vector to return
#' @param .env the environment to look for the input - defaults to the default reactive domain
#'
#' @return a vector of values
#'
#' @examples
#' read_inputs(inputid = c("select_1", "select_2"), nullarg = NA, type = "chr")
#' @export

read_inputs <- function(inputid = NULL,
                        nullarg = NA,
                        type = c("chr", "dbl", "lgl", "int"),
                        .env = shiny::getDefaultReactiveDomain()) {
  if (!requireNamespace("purrr", quietly = TRUE)) stop("Package `purrr` is required!", call. = FALSE)

  input <- get("input", envir = .env)

  map_function <- switch(match.arg(type),
    "chr" = purrr::map_chr,
    "dbl" = purrr::map_dbl,
    "lgl" = purrr::map_lgl,
    "int" = purrr::map_int
  )

  map_function(inputid, ~ if (!is.null(input[[..1]])) {
    input[[..1]]
  } else {
    nullarg
  })
}
