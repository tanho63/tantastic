#### tan's ggplot themes ####
#' @export
import_plex_sans <- function() {
  if (!requireNamespace("extrafont", quietly = TRUE)) stop("Package `extrafont` is required!", call. = FALSE)

  ps_font_dir <- system.file("fonts", "plex-sans", package = "tantastic")

  suppressWarnings(suppressMessages(extrafont::font_import(ps_font_dir, prompt = FALSE)))
}
#' @export
import_plex_condensed <- function() {
  if (!requireNamespace("extrafont", quietly = TRUE)) stop("Package `extrafont` is required!", call. = FALSE)

  ps_font_dir <- system.file("fonts", "plex-condensed", package = "tantastic")

  suppressWarnings(suppressMessages(extrafont::font_import(ps_font_dir, prompt = FALSE)))
}
