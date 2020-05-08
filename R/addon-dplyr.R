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
#'
#' mtcars %>% count_pct(cyl)
#' mtcars %>% count_pct(cyl, sort = TRUE)
#' mtcars %>% count_pct(cyl, am, sort = TRUE)
#'
#' mtcars %>% count_pct_group(cyl)
#' mtcars %>% count_pct_group(cyl, am)
#' mtcars %>% count_pct_group(cyl, am) %>% arrange(desc(cyl))
NULL

#' @export
#' @rdname addon-dplyr
count_pct = function(.data, ..., sort = FALSE)
{
  .group_vars <- enquos(...)

  .data %>%
    count(!!!.group_vars, sort=sort) %>%
    mutate(pt = scales::percent(n/sum(n)))
}

#' @export
#' @rdname addon-dplyr
count_pct_group = function(.data, ...)
{
  .group_vars <- enquos(...)

  .data %>%
    group_by(!!!.group_vars) %>%
    summarise(n = n()) %>%
    mutate(pt = scales::percent(n/sum(n)))
}

