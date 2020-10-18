#' Shiny App Function
#'
#' @return Shinny App Function
#'
#' @example
#' yourPkg::launch_app()
#'
#' @export
launch_app <- function() {
  appDir <- system.file("app", "myapp", package = "yourPkg")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `yourPkg`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
