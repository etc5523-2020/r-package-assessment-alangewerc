#' Our World in Data's Covid Dataset
#'
#' A dataset containing the evolution of the variables related to Covid in 2020
#' Socioeconomic data is also available in the table but not used for the shiny APP
#' This dataset is the same of the preProcessedCovidData after melting operations - making it tidy
#' Only a few covid-related variables are explored in the shiny app
#'
#' @format a data.frame with 358480 observations and 4 variables
#'
#' - **Country**: full country name
#' - **date**: the date of the day
#' - **variable**: the variable related to COVID-19, such as number of cases in the day, number of deaths and more
#' - **value**: The actual number that relates to the variable, the country and the date
#'
#'@source [Our World in Data](https://ourworldindata.org/coronavirus)
"covidData"
