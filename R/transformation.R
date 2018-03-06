#' Functions to normalize, transform, measure distance between numeric vectors
#'
#' \code{transform_cosine} is the cosine transformation.
#' \code{transform_logistic} is the logistic transformation.
#' \code{transform_zscore} is the zscore transformation.
#' \code{dist_canberra} computes the Canberra distance between 2 numeric vectors.
#' \code{dist_cosine} computes the cosine angle distance between 2 numeric vectors.
#' \code{dist_euclidean} compute the Euclidience distance between 2 numeric vectors.
#' \code{dist_pearson} compute the Pearson correlation distance between 2 numeric vectors.
#'
#' \code{decile_band} add columns with decile bands
#' \code{decile_ptile} add columns with decile percentiles
#'
#' @param x A numeric vector
#' @param y A numeric vector
#' @param max A numeric value
#' @param fraction The percentile value (0 to 0.5) to trim out
#' @param level The CI level (0.5 to 1.0) of observations to be measured.
#'
#' @return returns a numeric vector after normaliztion or distance between 2 vectors.
#'
#' @name data-normalization
#'
#' @examples
#'
#' library(tidyverse)
#'
#' max = 30
#' dta1 = tibble(x1 = seq(-1.2*max, 1.2*max, length.out = 200),
#'               x2 = seq(0, max, length.out = 200),
#'               x3 = sample(200))
#'
#' dta1 = mutate(dta1,
#'
#'               # Transformation
#'               y_cosine   = transform_cosine(x1, max),
#'               y_logistic = transform_logistic(x2, max),
#'               y_zcore    = transform_zscore(x2),
#'
#'               # Distant between 2 vector columns
#'               y_dist_canb = dist_canberra(x2, y_zcore),
#'               y_dist_cos  = dist_cosine(x2, y_zcore),
#'               y_dist_euc  = dist_euclidean(x2, y_zcore),
#'               y_dist_pear = dist_pearson(x2, y_zcore),
#'
#'               # Manage outliers
#'               y_trim = trim_outlier(x3, 0.01),
#'               y_norm = normalize_percentile(x3, 0.01),
#'
#'               # Stats measures
#'               y_mode = mode_stats(x3),
#'
#'               # Band segmentation
#'               y_dec_band1 = decile_band(x3),
#'               y_dec_band2 = decile_band(x3, c(seq(0, 0.9, 0.1))),
#'               y_dec_ptile1 = decile_ptile(x3),
#'               y_dec_ptile2 = decile_ptile(x3, c(seq(0, 0.9, 0.1)))
#'               )
NULL

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
transform_cosine = function(x, max)
{
  value = 0.5*(1 + cos((pi/max)*x))

  value = ifelse(abs(x) > max, 0, value)
  value
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
transform_logistic = function(x, max)
{
  a     = 1/(0.1*max)             # 0.1*max --> at y = 0.5
  value = 2/(1 + exp(- a*x)) - 1  # (x > 0) --> y in [0, 1]
  value
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
transform_zscore = function(x)
{
  return((x-mean(x))/sd(x))
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
dist_canberra = function(x, y)
{
  return(0.5*(1 + (x-y)/(x+y)))
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
dist_cosine = function(x, y)
{
  return(1 - sum(x*y)/(sqrt(sum(x*x))*sqrt(sum(y*y))))
}

#' @export
#' @rdname data-normalization
dist_euclidean = function(x, y)
{
  return(sqrt(sum((x-y)^2)))
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
dist_pearson = function(x, y)
{
  return(0.5*(1 - (sum(x*y)-length(x)*mean(x)*mean(y))/((length(x)-1)*sd(x)*sd(y))))
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
trim_outlier = function(x, fraction=0.01)
{
  threshold.low  <- quantile(x, fraction, na.rm = TRUE)
  threshold.high <- quantile(x, 1-fraction, na.rm = TRUE)

  x[x<=threshold.low]  = threshold.low
  x[x>=threshold.high] = threshold.high

  return(x)
}


###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
normalize_percentile = function(x, fraction = 0.01)
{
  x = trim_outlier(x, fraction)
  x = (x-min(x))/(max(x)-min(x))   #Scale data to [0, 1]
  x = 2*x-1                        #Scale all values in range [-1, 1]
  return(x)
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
get_confidence_interval = function(x, level=0.95)
{
  if (level <= 0 || level>=1)
    stop("The 'level' argument must be >0 and <1")

  m  = mean(x)
  n  = length(x)
  SE = sd(x)/sqrt(n)
  upper = 1 - (1-level)/2
  ci = m + c(-1,1)*qt(level, n-1)*SE

  list(mean = m,
       se   = SE,
       ci   = ci)
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
decile_band = function(x, band_ptile = c(seq(0, 0.95, 0.05)))
{
  band_decile = quantile(x, probs = band_ptile)
  idx         = findInterval(x, band_decile)

  # return
  band_decile[idx]
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
decile_ptile = function(x, band_ptile = c(seq(0, 0.95, 0.05)))
{
  band_decile = quantile(x, probs = band_ptile)
  idx         = findInterval(x, band_decile)

  # return
  band_ptile[idx]
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
mode_stats <- function(x, na.rm = FALSE) {
  if(na.rm){
    x = x[!is.na(x)]
  }

  ux <- unique(x)
  return(ux[which.max(tabulate(match(x, ux)))])
}