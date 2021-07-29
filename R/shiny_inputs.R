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

#' Generate Shiny Inputs for a vector of identifiers
#'
#' @param FUN a ShinyInput function - should theoretically work for all shinyInput functions that have \code{inputid} as the first argument
#' @param id_prefix a string that will be combined with the unique identifier and passed as the inputid
#' @param uid a vector of unique identifiers
#' @param ... other arguments to be passed to the \code{FUN}
#'
#' @return a character vector of shinyInputs
#'
#' @examples
#' gen_input_map(1:5, shiny::numericInput, id_prefix = "playerid_", label = "my_label", value = 1)
#' gen_input_map(FUN = numericInput, id_prefix = "itemprice_", uid = c(1, 3, 5, 7), ...)
#' @export

gen_input_map <- function(uid, FUN, id_prefix = NULL, ...) {
  if (!requireNamespace("purrr", quietly = TRUE)) stop("Package `purrr` is required!", call. = FALSE)

  stopifnot(unique_uid = {length(uid) == length(unique(uid))})

  input_ids <- paste0(id_prefix, uid)

  purrr::map_chr(input_ids, ~FUN(.x,...) %>% as.character(),...)
}
