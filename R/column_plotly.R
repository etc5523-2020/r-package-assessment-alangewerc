#' column_plotly Function
#'
#' @description This function generates a column in a fluidrow with a plotly inside
#'
#' @param plot A plotly from the server with covid tidy preprocessed data
#'
#' @return Returns a column with a plotly chart in the ui
#'
#' @import shiny
#'
#' @examples
#' column_plotly(plot = 'plotlytotalcases')
#'
#' @export
column_plotly <- function(plot) {

  n_char <- nchar(plot)
  n_input <- length(plot)

  stopifnot(
    n_char > 0,
    n_input > 0
  )

  column(3, plotlyOutput(plot, height = '300px'))
}
