.onLoad <- function(libname,pkgname){

  if(requireNamespace("extrafont",quietly = TRUE)){
    import_plex_sans()
    import_plex_condensed()
  }

}
