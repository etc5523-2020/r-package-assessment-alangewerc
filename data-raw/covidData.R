## code to prepare `covidData` dataset goes here

covidData <- read.csv('data-raw/covidData.csv')
covidData$date <-  as.Date(covidData$date, format = "%m/%d/%Y")

covidData <- melt(data = covidData, id.vars = c("Country", "date"), measure.vars = c("total_cases", "new_cases", "total_deaths", "new_deaths",
                                                                                  "total_cases_per_million", "new_cases_per_million",
                                                                                  "total_deaths_per_million", "new_deaths_per_million"))

usethis::use_data(covidData, overwrite = TRUE)
