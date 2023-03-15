#' Get User's Timezone (approximately)
#'
#' Uses some Javascript to pass the client's timezone to the Shiny session. This doesn't
#' actually find the client's timezone as much as it finds "how far are they from UTC",
#' but it's useful for giving an approximation that passes the smell test.
#'
#' @rdname shiny_timezone
#' @param inputId character string, name of shiny input. Defaults to `"_client_tz"`.
#' When used in `use_client_tz()`, may need to be namespaced if called within a module.
#'
#' @examples
#' if(interactive()){
#'
#' shiny::shinyApp(
#'   ui = shiny::fluidPage(use_client_tz(), shiny::textOutput("time")),
#'   server = function(input, output, session) {
#'     # can be used outside of reactive context, if desired
#'     tz <- get_client_tz()
#'     output$time <- renderText(format(Sys.time(), format = "%x %X", tz = tz))
#'   }
#' )
#' }
#' @export
#' @return `use_client_tz()`: HTML tags to be included in Shiny UI
use_client_tz <- function(inputId = "_client_tz"){
  shiny::tagList(
    shiny::tags$input(type = "text", id = inputId, style = "display: none;"),
    shiny::tags$script(
      paste0('
      $(function() {
        var time_now = new Date()
        $("input#', inputId, '").val(time_now.getTimezoneOffset())
      });
    ')
    )
  )
}

#' Get User's Time Zone (Approximately)
#'
#' @rdname shiny_timezone
#' @param inputId character string, name of shiny input. Defaults to "_client_tz".
#' When used in `use_client_tz`, may need to be namespaced if called within a module.
#' @param session a `shiny::session` object, defaults to `shiny::getDefaultReactiveDomain`
#'
#' @return `get_client_tz()` timezone string to be used by format, lubridate etc.
#' Note that Etc/GMT is inverted from the usual UTC string, so UTC-5 is equivalent Etc/GMT+5.
#'
#' @export
#'
#' @seealso <https://en.wikipedia.org/wiki/Tz_database#Area>
#' @seealso <https://stackoverflow.com/questions/24842229> from which this code is adapted
get_client_tz <- function(inputId = "_client_tz", session = shiny::getDefaultReactiveDomain()) {
  offset <- shiny::isolate(session$input[[inputId]])
  offset_hours <- round(as.numeric(offset) / 60)
  tz_prefix <- if(!is.null(offset_hours) || offset_hours > 0) "+" else ""
  tz <- paste0("Etc/GMT", tz_prefix, offset_hours)
  return(tz)
}
