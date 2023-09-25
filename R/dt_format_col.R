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
#' @param colour_steps number: how many distinct colours to create, default 100
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
                       column_range = NULL,
                       colours = c("#9162C5", "#F1F1F1", "#6BA359"),
                       reverse_colours = FALSE,
                       colour_steps = 100) {
  rlang::check_installed(c("DT", "colorspace"))

  assertions <- c(
    "`dt` must be a DT::datatable()" = inherits(dt, "datatables"),
    "`columns` must be provided" = length(columns) > 0,
    "`column_range` should be numeric or NULL" = is.numeric(column_range) || is.null(column_range),
    "`colours` should be a vector of at least two elements" = length(colours) >= 2,
    "`reverse_colours` should be TRUE or FALSE" = reverse_colours %in% c(TRUE, FALSE),
    "`colour_steps` should be a single numeric" = is.numeric(colour_steps) && length(colour_steps) == 1
  )

  if(!all(assertions)) {
    failing <- names(assertions)[assertions]
    cli::cli_abort(assertions)
  }

  # retrieve internal table dataframe
  df <- dt$x$data

  check_col_types <- sapply(columns, \(x) is.numeric(df[[x]]))
  if (!all(check_col_types)) {
    failing <- columns[which(!check_col_types)]
    cli::cli_abort("Columns must be numeric - {failing} are not numeric")
  }

  if (reverse_colours) colours <- rev(colours)

  steps <- seq.int(from = 1 / colour_steps, to = 1 - 1 / colour_steps, by = 1 / colour_steps)
  bg_col <- grDevices::colorRampPalette(colours)(colour_steps)
  # calculate whether text should be white or black
  fg_col <- .choose_font_colour(bg_col)

  for (i in columns) {
    if (!is.null(column_range)) r <- range(column_range, na.rm = TRUE)
    if (is.null(column_range)) r <- range(df[i], na.rm = TRUE)

    # create breakpoints to split into twenty colours
    b <- stats::quantile(r, probs = steps, na.rm = TRUE)

    # apply colour formatting
    dt <- DT::formatStyle(
      table = dt,
      columns = i,
      backgroundColor = DT::styleInterval(b, bg_col),
      color = DT::styleInterval(b, fg_col)
    )
  }

  dt
}

.choose_font_colour <- function(bg_colour) {
  black_contrast <- abs(colorspace::contrast_ratio("#0d0d0d", bg_colour, algorithm = "APCA")[, 1])
  white_contrast <- abs(colorspace::contrast_ratio("#f2f2f2", bg_colour, algorithm = "APCA")[, 1])
  vec <- ifelse(black_contrast > white_contrast, "#0d0d0d", "#f2f2f2")
  return(vec)
}

#' @export
fmt_dtcol <- dt_fmt_col
