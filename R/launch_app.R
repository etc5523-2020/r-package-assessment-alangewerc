#' Launch App Function
#'
#' @return Shinny App
#'
#' @examples
#' \dontrun{
#' launch_app()
#' }
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
