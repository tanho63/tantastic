.onLoad <- function(libname,pkgname){

  if(requireNamespace("extrafont",quietly = TRUE)){
    import_plex_sans()
    import_plex_condensed()
  }




}

.onAttach <- function(libname,pkgname){

  if(requireNamespace("extrafont", quietly = TRUE)){
    cli::cli_alert_info("Importing fonts: Plex Sans/Condensed")
  }

}
