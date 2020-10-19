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


# List of Countries
country_vector <- unique(preProcessedCovidData$Country)

# List of dates in date format
date_seq <- seq(as.Date('2019-12-31'),as.Date('2020-09-27'),by = 1)

ui <- fluidPage(
  theme = shinytheme("flatly"),

  navbarPage("COVID-19 ANALYSIS",


             ##################################
             ########## Page 1
             ########## Table and map
             ########## 2 Action buttons and
             ########## a slider input
             ##################################

           tabPanel("Map",

                      div(style = "padding: 20px;color: blue; text-align: justify; height:200px;width:100%;background-color: #F0F8FF;border-style: none;border-color: #000000",
                          tags$h4("Geographic Analysis"),
                          "Welcome! This shiny dashboard was developed to help us understand the spread of COVID-19 across the world.
                          In this page, we have a geographic visualisation of the total number of cases observed in each country every day since 2019. We also have a table
                          that presents the countries with the highest number of new cases of COVID-19 each day. There are also some interactive
                          features in this page:",br(),
                          tags$li("There are two options of point-maps to choose from. The first is the total number of COVID-19 accumulated cases and
                          the second is the same number divided by 1 million habitants of the country. To Choose use the buttons action buttons."),
                          tags$li("By manipulating the slider, one can control the date of this page, updating both the point-map and the table."),
                          tags$li("To know the total number of cases in a country on a certain date, just click in the red point of the country that the number will pop-up."),
                      ),

                    fluidRow(br(),br(),

                        column(4,

                               sliderInput("time",
                                           "date",
                                           min(date_seq),
                                           max(date_seq),
                                           value = max(date_seq),
                                           step=1,
                                           animate=FALSE)

                        ),
                        actionButton("total_cases", "Accumulated Cases"),
                        actionButton("total_cases_per_million", "Accumulated Cases per Million Habs.")

                        ),

                    fluidRow(
                        column(7,
                               leafletOutput("map", height = '600px')
                        ),
                        column(4,
                               gt_output('table')
                        )
                        )
                    ),


           ##################################
           ########## Second Page
           ########## 8 Plotly plots
           ##################################


           tabPanel("Plots",
                    div(style = "padding: 20px;color: blue; text-align: justify; height:120px;width:100%;background-color: #F0F8FF;border-style: none;border-color: #000000",
                        tags$h4("Quantitative Analysis"),
                        "In this page we can analyse the evolution of a range of variables related to COVID-19. We use stacked barplots where each of the bars
                        referes to a country. When opening this webpage the chosen countries are the US, India and Brazil, 3 of the most affected countries
                        by the pandemic. You can use the select box to choose as many countries as you want. To analyse a unique day of a country you can hover
                        over or click in the bar. When clicking it should color in blue the country."
                        ),

                    br(),br(),

                    selectInput(
                      inputId = 'country_compare',
                      label = 'Select One or More Countries',
                      choices = country_vector,
                      multiple = TRUE,
                      selected = c('United States', 'Brazil', 'India')
                      ),

                    fluidRow(
                      column_plotly("plotlytotalcases"),
                      column_plotly("plotlynewcases"),
                      column_plotly("plotlytotaldeaths"),
                      column_plotly("plotlynewdeaths")
                      ),


                    fluidRow(

                      column_plotly("plotlytotalcasesmillion"),
                      column_plotly("plotlynewcasesmillion"),
                      column_plotly("plotlytotaldeathsmillion"),

                      column(3,
                             plotlyOutput("plotlynewdeathsmillion", height = '400px')
                             )

                      )

                    ),

           ##################################
           ########## About Page
           ##################################


           tabPanel("About",

                    fluidRow(

                      column(width = 4,  align="center",
                             br(),
                             br(),
                             img(src='covid.jpg', height = '300px', width = '250px', class="circular--square", style="border-radius:50%"),
                             ),

                      column(4, align="center",
                             br(),
                             br(),
                             br(),
                             br(),
                             img(src='monash.jpg', height = '170px', width = '400px'),
                      ),

                      column(4, align="center",
                             br(),
                             br(),
                             img(src='IMG_2609.jpg', height = '300px', width = '250px', class="circular--square", style="border-radius:50%"),
                      )
                      ),
                    fluidRow(
                      column(4,
                             br(),
                             div(style = "padding: 15px 15px 15px 15px; text-align: justify; height:300px;width:100%;background-color: #F0F8FF;border-style: none;border-color: #000000",
                                 tags$h4("
                                 Coronavirus (COVID-19) is an infectious disease caused by a newly discovered virus.
                                 Most people who fall sick with COVID-19 will experience mild to moderate symptoms and recover without special treatment.
                                 Until the 5th of October, 2020 more than 35 million people had been infected by the virus across the world leading to over
                                 1 million deaths. In this Dashboard we seek to follow the evolution of numbers of the virus across the world over 2020. We can
                                 observe which countries are more affected by total and relative numbers.

                                         "))
                             ),

                      column(4,
                             br(),
                             div(style = "padding: 15px 15px 15px 15px; text-align: justify; height:300px;width:100%;background-color: #F0F8FF;border-style: none;border-color: #000000",
                                 tags$h4("
                                 The present project was developed for the unit Communicating with Data - ETC5523 from the Monash Business School. The unit is offered for
                                 students from the Master of Business Analytics or any as optinal unit for students from other courses.", br(),
                                 "Lecturer 1: Emi Tanaka", br(),
                                 "Lecturer 2: Stuart Lee" , br(),
                                 "Tutor: Mitchell O'Hara-Wild"))
                             ),

                      column(4,
                             br(),
                             div(style = "padding: 15px 15px 15px 15px; text-align: justify; height:300px;width:100%;background-color: #F0F8FF;border-style: none;border-color: #000000",
                                 tags$h4("
                                         Alan Gewerc is a Master of Data Science student at Monash University. He has also experience with business, finance and
                                         analytics. He is currently developing a Master Thesis about Forecasting with Neural Networks with applications in the
                                         Medical field. Find more about Alan at:", br(),br(),br(),
                                         "website:     www.alangewerc.com.", br(),
                                         "linkedin:    linkedin.com/in/alan-gewerc.
                                         "))
                             )
                      )
           )
  )

)
