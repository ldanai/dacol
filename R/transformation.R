#' Functions to normalize, transform, measure distance between numeric vectors
#'
#' \code{dc_cosine} is the cosine transformation.
#' \code{dc_logistic} is the logistic transformation.
#' \code{dc_zscore} is the zscore transformation.
#' \code{dc_dist_canberra} computes the Canberra distance between 2 numeric vectors.
#' \code{dc_dist_cosine} computes the cosine angle distance between 2 numeric vectors.
#' \code{dc_dist_euclidean} compute the Euclidience distance between 2 numeric vectors.
#' \code{dc_dist_pearson} compute the Pearson correlation distance between 2 numeric vectors.
#'
#' \code{dc_ceiling} similar to rbase::ceiling() with support decimal round up
#' \code{dc_mode} compute the stats mode
#'
#' \code{dc_rank_ptile} add columns with ranked percentiles
#' \code{dc_decile_band} add columns with decile bands
#' \code{dc_decile_ptile} add columns with decile percentiles
#'
#' @param x A numeric vector
#' @param y A numeric vector
#' @param max A numeric value
#' @param fraction The percentile value (0 to 0.5) to trim out
#' @param level The CI level (0.5 to 1.0) of observations to be measured.
#' @param band_ptile The percentail band (0.0 to 1.0)
#' @param level_rank The rank level (0.0 to 1.0) for calculating percentile
#' @param na.rm	A logical value indicating whether NA values should be stripped before the computation proceeds.
#' @param digits similar to rbase::round() which is integer indicating the number of decimal places (round) or significant digits (signif) to be used. Negative values are allowed
#'
#' @return returns a numeric vector after normaliztion or distance between 2 vectors.
#'
#' @name data-normalization
#'
#' @examples
#'
#' library(dacol)
#' library(dplyr)
#'
#' max = 30
#' dta1 = tibble(x1 = seq(-1.2*max, 1.2*max, length.out = 200),
#'               x2 = seq(1, max, length.out = 200),
#'               x3 = sample(200))
#'
#' dta1 = mutate(dta1,
#'
#'               # Transformation
#'               y_cosine   = dc_cosine(x1, max),
#'               y_logistic = dc_logistic(x2, max),
#'               y_zcore    = dc_zscore(x2),
#'
#'               # Distant between 2 vector columns
#'               y_dist_canb = dc_dist_canberra(x2, x3),
#'               y_dist_cos  = dc_dist_cosine(x2, y_zcore),
#'               y_dist_euc  = dc_dist_euclidean(x2, y_zcore),
#'               y_dist_pear = dc_dist_pearson(x2, y_zcore),
#'
#'               # Manage outliers
#'               y_trim = dc_trim_outlier(x3, 0.01),
#'               y_norm = dc_normalize_ptile(x3, 0.01),
#'
#'               # Stats measures
#'               y_mode = dc_mode(x3),
#'               y_ceil = dc_ceiling(x3, -1),
#'
#'               # Band segmentation
#'               y_dec_band1 = dc_decile_band(x3),
#'               y_dec_band2 = dc_decile_band(x3, c(seq(0, 0.9, 0.1))),
#'               y_dec_ptile1 = dc_decile_ptile(x3),
#'               y_dec_ptile2 = dc_decile_ptile(x3, c(seq(0, 0.9, 0.1)))
#'               )
NULL

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
dc_cosine = function(x, max = 100)
{
  value = 0.5*(1 + cos((pi/max)*x))

  value = ifelse(abs(x) > max, 0, value)
  value
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
dc_logistic = function(x, max = 100)
{
  a     = 1/(0.1*max)             # 0.1*max --> at y = 0.5
  value = 2/(1 + exp(- a*x)) - 1  # (x > 0) --> y in [0, 1]
  value
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
dc_zscore = function(x)
{
  return((x-mean(x))/sd(x))
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
dc_dist_canberra = function(x, y)
{
  if(sum(x < 0) > 0) abort("x must be non negative value")
  if(sum(y < 0) > 0) abort("y must be non negative value")

  return(0.5*(1 + (x-y)/(x+y)))
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
dc_dist_cosine = function(x, y)
{
  if(!is.vector(x)) abort("x must be vector")
  if(!is.vector(y)) abort("y must be vector")
  if(length(x) != length(y)) abort("x and y must have the same length vectors")

  return(1 - sum(x*y)/(sqrt(sum(x*x))*sqrt(sum(y*y))))
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
dc_dist_euclidean = function(x, y)
{
  if(!is.vector(x)) abort("x must be vector")
  if(!is.vector(y)) abort("y must be vector")
  if(length(x) != length(y)) abort("x and y must have the same length vectors")

  return(sqrt(sum((x-y)^2)))
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
dc_dist_pearson = function(x, y)
{
  if(!is.vector(x)) abort("x must be vector")
  if(!is.vector(y)) abort("y must be vector")
  if(length(x) != length(y)) abort("x and y must have the same length vectors")

  return(0.5*(1 - (sum(x*y)-length(x)*mean(x)*mean(y))/((length(x)-1)*sd(x)*sd(y))))
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
dc_trim_outlier = function(x, fraction=0.01)
{
  if(!is.vector(x)) abort("x must be vector")

  threshold.low  = quantile(x, fraction, na.rm = TRUE)
  threshold.high = quantile(x, 1-fraction, na.rm = TRUE)

  x[x<=threshold.low]  = threshold.low
  x[x>=threshold.high] = threshold.high

  return(x)
}


###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
dc_normalize_ptile = function(x, fraction = 0.01)
{
  if(!is.vector(x)) abort("x must be vector")

  x = dc_trim_outlier(x, fraction)
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
  if(!is.vector(x)) abort("x must be vector")

  if (level <= 0 || level>=1)
    abort("level must be between 0 and 1")

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
dc_decile_band = function(x, band_ptile = c(seq(0, 0.95, 0.05)))
{
  if(!is.vector(x)) abort("x must be vector")

  band_decile = quantile(x, probs = band_ptile)
  idx         = findInterval(x, band_decile)

  # return
  band_decile[idx]
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
dc_decile_ptile = function(x, band_ptile = c(seq(0, 0.95, 0.05)))
{
  if(!is.vector(x)) abort("x must be vector")

  band_decile = quantile(x, probs = band_ptile)
  idx         = findInterval(x, band_decile)

  # return
  band_ptile[idx]
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
dc_rank_ptile = function(x, level_rank = c(1, 2, 3, 4, seq(5, 100, 5)))
{
  if(!is.vector(x)) abort("x must be vector")

  level_rank   = sort(level_rank, decreasing = TRUE)
  pct_interval = quantile(x, probs = 1 - level_rank/100)
  level_rank[findInterval(x, pct_interval)]
}

###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
dc_mode = function(x, na.rm = FALSE) {

  if(!is.vector(x)) abort("x must be vector")

  if(na.rm){
    x = x[!is.na(x)]
  }

  ux = unique(x)
  return(ux[which.max(tabulate(match(x, ux)))])
}


###-----------------------------------------------------------------------------
#' @export
#' @rdname data-normalization
###-----------------------------------------------------------------------------
dc_ceiling = function(x, digits = 0, na.rm = FALSE) {

  if(!is.vector(x)) abort("x must be vector")

  if(na.rm){
    x = x[!is.na(x)]
  }

  a = (10^(-digits))/2 - 1e-100

  return(round(x + a, digits))
}
