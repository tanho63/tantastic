#' Colour DT column by range (automatic range)
#'
#' Colours DT columns based on the minimum and maximum of each column.
#' Defaults to a purple-green colour scheme.
#'
#' @param dt a DT object created by \code{DT::datatable()}
#' @param df the original dataframe used to create the DT
#' @param col_id a vector of column identifiers (number or name)
#' @param column_range Either the minimum and maximum range to be coloured, or "Auto" which defaults to the max and min of the table column.
#' @param colours A set of hex colours to be passed on to \code{colorRampPalette()}
#'
#' @return A DT object with added colour formatting
#'
#' @examples
#' datatable(df_players) %>%
#'   fmt_dtcol(dt = ., df = df_players, column_range = "Auto", col_id = c("Height", "Weight"))
#' @export

fmt_dtcol <- function(dt, df, col_id,
                      column_range = "Auto",
                      colours = c("#af8dc3", "#FFFFFF", "#7fbf7b")) {
  if (!requireNamespace("DT", quietly = TRUE)) stop("Package `DT` is required!", call. = FALSE)

  if (column_range != "Auto" && !is.numeric(column_range)) {
    stop("column_range must be a numeric vector or 'Auto'")
  }

  colour_list <- colorRampPalette(colours)

  for (i in col_id) {
    breakvalue <- quantile(range(if (column_range == "Auto") {
      df[i]
    } else {
      column_range
    }), probs = seq(0.05, 0.95, 0.05), na.rm = TRUE)

    dt <- DT::formatStyle(dt, i, backgroundColor = styleInterval(breakvalue, colour_list(20)))
  }
  dt
}
