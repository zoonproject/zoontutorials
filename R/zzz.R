# when the package is loaded, copy maxent to the dismo java folder (needed for Travis)
.onLoad <- function (libname, pkgname) {

  maxent_loc <- file.path(system.file(package = 'zoontutorials'), 'java/maxent.jar')
  dismo_loc <- file.path(system.file(package = 'dismo'), 'java/maxent.jar')

  if (!file.exists(dismo_loc))
    file.copy(maxent_loc, dismo_loc)

}
