context("Data transformation")

test_that("Basic dc_cosine works", {
  expect_equal(dc_cosine(0), 1)
  expect_equal(dc_cosine(0, 10), 1)

  expect_lt(dc_cosine(1), 1)
  expect_lt(dc_cosine(-1), 1)

  expect_lt(dc_cosine(9, 10), 1)
  expect_lt(dc_cosine(-9, 10), 1)

  expect_equal(dc_cosine(1e10, 1), 0)
  expect_equal(dc_cosine(-1e10, 1), 0)
})


test_that("Basic dc_logistic works", {
  expect_equal(dc_logistic(0), 0)
  expect_equal(dc_logistic(0, 10), 0)

  expect_lt(dc_logistic(1), 1)
  expect_lt(dc_logistic(-1), 1)

  expect_lt(dc_logistic(9, 10), 1)
  expect_lt(dc_logistic(-9, 10), 1)

  expect_equal(dc_logistic(1e5, 1), 1)
  expect_equal(dc_logistic(-1e5, 1), -1)
})


test_that("Basic dc_zscore works", {
  x = seq(1, 10)
  expect_equal(length(dc_zscore(x)), length(x))
  expect_equal(mean(dc_zscore(x)), 0)
  expect_equal(sd(dc_zscore(x)), 1)
})

test_that("Basic dc_trim_outlier works", {
  x = c(seq(1, 10), 1000)
  expect_error(dc_trim_outlier(data.frame(a=1:2, b=1:2)), "x must be vector")
  expect_equal(length(dc_trim_outlier(x)), length(x))
})


test_that("Basic dc_dist_canberra works", {
  expect_error(dc_dist_canberra(-1, 1), "x must be non negative value")
  expect_error(dc_dist_canberra(1, -1), "y must be non negative value")
  expect_error(dc_dist_canberra(-1, -1), "x must be non negative value")

  expect_equal(dc_dist_canberra(0, 0), NaN)

  expect_equal(dc_dist_canberra(0, 1e10), 0)
  expect_equal(dc_dist_canberra(1e10, 0), 1)
  expect_equal(dc_dist_canberra(1, 1e10), 0)
  expect_lt(dc_dist_canberra(1e10, 1), 1)

  expect_lt(dc_dist_canberra(1, 2), 1)
  expect_lt(dc_dist_canberra(10, 4), 1)
})

test_that("Basic dc_dist_cosine works", {
  expect_equal(dc_dist_cosine(c(1, 0), c(1, 0)), 0)
  expect_equal(dc_dist_cosine(c(1, 0), c(0, 1)), 1)

  expect_error(dc_dist_cosine(c(1, 1, 1), c(2, 2)), "x and y must have the same length vectors")
  expect_error(dc_dist_cosine(data.frame(a=1:2, b=1:2), c(1, 0)), "x must be vector")
  expect_error(dc_dist_cosine(c(1, 0), data.frame(a=1:2, b=1:2)), "y must be vector")
})

test_that("Basic dc_dist_euclidean works", {
  expect_equal(dc_dist_euclidean(c(1, 0), c(1, 0)), 0)
  expect_equal(dc_dist_euclidean(c(1, 0), c(0, 1)), sqrt(2))
  expect_equal(dc_dist_euclidean(c(1, 0), c(0, -1)), sqrt(2))
  expect_equal(dc_dist_euclidean(c(-1, 0), c(0, -1)), sqrt(2))

  expect_error(dc_dist_euclidean(c(1, 1, 1), c(2, 2)), "x and y must have the same length vectors")
  expect_error(dc_dist_euclidean(data.frame(a=1:2, b=1:2), c(1, 0)), "x must be vector")
  expect_error(dc_dist_euclidean(c(1, 0), data.frame(a=1:2, b=1:2)), "y must be vector")
})

