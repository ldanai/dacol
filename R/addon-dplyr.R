#' Functions addon to dplyr
#'
#' \code{count_pct} is the extenstion of dplyr::count with percent
#'
#' @examples
#'
#' library(dacol)
#' library(scales)
#'
#' data.frame(x = c(1, 2, 3, 4, 5),
#'            y = c("b", "a", "k", "b", "k"),
#'            z = c(5, 8, 8, 6, 5))
#'
#' df %>% count_pct(y)
#' df %>% count_pct(z)
NULL


#' @export
#' @rdname addon-dplyr
count_pct = function(df, vars, sort = TRUE)
{
  df %>% count({{ vars }}, sort = sort) %>% mutate(pt = scales::percent(n/sum(n)))
}
