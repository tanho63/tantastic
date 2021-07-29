.onLoad <- function(libname,pkgname){

  if(requireNamespace("extrafont",quietly = TRUE)){
    fontimport_plex_sans()
    fontimport_bai_jamjuree()
    # fontimport_plex_condensed()
    # fontimport_jost()
  }

}
