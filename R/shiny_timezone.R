#' Get User's Reported Time Zone
#'
#' Uses some Javascript to pass the client's timezone to the Shiny session.
#'
#' @rdname shiny_timezone
#'
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
#'     time <- format(Sys.time(), format = "%x %X", tz = tz)
#'     output$time <- renderText(paste0(tz,": ", time))
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
        var time_now = new Intl.DateTimeFormat().resolvedOptions().timeZone
        $("input#', inputId, '").val(time_now)
      });
    ')
    )
  )
}

#' Get User's Reported Time Zone
#'
#' @rdname shiny_timezone
#' @param inputId character string, name of shiny input. Defaults to "_client_tz".
#' When used in `use_client_tz`, may need to be namespaced if called within a module.
#' @param session a `shiny::session` object, defaults to `shiny::getDefaultReactiveDomain`
#'
#' @return timezone
#' @export
#'
get_client_tz <- function(inputId = "_client_tz", session = shiny::getDefaultReactiveDomain()) {
  tz <- shiny::isolate(session$input[[inputId]])
  return(tz)
}
