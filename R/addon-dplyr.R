#' Functions to summarise count with percentage within a dataframe
#'
#' \code{count_pct} is the extenstion of dplyr::count with percent
#' \code{count_pct_group} is the extenstion of dplyr::count with percent by group
#'
#' @return returns a dataframe with count and percentage columns
#'
#' @name addon-dplyr
#'
#' @examples
#'
#' library(dacol, warn.conflicts = FALSE)
#' library(dplyr, warn.conflicts = FALSE)
#' library(scales, warn.conflicts = FALSE)
#'
#' df = data.frame(x = c(1, 2, 3, 4, 5),
#'                 y = c("b", "a", "k", "b", "k"),
#'                 z = c(5, 8, 8, 6, 5))
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
#' mtcars %>% count_pct_group(cyl, am) %>% arrange(cyl, desc(n))
NULL

#' @export
#' @rdname addon-dplyr
count_pct = function(.data, ..., sort = FALSE, accuracy = 3)
{
  .group_vars <- enquos(...)

  .data %>%
    count(!!!.group_vars, sort = sort) %>%
    mutate(pt = scales::percent(n/sum(n), accuracy = accuracy))
    # mutate(pt = scales::percent(round(n/sum(n), 3)))
}

#' @export
#' @rdname addon-dplyr
count_pct_group = function(.data, ..., accuracy = 3)
{
  .group_vars <- enquos(...)

  .data %>%
    group_by(!!!.group_vars) %>%
    summarise(n = n()) %>%
    mutate(pt = scales::percent(n/sum(n), accuracy = accuracy))
}

