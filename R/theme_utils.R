
#' Update geom defaults
#'
#' @param colour colour of geom default
#'
set_geom_colour_defaults <- function(colour = "#57c1f1") {
  geoms <- c(
    "abline", "area", "bar", "boxplot", "col", "crossbar",
    "density", "dotplot", "errorbar", "errorbar",
    "hline", "label", "line", "linerange",
    "map", "path", "point", "polygon", "rect", "ribbon", "rug", "segment",
    "step", "text", "tile", "violin", "vline"
  )

  for (g in geoms) {
    ggplot2::update_geom_defaults(g, list(colour = colour, fill = colour))
  }
}

#' Update matching font defaults for text geoms
#'
#' Updates [ggplot2::geom_label] and [ggplot2::geom_text] font defaults
#'
#' @param family,face,size,color font family name, face, size and color
#' @export
set_geom_font_defaults <- function(family="IBM Plex Sans", face="plain", size=3.5,
                                   color = "#2b2b2b") {
  ggplot2::update_geom_defaults("text", list(family=family, face=face, size=size, color=color))
  ggplot2::update_geom_defaults("label", list(family=family, face=face, size=size, color=color))
}
