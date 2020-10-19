#' plot_cases Function
#'
#' @param covid_stat
#' @param label
#' @param title
#' @param country_compare
#'
#' @return a plot using plotly and ggplot
#'
#'@import shiny
#'
#' @example
#' column_plotly('plotlynewcasesmillion')
#'
#' @export
plot_cases <- function(covid_stat, label, title, country_compare){

  covidplot <- renderPlotly({

  df_total_cases <- covidData%>%
    filter(Country %in% c(country_compare)) %>%
    filter(variable == covid_stat)

  day <- highlight_key(df_total_cases)

  g <- ggplot(day, aes(x = date, y = value, fill = Country)) +
    geom_bar(stat="identity", alpha=0.5, aes(text=sprintf(label, date, Country, value))) +
    theme_bw() + theme(legend.position = "none", axis.title.y = element_blank(), axis.title.x = element_blank()) +
    ggtitle(title)

  ggplotly(g, source = "src", tooltip = "text") %>%
    highlight(selectize=F, off = "plotly_doubleclick", on = "plotly_click", color = "blue",
              opacityDim = 0.5, selected = attrs_selected(opacity = 1))  %>%
    config(displayModeBar = F)
  })

  return (covidplot)
  }
