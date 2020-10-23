## code to prepare `covidData` dataset goes here

covidData1 <- read.csv('data-raw/covidData.csv')
covidData1$date <-  as.Date(covidData1$date, format = "%m/%d/%Y")


covidData <- reshape2::melt(data = covidData1, id.vars = c("Country", "date"), measure.vars = c("total_cases", "new_cases", "total_deaths", "new_deaths",
                                                                                  "total_cases_per_million", "new_cases_per_million",
                                                                                  "total_deaths_per_million", "new_deaths_per_million"))

usethis::use_data(covidData, overwrite = TRUE)
