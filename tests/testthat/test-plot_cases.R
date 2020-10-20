test_that("output plotly", {

    res <- plot_cases(covid_stat = 'new_cases', label = 'simple label', title = 'New cases', country_compare = 'Australia')
    expect_true(class(res)[1] == "shiny.render.function")
})
