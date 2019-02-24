# dacol

dacol provides utilities to add or modify columns into dataframe.

The utilities include:

* Statistical measures: mode, confident_interval
* Data Transformation of a vector column: cosine, logistic, zscore
* Distance between 2 vector columns: euclidean, pearson, cosine, canberra
* Data Cleasing: trim_outlier

More info: https://ldanai.github.io/dacol/
  

## Installation

You can install dacol from github with:

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

<<<<<<< HEAD
dta1 = 
  dta1 %>% 
  mutate(
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
    y_dec_band1  = decile_band(x3),
    y_dec_band2  = decile_band(x3, c(seq(0, 0.9, 0.1))),
    y_dec_ptile1 = decile_ptile(x3),
    y_dec_ptile2 = decile_ptile(x3, c(seq(0, 0.9, 0.1))),
    
    # Rank percentile
    y_ranked1 = rank_ptile(x3), 
    y_ranked2 = rank_ptile(x3, c(seq(1, 100, 1))) 
  )
=======
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

dta1
#> # A tibble: 200 x 17
#>       x1    x2    x3 y_cosine y_logistic y_zcore y_dist_canb y_dist_cos
#>    <dbl> <dbl> <int>    <dbl>      <dbl>   <dbl>       <dbl>      <dbl>
#>  1 -36   0        56        0     0        -1.72      0           0.498
#>  2 -35.6 0.151    51        0     0.0251   -1.70     -0.0972      0.498
#>  3 -35.3 0.302    28        0     0.0502   -1.68     -0.218       0.498
#>  4 -34.9 0.452    25        0     0.0752   -1.67     -0.372       0.498
#>  5 -34.6 0.603    32        0     0.100    -1.65     -0.576       0.498
#>  6 -34.2 0.754    93        0     0.125    -1.63     -0.858       0.498
#>  7 -33.8 0.905    53        0     0.150    -1.62     -1.27        0.498
#>  8 -33.5 1.06    155        0     0.174    -1.60     -1.94        0.498
#>  9 -33.1 1.21    103        0     0.198    -1.58     -3.22        0.498
#> 10 -32.7 1.36    118        0     0.222    -1.56     -6.56        0.498
#> # ... with 190 more rows, and 9 more variables: y_dist_euc <dbl>,
#> #   y_dist_pear <dbl>, y_trim <dbl>, y_norm <dbl>, y_mode <int>,
#> #   y_dec_band1 <dbl>, y_dec_band2 <dbl>, y_dec_ptile1 <dbl>,
#> #   y_dec_ptile2 <dbl>
```

