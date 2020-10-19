#' plot_cases Function
#'
#' @param covid_stat this is a description
#' @param label this is a description
#' @param title this is a description
#' @param country_compare this is a description
#'
#' @return a plot using plotly and ggplot
#'
#' @import shiny
#' @import plotly
#'
#'
#' @export
plot_cases <- function(covid_stat, label, title, country_compare){

  covidplot <- plotly::renderPlotly({

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
