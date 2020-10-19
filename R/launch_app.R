#' Shiny App Function
#'
#' @return Shinny App Function
#'
#'
#' @export
launch_app <- function() {
  appDir <- system.file("app", "myapp", package = "CovidShiny")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `CovidShiny`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
