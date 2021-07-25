#' Generate a sequence of Shiny Inputs
#'
#' @param FUN a ShinyInput function - should theoretically work for all shinyInput functions that have \code{inputid} as the first argument
#' @param id_prefix a string that will be combined with a sequence of length \code{len} and passed as the inputid
#' @param len the desired output length - generates a sequence that is combined with\code{id_prefix} and passed as the inputid
#' @param ... other arguments to be passed to the \code{FUN}
#'
#' @return a character vector of shinyInputs
#'
#' @examples
#' gen_input_seq(FUN = numericInput, id_prefix = "itemprice_", len = 5, ...)
#' @export

gen_input_seq <- function(FUN, id_prefix, len, ...) {
  if (!requireNamespace("purrr", quietly = TRUE)) stop("Package `purrr` is required!", call. = FALSE)

  if (!is.numeric(len) | length(len) != 1) {
    stop("len must be a numeric of length one")
  }
  if (!is.character(id_prefix) | length(id_prefix) != 1) {
    stop("id_prefix must be a character vector of length one")
  }

  input_ids <- paste0(id_prefix, seq_len(len))

  purrr::map_chr(purrr::map(input_ids, FUN, ...), as.character)
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
#' gen_input_map(FUN = numericInput, id_prefix = "itemprice_", uid = c(1, 3, 5, 7), ...)
#' @export

gen_input_map <- function(FUN, id_prefix, uid, ...) {
  if (!requireNamespace("purrr", quietly = TRUE)) stop("Package `purrr` is required!", call. = FALSE)

  if (length(uid) != length(unique(uid))) {
    stop("All values of uid must be unique")
  }
  if (!is.character(id_prefix) | length(id_prefix) != 1) {
    stop("id_prefix must be a character vector of length one")
  }

  input_ids <- purrr::map(uid, ~ paste0(id_prefix, .))

  purrr::map_chr(purrr::map(input_ids, FUN, ...), as.character)
}
