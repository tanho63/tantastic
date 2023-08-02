#' Colour DT column by range
#'
#' Colours DT columns based on the minimum and maximum of each column.
#' Defaults to a purple-green colour scheme HULK which is colourblind-friendly,
#' and naturally associates "green" to "good" and "purple" to "bad".
#'
#' @param dt a DT object created by \code{DT::datatable()}
#' @param columns a character or numeric vector of column identifiers (column names or indices)
#' @param column_range numeric or "auto": either the minimum and maximum range to
#' be coloured, or "auto" which defaults to the max and min of the table column.
#' @param colours A set of hex colours to be passed on to \code{colorRampPalette()},
#' defaults to purple-green
#' @param reverse_colours logical: reverses direction of colour scale
#'
#' @aliases fmt_dtcol
#'
#' @examples
#' DT::datatable(mtcars) |>
#'   # standard: formats high values as green, low values as purple
#'   dt_fmt_col(columns = c("hp", "cyl")) |>
#'   # reverse: formats low values as green, high values as purple
#'   dt_fmt_col(columns = "mpg", reverse_colours = TRUE) |>
#'   # custom colours
#'   dt_fmt_col(columns = "wt", colours = c("orange", "white", "blue"))
#'
#' @export
#' @return A DT object with added colour formatting
dt_fmt_col <- function(dt,
                      columns,
                      column_range = "auto",
                      colours = c("#9162C5", "#F1F1F1", "#6BA359"),
                      reverse_colours = FALSE) {
  rlang::check_installed("DT")

  stopifnot(
    "`dt` must be a DT::datatable()" = inherits(dt, "datatables"),
    "`columns` must be provided" = length(columns) > 0,
    "`column_range` should be numeric or 'auto'" = is.numeric(column_range) || identical(column_range, "auto"),
    "`colours` should be a vector of at least two elements" = length(colours) >= 2,
    "`reverse_colours` should be TRUE or FALSE" = reverse_colours %in% c(TRUE, FALSE)
  )
  # retrieve internal table dataframe
  df <- dt$x$data

  check_col_types <- sapply(columns, \(x) is.numeric(df[[x]]))
  if (!all(check_col_types)) {
    failing <- columns[which(!check_col_types)]
    cli::cli_abort("Selected columns must be numeric - {failing} {?is/are} not numeric")
  }

  if (reverse_colours) colours <- rev(colours)

  colour_list <- grDevices::colorRampPalette(colours)

  for (i in columns) {
    if (column_range != "auto") r <- range(column_range, na.rm = TRUE)
    if (column_range == "auto") r <- range(df[[i]], na.rm = TRUE)

    # create breakpoints to split into twenty colours
    b <- stats::quantile(r, probs = seq(0.05, 0.95, 0.05), na.rm = TRUE)

    # apply colour formatting
    dt <- DT::formatStyle(dt, i, backgroundColor = DT::styleInterval(b, colour_list(20)))
  }

  dt
}

#' @export
fmt_dtcol <- dt_fmt_col
