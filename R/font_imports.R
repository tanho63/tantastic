#### tan's ggplot themes ####
#' font imports
#' @export
#' @rdname fontimport
#' @keywords internal
fontimport_plex_sans <- function() {
  if (!requireNamespace("extrafont", quietly = TRUE)) stop("Package `extrafont` is required!", call. = FALSE)

  ps_font_dir <- system.file("fonts", "plex-sans", package = "tantastic")
  suppressMessages(extrafont::font_import(ps_font_dir, prompt = FALSE))
}

#' font imports
#' @rdname fontimport
#' @keywords internal
#' @export
fontimport_plex_condensed <- function() {
  if (!requireNamespace("extrafont", quietly = TRUE)) stop("Package `extrafont` is required!", call. = FALSE)

  ps_font_dir <- system.file("fonts", "plex-condensed", package = "tantastic")
  suppressMessages(extrafont::font_import(ps_font_dir, prompt = FALSE))
}

#' font imports
#' @rdname fontimport
#' @keywords internal
#' @export
fontimport_bai_jamjuree <- function() {
  if (!requireNamespace("extrafont", quietly = TRUE)) stop("Package `extrafont` is required!", call. = FALSE)

  ps_font_dir <- system.file("fonts", "bai-jamjuree", package = "tantastic")
  suppressMessages(extrafont::font_import(ps_font_dir, prompt = FALSE))
}

#' font imports
#' @rdname fontimport
#' @keywords internal
#' @export
fontimport_jost <- function() {
  if (!requireNamespace("extrafont", quietly = TRUE)) stop("Package `extrafont` is required!", call. = FALSE)

  ps_font_dir <- system.file("fonts", "jost", package = "tantastic")
  suppressMessages(extrafont::font_import(ps_font_dir, prompt = FALSE))
}
