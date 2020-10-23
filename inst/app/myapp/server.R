############################################
# Alan Gewerc                           ####
# Master of Data Science                ####
# Communicating with Data - ETC5523     ####
############################################


# Import Libraries
library(dplyr)
library(ggplot2)
library(glue)
library(gt)
library(leaflet)
library(markdown)
library(patchwork)
library(plotly)
library(plyr)
library(reshape)
library(shinythemes)
library(stringr)
library(htmlwidgets)
library(tidyverse)
library(formattable)


# Server function
function(input, output, session) {

  output$plot <- renderPlot({
    plot(cars, type=input$plotType)
  })

  output$summary <- renderPrint({
    summary(cars)
  })


  ################################################
  ################################################
  ###### Creating 3 dot density maps
  ###### According to the  action
  ###### button choise of the user
  ################################################


  output$map <-  renderLeaflet({

    df_covid_map <- preProcessedCovidData%>%
      filter(date == input$time)

    content <- paste(sep = "<br/>",
                     paste0("<b>",'Date: ', df_covid_map$date, "</b>"),
                     paste0("<b>",'Country :', df_covid_map$Country, "</b>"),
                     paste0("<b>",'Cases: ', comma(df_covid_map$total_cases, digits = 0), "</b>")
    )


    leaflet(df_covid_map) %>%
      addTiles() %>% # add tile
      setView(lng = 0, lat = 20, zoom = 2) %>%
      addCircleMarkers(lng = ~longitude, # add marker
                       color = "#03F",
                       lat = ~latitude,
                       dashArray = NULL,
                       weight = 1,
                       layerId = ~Country,
                       fillOpacity = 0.3,
                       popup = content,
                       radius = ~total_cases**(1/4.5))
  })


  observeEvent(input$total_cases, {

    output$map <-  renderLeaflet({

      df_covid_map <- preProcessedCovidData%>%
        filter(date == input$time)

      content <- paste(sep = "<br/>",
                       paste0("<b>",'Date: ', df_covid_map$date, "</b>"),
                       paste0("<b>",'Country :', df_covid_map$Country, "</b>"),
                       paste0("<b>",'Cases: ', comma(df_covid_map$total_cases, digits = 0), "</b>")
      )


      leaflet(df_covid_map) %>%
        addTiles() %>% # add tile
        setView(lng = 0, lat = 20, zoom = 2) %>%
        addCircleMarkers(lng = ~longitude, # add marker
                         color = "#03F",
                         lat = ~latitude,
                         dashArray = NULL,
                         weight = 1,
                         layerId = ~Country,
                         fillOpacity = 0.3,
                         popup = content,
                         radius = ~total_cases**(1/4.5))
    })

  })

  observeEvent(input$total_cases_per_million, {

    output$map <-  renderLeaflet({

      df_covid_map <- preProcessedCovidData%>%
        filter(date == input$time)

      content <- paste(sep = "<br/>",
                       paste0("<b>",'Date: ', df_covid_map$date, "</b>"),
                       paste0("<b>",'Country: ', df_covid_map$Country, "</b>"),
                       paste0("<b>",'Cases: ', comma(df_covid_map$total_cases_per_million, digits = 0), "</b>")
      )

      leaflet(df_covid_map) %>%
        addTiles() %>% # add tile
        setView(lng = 0, lat = 20, zoom = 2) %>%
        addCircleMarkers(lng = ~longitude, # add marker
                         color = "#03F",
                         lat = ~latitude,
                         dashArray = NULL,
                         weight = 1,
                         layerId = ~Country,
                         fillOpacity = 0.3,
                         popup = content,
                         radius = ~total_cases_per_million**(1/2)/8) # using a chosen arbitrary scale
    })

  })


  #####################################
  ## Table - using GT
  #####################################

  output$table <- render_gt(
    expr =
      preProcessedCovidData%>%
      filter(date == input$time) %>%
      select(Country, total_cases, new_cases, total_cases_per_million, new_cases_per_million)%>%
      magrittr::set_names(c("Country", "Accumulated Cases", "New Cases",  "Accumulated Cases /Million", "New Cases/Million")) %>%
      arrange(desc(`New Cases`)) %>%
      slice_head(n = 10) %>%
      gt() %>%
      tab_header(
        title = "Top 10 Countries of the Day",
        subtitle = "By Number of New Cases") %>%
      cols_align(
        align = "left",
        columns = vars(Country)) %>%
      cols_align(
        align = "right",
        columns = vars("Accumulated Cases", "New Cases",  "Accumulated Cases /Million", "New Cases/Million")) %>%
      fmt_number(columns =
                   vars("Accumulated Cases", "New Cases",  "Accumulated Cases /Million", "New Cases/Million"),
                 decimals = 0)
  )

  #####################################
  ## Plotly - Second Page
  #####################################

  output$clicked <- renderPrint({
    s <- event_data("plotly_click", source = "src", priority   = "event")
    s
  })


  # Create 8 plots for the second page
  # Using plot_cases Function
  # parameters are covid_stat, label, title and country_compare

  output$plotlytotalcases <- plot_cases(covid_stat = 'total_cases',
                                        label = 'Date: %s\nCountry: %s\nCases: %s',
                                        title = 'Accumulated Cases',
                                        country_compare = input$country_compare)

  output$plotlynewcases <- plot_cases(covid_stat = 'new_cases',
                                      label = 'Date: %s\nCountry: %s\nCases: %s',
                                      title = 'New Cases',
                                      country_compare = input$country_compare)

  output$plotlynewdeaths <- plot_cases(covid_stat = 'total_deaths',
                                       label = 'Date: %s\nCountry: %s\nDeaths: %s',
                                       title = 'Accumulated Deaths',
                                       country_compare = input$country_compare)

  output$plotlytotaldeaths <- plot_cases(covid_stat = 'new_deaths',
                                         label = 'Date: %s\nCountry: %s\nCases: %s',
                                         title = 'New Deaths',
                                         country_compare = input$country_compare)

  output$plotlytotalcasesmillion <- plot_cases(covid_stat = 'total_cases_per_million',
                                               label = 'Date: %s\nCountry: %s\nCases: %s',
                                               title = 'Accumulated Cases per Million',
                                               country_compare = input$country_compare)

  output$plotlynewcasesmillion <- plot_cases(covid_stat = 'new_cases_per_million',
                                             label = 'Date: %s\nCountry: %s\nCases: %s',
                                             title = 'New Cases per Million',
                                             country_compare = input$country_compare)

  output$plotlytotaldeathsmillion <- plot_cases(covid_stat = 'total_deaths_per_million',
                                                label = 'Date: %s\nCountry: %s\nDeaths: %s',
                                                title = 'Accumulated Deaths per Million',
                                                country_compare = input$country_compare)


  ## New Deaths per Million Plot
  # This plot is different because it holds the legends
  # so the plotcases function does not apply for it

  output$plotlynewdeathsmillion <- renderPlotly({

    df_total_cases <- covidData%>%
      filter(Country %in% c(input$country_compare)) %>%
      filter(variable == 'new_deaths_per_million')

    day <- highlight_key(df_total_cases)

    g <- ggplot(day, aes(x = date, y = value, fill = Country)) +
      geom_bar(stat="identity", alpha=0.5, aes(text=sprintf('Date: %s\nCountry: %s\nDeaths: %s', date, Country, value))) +
      theme_bw() + theme(legend.text = element_text(color = "black", size = 20),
                         legend.position = "bottom", legend.margin=margin(t = 1, unit='cm'),
                         axis.title.y = element_blank(), axis.title.x = element_blank()) +
      ggtitle("New Deaths per Million")

    ggplotly(g, showlegend = FALSE, source = "src", tooltip = "text") %>%
      highlight(selectize=F, off = "plotly_doubleclick", on = "plotly_click", color = "blue", showlegend = FALSE,
                opacityDim = 0.5, selected = attrs_selected(opacity = 1))%>%
      layout(legend = list(orientation = "h", x = -0.0, y =-0.2)) %>%
      onRender("function(el,x){el.on('plotly_click', function(){ return false})}") %>%
      config(displayModeBar = F)

  })

}
