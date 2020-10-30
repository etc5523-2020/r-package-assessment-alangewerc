## code to prepare `preProcessedCovidData` dataset goes here

preProcessedCovidData <- read.csv('data-raw/preProcessedCovidData.csv')
preProcessedCovidData$date <-  as.Date(preProcessedCovidData$date, format = "%m/%d/%Y")

usethis::use_data(preProcessedCovidData, overwrite = TRUE)
