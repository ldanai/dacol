# dacol

dacol provides utilities to add/modify columns into dataframe.

The utilities include:

\itemize{
 \item Statistical measures: mode, confident_interval
 \item Data Transformation of a vector column: cosine, logistic, zscore
 \item Distance between 2 vector columns: euclidean, pearson, cosine, canberra
 \item Data Cleasing: trim_outlier
 \item Segmentation: decile
}

## Installation

You can install the released version of dacol from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("dacol")
```

## Example


This is a basic example which shows you how to use dacol:

``` r
library(tidyverse)

max = 30
dta1 = tibble(x1 = seq(-1.2*max, 1.2*max, length.out = 200),
              x2 = seq(0, max, length.out = 200),
              x3 = sample(200))

dta1 = mutate(dta1,
              y_cosine   = transform_cosine(x1, max),
              y_logistic = transform_logistic(x2, max),
              y_zcore    = transform_zscore(x2),

              y_dist_canb = dist_canberra(x2, y_zcore),
              y_dist_cos  = dist_cosine(x2, y_zcore),
              y_dist_euc  = dist_euclidean(x2, y_zcore),
              y_dist_pear = dist_pearson(x2, y_zcore),

              y_trim = trim_outlier(x3, 0.01),
              y_norm = normalize_percentile(x3, 0.01),

              y_mode = mode_stats(x3),

              y_dec_band1 = decile_band(x3),
              y_dec_band2 = decile_band(x3, c(seq(0, 0.9, 0.1))),

              y_dec_ptile1 = decile_ptile(x3),
              y_dec_ptile2 = decile_ptile(x3, c(seq(0, 0.9, 0.1)))
              )

### Normalization/Transformation functions
max = 30
x = seq(-1.2*max, 1.2*max, 0.05)
y = transform_cosine(x, max)
# plot(x, y)

max = 30
x = seq(0, max, 0.05)
y = transform_logistic(x, max)
# plot(x, y)

x = seq(0, max, 0.05)
y = transform_zscore(x)
# plot(x, y)

### Distance functions
z = dist_canberra(x, y)
z = dist_cosine(x, y)
z = dist_euclidean(x, y)
z = dist_pearson(x, y)

### Trim outliers, normalize z-score, normalize percentile
x = sample(100)
z = trim_outlier(x, 0.01)
z = normalize_percentile(x, 0.01)
ci = get_confidence_interval(x, 0.95)

### Mode
z = mode_stats(x)

### Add columns with decile bands
x = sample(100)
y = decile_band(x)
y = decile_band(x, c(seq(0, 0.9, 0.1)))

z = decile_ptile(x)
z = decile_ptile(x, c(seq(0, 0.9, 0.1)))
```


