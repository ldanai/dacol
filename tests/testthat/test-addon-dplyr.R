context("Addon-dplyr")

test_that("count_pct works", {

  df = data.frame(x = c(1, 2, 3, 4, 5),
                  y = c("b", "a", "k", "b", "k"),
                  z = c(5, 8, 8, 6, 5))

  expect_equal(nrow(count_pct(df, y)), 3)
  expect_equal(nrow(count_pct(df, z)), 3)

  expect_equal(nrow(count_pct_group(df, z)), 3)
})
