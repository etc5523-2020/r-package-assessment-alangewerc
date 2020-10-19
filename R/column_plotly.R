#' column_plotly Function
#'
#' @param plot A plotly from the server with covid tidy preprocessed data
#'
#' @return Returns a column with a plotly chart in the ui
#'
#' @import shiny
#'
#' @example column_plotly(plot = 'plotlytotalcases')
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
