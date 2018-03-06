# dacol

dacol provides utilities to add/modify columns into dataframe.

The utilities include:

* Statistical measures: mode, confident_interval
* Data Transformation of a vector column: cosine, logistic, zscore
* Distance between 2 vector columns: euclidean, pearson, cosine, canberra
* Data Cleasing: trim_outlier
* Segmentation: decile

More info: https://ldanai.github.io/dacol/

## Installation

You can install tidymodel from github with:


``` r
# install.packages("devtools")
devtools::install_github("ldanai/dacol")
```

## Example


This is a basic example which shows you how to use dacol:

``` r
library(dacol)
library(tidyverse)

max = 30
dta1 = tibble(x1 = seq(-1.2*max, 1.2*max, length.out = 200),
              x2 = seq(0, max, length.out = 200),
              x3 = sample(200))

dta1 = mutate(dta1,

              # Transformation
              y_cosine   = transform_cosine(x1, max),
              y_logistic = transform_logistic(x2, max),
              y_zcore    = transform_zscore(x2),
              
              # Distant between 2 vector columns
              y_dist_canb = dist_canberra(x2, y_zcore),
              y_dist_cos  = dist_cosine(x2, y_zcore),
              y_dist_euc  = dist_euclidean(x2, y_zcore),
              y_dist_pear = dist_pearson(x2, y_zcore),

              # Manage outliers
              y_trim = trim_outlier(x3, 0.01),
              y_norm = normalize_percentile(x3, 0.01),
              
              # Stats measures
              y_mode = mode_stats(x3),

              # Band segmentation
              y_dec_band1 = decile_band(x3),
              y_dec_band2 = decile_band(x3, c(seq(0, 0.9, 0.1))),
              y_dec_ptile1 = decile_ptile(x3),
              y_dec_ptile2 = decile_ptile(x3, c(seq(0, 0.9, 0.1)))
              )
```


