context("Data transformation")

test_that("Basic transform_cosine works", {
  expect_equal(transform_cosine(0), 1)
  expect_equal(transform_cosine(0, 10), 1)

  expect_lt(transform_cosine(1), 1)
  expect_lt(transform_cosine(-1), 1)

  expect_lt(transform_cosine(9, 10), 1)
  expect_lt(transform_cosine(-9, 10), 1)

  expect_equal(transform_cosine(1e10, 1), 0)
  expect_equal(transform_cosine(-1e10, 1), 0)
})


test_that("Basic transform_logistic works", {
  expect_equal(transform_logistic(0), 0)
  expect_equal(transform_logistic(0, 10), 0)

  expect_lt(transform_logistic(1), 1)
  expect_lt(transform_logistic(-1), 1)

  expect_lt(transform_logistic(9, 10), 1)
  expect_lt(transform_logistic(-9, 10), 1)

  expect_equal(transform_logistic(1e5, 1), 1)
  expect_equal(transform_logistic(-1e5, 1), -1)
})


test_that("Basic transform_zscore works", {
  x = seq(1, 10)
  expect_equal(length(transform_zscore(x)), length(x))
  expect_equal(mean(transform_zscore(x)), 0)
  expect_equal(sd(transform_zscore(x)), 1)
})


test_that("Basic dist_canberra works", {
  expect_error(dist_canberra(-1, 1), "x must be non negative value")
  expect_error(dist_canberra(1, -1), "y must be non negative value")
  expect_error(dist_canberra(-1, -1), "x must be non negative value")

  expect_equal(dist_canberra(0, 0), NaN)

  expect_equal(dist_canberra(0, 1e10), 0)
  expect_equal(dist_canberra(1e10, 0), 1)
  expect_equal(dist_canberra(1, 1e10), 0)
  expect_lt(dist_canberra(1e10, 1), 1)

  expect_lt(dist_canberra(1, 2), 1)
  expect_lt(dist_canberra(10, 4), 1)
})


