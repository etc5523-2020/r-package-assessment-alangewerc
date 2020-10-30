test_that("Input name plot", {

  possible_plots <- c("plotlytotalcases","plotlynewcases",
                      "plotlytotaldeaths","plotlynewdeaths",
                      "plotlytotalcasesmillion","plotlynewcasesmillion",
                      "plotlytotaldeathsmillion","plotlynewdeathsmillion")

  expect_error(column_plotly(plot %nin% possible_plots)) # Check List of accepted plots
  expect_error(column_plotly(character(0L)))
  expect_error(column_plotly(plot = NULL))
  expect_error(column_plotly(plot = ""))

    })
