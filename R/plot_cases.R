globalVariables(c('covidData', 'Country', 'variable', 'value'))

#' plot_cases Function
#'
#' @description This function gives the user a stacked barchart plotly after
#' performing dplyr::filtering in the dataset CovidData
#'
#' @param covid_stat this is a description
#' @param label this is a description
#' @param title this is a description
#' @param country_compare this is a description
#'
#' @examples
#' plot_cases(covid_stat = 'total_deaths_per_million', label = 'Date: %s\nCountry: %s\nDeaths: %s', title = 'Accumulated Deaths per Million', country_compare = input$country_compare)
#'
#' @return a plot using plotly and ggplot
#'
#' @import shiny
#' @import plotly
#' @importFrom ggplot2 ggplot aes geom_bar theme_bw theme element_blank ggtitle
#'
#' @export
plot_cases <- function(covid_stat, label, title, country_compare){

  covidplot <- plotly::renderPlotly({

    df_total_cases <- preProcessedCovidData%>% reshape2::melt(id.vars = c("Country", "date"), measure.vars = c("total_cases", "new_cases", "total_deaths", "new_deaths",
                                                                                                                                  "total_cases_per_million", "new_cases_per_million",
                                                                                                                                  "total_deaths_per_million", "new_deaths_per_million"))%>%

      dplyr::filter(Country %in% c(country_compare)) %>%
      dplyr::filter(variable == covid_stat)

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
