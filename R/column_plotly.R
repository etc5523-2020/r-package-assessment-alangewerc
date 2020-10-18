#' column_plotly Function
#'
#' @param plot a plotly from the server with covid tidy preprocessed data
#'
#' @return a column with a plotly chart in the ui
#'
#' @example
#' column_plotly('plotlynewcasesmillion')
#'
#' @export
column_plotly <- function(plot) {
  column(3, plotlyOutput(plot, height = '300px'))
}
