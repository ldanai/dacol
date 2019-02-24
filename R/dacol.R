#' dacol: Danai's utilities for adding columns
#'
#' dacol provides utilities to add/modify columns into dataframe.
#'
#' The utilities include:
#'
#' \itemize{
#' \item Statistical measures: mode, confident_interval
#' \item Data Transformation of a vector column: cosine, logistic, zscore
#' \item Distance between 2 vector columns: euclidean, pearson, cosine, canberra
#' \item Data Cleasing: trim_outlier
#' \item Percentile: decile, rank_percentile
#' }
#'
#' To learn more about dplyr, start with the vignettes:
#' `browseVignettes(package = "dacol")`
#'
#' @section Package options:
#' \describe{
#' \item{`dacol.show_progress`}{Should lengthy operations such as `do()`
#'   show a progress bar? Default: `TRUE`}
#' }
#'
#' @import rlang
#' @import dplyr
#' @import tidyr
#' @import ggplot2
#' @importFrom glue glue
#' @importFrom stats quantile
#' @importFrom stats reorder
#'
"_PACKAGE"
NULL
utils::globalVariables(c("."))
