#' Tan's theme - dark
#'
#' Largely inspired by hrbrthemes's modern rc
#'
#'@export
theme_tantastic <- function(base_family = "IBM Plex Sans",
                            base_size = 11.5,
                            plot_title_family = "Bai Jamjuree",
                            plot_title_size = 18,
                            plot_title_face = "bold",
                            plot_title_margin = 10,
                            subtitle_family = base_family,
                            subtitle_size = 14,
                            subtitle_face = "plain",
                            subtitle_margin = 15,
                            strip_text_family = base_family,
                            strip_text_size = 14,
                            strip_text_face = "plain",
                            caption_family = "Bai Jamjuree",
                            caption_size = 12,
                            caption_face = "plain",
                            caption_margin = 10,
                            axis_text_size = base_size,
                            axis_title_family = base_family,
                            axis_title_size = 12,
                            axis_title_face = "plain",
                            axis_title_just = "rt",
                            plot_margin = ggplot2::margin(30, 30, 30, 30),
                            grid = TRUE,
                            axis = FALSE,
                            ticks = FALSE) {

  grid_col <- axis_col <- "#333333"
  def_fore <- "#57c1f1"
  set_geom_defaults(def_fore)

  ret <- ggplot2::theme_minimal(base_family = base_family, base_size = base_size)

  ret <- ret + ggplot2::theme(plot.title.position = "plot",
                              legend.background = ggplot2::element_blank(),
                              legend.key = ggplot2::element_blank())

  if (inherits(grid, "character") | grid == TRUE) {
    ret <- ret +
      ggplot2::theme(
        panel.grid = ggplot2::element_line(color = grid_col, size = 0.2),
        panel.grid.major = ggplot2::element_line(color = grid_col, size = 0.2),
        panel.grid.minor = ggplot2::element_line(color = grid_col, size = 0.15),
      )

    if (inherits(grid, "character")) {
      if (regexpr("X|x", grid)[1] < 0) ret <- ret + ggplot2::theme(panel.grid.major.x = ggplot2::element_blank())
      if (regexpr("Y|y", grid)[1] < 0) ret <- ret + ggplot2::theme(panel.grid.major.y = ggplot2::element_blank())
    }
  } else {
    ret <- ret + ggplot2::theme(panel.grid = ggplot2::element_blank())
  }

  if (inherits(axis, "character") | axis == TRUE) {
    ret <- ret + ggplot2::theme(axis.line = ggplot2::element_line(color = "white", size = 0.15))

    if (inherits(axis, "character")) {
      axis <- tolower(axis)

      if (regexpr("x", axis)[1] < 0) {
        ret <- ret + ggplot2::theme(axis.line.x = ggplot2::element_blank())
      } else {
        ret <- ret + ggplot2::theme(axis.line.x = ggplot2::element_line(color = axis_col, size = 0.15))
      }
      if (regexpr("y", axis)[1] < 0) {
        ret <- ret + ggplot2::theme(axis.line.y = ggplot2::element_blank())
      } else {
        ret <- ret + ggplot2::theme(axis.line.y = ggplot2::element_line(color = axis_col, size = 0.15))
      }
    } else {
      ret <- ret + ggplot2::theme(
        axis.line.x = ggplot2::element_line(color = axis_col, size = 0.15),
        axis.line.y = ggplot2::element_line(color = axis_col, size = 0.15)
      )
    }
  } else {
    ret <- ret + ggplot2::theme(axis.line = ggplot2::element_blank())
  }

  if (!ticks) {
    ret <- ret + ggplot2::theme(
      axis.ticks = ggplot2::element_blank(),
      axis.ticks.x = ggplot2::element_blank(),
      axis.ticks.y = ggplot2::element_blank())
  } else {
    ret <- ret +
      ggplot2::theme(
        axis.ticks = ggplot2::element_line(size = 0.15),
        axis.ticks.x = ggplot2::element_line(size = 0.15),
        axis.ticks.y = ggplot2::element_line(size = 0.15),
        axis.ticks.length = grid::unit(5, "pt")
      )
  }

  xj <- switch(
    tolower(substr(axis_title_just, 1, 1)),
    b = 0,
    l = 0,
    m = 0.5,
    c = 0.5,
    r = 1,
    t = 1
  )

  yj <- switch(
    tolower(substr(axis_title_just, 2, 2)),
    b = 0,
    l = 0,
    m = 0.5,
    c = 0.5,
    r = 1,
    t = 1
  )

  ret <- ret +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(size = axis_text_size, margin = ggplot2::margin(t = 0)),
      axis.text.y = ggplot2::element_text(size = axis_text_size, margin = ggplot2::margin(r = 0)),
      axis.title = ggplot2::element_text(size = axis_title_size, family = axis_title_family),
      axis.title.x = ggplot2::element_text(hjust = xj,
                                           size = axis_title_size,
                                           family = axis_title_family,
                                           face = axis_title_face),
      axis.title.y = ggplot2::element_text(hjust = yj,
                                           size = axis_title_size,
                                           family = axis_title_family,
                                           face = axis_title_face),
      strip.text = ggplot2::element_text(hjust = 0,
                                         size = strip_text_size,
                                         face = strip_text_face,
                                         family = strip_text_family),
      panel.spacing = grid::unit(2, "lines"),
      plot.title = ggplot2::element_text(hjust = 0,
                                         size = plot_title_size,
                                         margin = ggplot2::margin(b = plot_title_margin),
                                         family = plot_title_family,
                                         face = plot_title_face),
      plot.subtitle = ggplot2::element_text(
        hjust = 0, size = subtitle_size,
        margin = ggplot2::margin(b = subtitle_margin),
        family = subtitle_family, face = subtitle_face
      ),
      plot.caption = ggplot2::element_text(
        hjust = 1,
        size = caption_size,
        margin = ggplot2::margin(t = caption_margin),
        family = caption_family,
        face = caption_face
      ),
      plot.margin = plot_margin
    )

  bkgrnd <- "#1e1e1e"
  fgrnd <- "#e0e0e0"

  ret <- ret +
    ggplot2::theme(
      rect = ggplot2::element_rect(fill = bkgrnd, color = bkgrnd),
      plot.background = ggplot2::element_rect(fill = bkgrnd, color = bkgrnd),
      panel.background = ggplot2::element_rect(fill = bkgrnd, color = bkgrnd),
      text = ggplot2::element_text(color = fgrnd),
      axis.text = ggplot2::element_text(color = fgrnd),
      strip.text = ggplot2::element_text(color = fgrnd),
      title = ggplot2::element_text(color = "white"),
      plot.title = ggplot2::element_text(color = "white"),
      plot.subtitle = ggplot2::element_text(color = "#8e8e93"),
      line = ggplot2::element_line(color = fgrnd),
      axis.ticks = ggplot2::element_line(color = fgrnd))

  ret
}

#' Update geom defaults
#'
#' @param colour colour of geom default
#'
set_geom_defaults <- function(colour) {
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