test_that("Basic dc_dist_pearson works", {
  expect_equal(dc_dist_pearson(c(1, 0), c(0, 1)), 1)
  expect_equal(dc_dist_pearson(c(1, 0), c(-1, 0)), 1)
  expect_lt(dc_dist_pearson(c(1, 0), c(1, 0)), 1e-10)
  expect_lt(dc_dist_pearson(c(0, 1), c(0, 1)), 1e-10)

  expect_error(dc_dist_pearson(c(1, 1, 1), c(2, 2)), "x and y must have the same length vectors")
  expect_error(dc_dist_pearson(data.frame(a=1:2, b=1:2), c(1, 0)), "x must be vector")
  expect_error(dc_dist_pearson(c(1, 0), data.frame(a=1:2, b=1:2)), "y must be vector")
})


test_that("Basic dc_normalize_ptile works", {
  expect_error(dc_normalize_ptile(data.frame(a=1:2, b=1:2)), "x must be vector")

  x = c(seq(1, 10), 1000)
  expect_equal(length(dc_normalize_ptile(x)), length(x))
  expect_equal(min(dc_normalize_ptile(x)), -1)
  expect_equal(max(dc_normalize_ptile(x)), 1)
})


test_that("Basic get_confidence_interval works", {
  expect_error(get_confidence_interval(data.frame(a=1:2, b=1:2)), "x must be vector")
  expect_error(get_confidence_interval(seq(1, 10), level=2), "level must be between 0 and 1")

  x = c(seq(1, 10), 1000)
  expect_equal(get_confidence_interval(x)$mean, mean(x))
})


test_that("Basic dc_decile_band works", {
  expect_error(dc_decile_band(data.frame(a=1:2, b=1:2)), "x must be vector")

  x = c(seq(1, 10), 1000)
  expect_equal(length(dc_decile_band(x)), length(x))
})



test_that("Basic dc_decile_ptile works", {
  expect_error(dc_decile_ptile(data.frame(a=1:2, b=1:2)), "x must be vector")

  x = c(seq(1, 10), 1000)
  expect_equal(length(dc_decile_ptile(x)), length(x))
})

test_that("Basic dc_rank_ptile works", {
  expect_error(dc_rank_ptile(data.frame(a=1:2, b=1:2)), "x must be vector")

  x = c(seq(1, 10), 1000)
  expect_equal(length(dc_rank_ptile(x)), length(x))
})

test_that("Basic dc_mode works", {
  expect_error(dc_mode(data.frame(a=1:2, b=1:2)), "x must be vector")

  x = c(1, 2, 3, 3, 4, 5)
  expect_equal(length(dc_mode(x)), 1)
  expect_equal(dc_mode(x), 3)
  expect_equal(dc_mode(c(1, 2, 3, 4, 5)), 1)

  expect_equal(dc_mode(c(1, 2, 3, 3, NA, 4, 5), na.rm = TRUE), 3)
})

# test_that("Basic mode_stats works", {
#   expect_error(mode_stats(data.frame(a=1:2, b=1:2)), "x must be vector")
#
#   x = c(1, 2, 3, 3, 4, 5)
#   expect_equal(length(mode_stats(x)), 1)
#   expect_equal(mode_stats(x), 3)
#   expect_equal(mode_stats(c(1, 2, 3, 4, 5)), 1)
#
#   expect_equal(mode_stats(c(1, 2, 3, 3, NA, 4, 5), na.rm = TRUE), 3)
# })

test_that("Basic dc_ceiling works", {
  expect_error(dc_ceiling(data.frame(a=1:2, b=1:2)), "x must be vector")

  x = c(5, 21, 39, 31, 40, 15)
  expect_equal(length(dc_ceiling(x)), 6)
  expect_equal(dc_ceiling(x, -1), c(10, 30, 40, 40, 40, 20))
  expect_equal(dc_ceiling(x*10, -2), c(100, 300, 400, 400, 400, 200))

  expect_equal(dc_ceiling(c(1, 2, 3, 3, NA, 4, 5), na.rm = TRUE), c(2, 2, 4, 4, 4, 6))
})


