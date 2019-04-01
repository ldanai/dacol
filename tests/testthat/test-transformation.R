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

test_that("Basic trim_outlier works", {

  expect_error(trim_outlier(data.frame(a=1:2, b=1:2)), "x must be vector")
  expect_equal(length(trim_outlier(c(seq(1, 10), 1000))), length(x))
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

test_that("Basic dist_cosine works", {
  expect_equal(dist_cosine(c(1, 0), c(1, 0)), 0)
  expect_equal(dist_cosine(c(1, 0), c(0, 1)), 1)

  expect_error(dist_cosine(c(1, 1, 1), c(2, 2)), "x and y must have the same length vectors")
  expect_error(dist_cosine(data.frame(a=1:2, b=1:2), c(1, 0)), "x must be vector")
  expect_error(dist_cosine(c(1, 0), data.frame(a=1:2, b=1:2)), "y must be vector")
})

test_that("Basic dist_euclidean works", {
  expect_equal(dist_euclidean(c(1, 0), c(1, 0)), 0)
  expect_equal(dist_euclidean(c(1, 0), c(0, 1)), sqrt(2))
  expect_equal(dist_euclidean(c(1, 0), c(0, -1)), sqrt(2))
  expect_equal(dist_euclidean(c(-1, 0), c(0, -1)), sqrt(2))

  expect_error(dist_euclidean(c(1, 1, 1), c(2, 2)), "x and y must have the same length vectors")
  expect_error(dist_euclidean(data.frame(a=1:2, b=1:2), c(1, 0)), "x must be vector")
  expect_error(dist_euclidean(c(1, 0), data.frame(a=1:2, b=1:2)), "y must be vector")
})

test_that("Basic dist_pearson works", {
  expect_equal(dist_pearson(c(1, 0), c(0, 1)), 1)
  expect_equal(dist_pearson(c(1, 0), c(-1, 0)), 1)
  expect_lt(dist_pearson(c(1, 0), c(1, 0)), 1e-10)
  expect_lt(dist_pearson(c(0, 1), c(0, 1)), 1e-10)

  expect_error(dist_pearson(c(1, 1, 1), c(2, 2)), "x and y must have the same length vectors")
  expect_error(dist_pearson(data.frame(a=1:2, b=1:2), c(1, 0)), "x must be vector")
  expect_error(dist_pearson(c(1, 0), data.frame(a=1:2, b=1:2)), "y must be vector")
})


test_that("Basic normalize_percentile works", {
  expect_error(normalize_percentile(data.frame(a=1:2, b=1:2)), "x must be vector")

  x = c(seq(1, 10), 1000)
  expect_equal(length(normalize_percentile(x)), length(x))
  expect_equal(min(normalize_percentile(x)), -1)
  expect_equal(max(normalize_percentile(x)), 1)
})


test_that("Basic get_confidence_interval works", {
  expect_error(get_confidence_interval(data.frame(a=1:2, b=1:2)), "x must be vector")
  expect_error(get_confidence_interval(seq(1, 10), level=2), "level must be between 0 and 1")

  x = c(seq(1, 10), 1000)
  expect_equal(get_confidence_interval(x)$mean, mean(x))
})


test_that("Basic decile_band works", {
  expect_error(decile_band(data.frame(a=1:2, b=1:2)), "x must be vector")

  x = c(seq(1, 10), 1000)
  expect_equal(length(decile_band(x)), length(x))
})



test_that("Basic decile_ptile works", {
  expect_error(decile_ptile(data.frame(a=1:2, b=1:2)), "x must be vector")

  x = c(seq(1, 10), 1000)
  expect_equal(length(decile_ptile(x)), length(x))
})

test_that("Basic rank_ptile works", {
  expect_error(rank_ptile(data.frame(a=1:2, b=1:2)), "x must be vector")

  x = c(seq(1, 10), 1000)
  expect_equal(length(rank_ptile(x)), length(x))
})

test_that("Basic mode_stats works", {
  expect_error(mode_stats(data.frame(a=1:2, b=1:2)), "x must be vector")

  x = c(1, 2, 3, 3, 4, 5)
  expect_equal(length(mode_stats(x)), 1)
  expect_equal(mode_stats(x), 3)
  expect_equal(mode_stats(c(1, 2, 3, 4, 5)), 1)

})



