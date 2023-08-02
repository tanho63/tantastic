test_that("dt_fmt_col() works well", {
  skip_if_not_installed("DT")

  dt <- DT::datatable(mtcars) |>
    dt_fmt_col(columns = c("hp", "cyl")) |>
    dt_fmt_col(columns = "mpg", reverse_colours = TRUE) |>
    dt_fmt_col(columns = "wt", colours = c("orange", "white", "blue"))

  expect_s3_class(dt, "datatables")
  expect_match(
    dt$x$options$rowCallback,
    regexp = "background-color",
    fixed = TRUE
  )
})
