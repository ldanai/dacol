#' Insert dashes.
#'
#' Call this function as an addin to insert dashes to create a comment section
#'
#' @export

insert_dashes <- function(){

  # Get active document context
  context <- rstudioapi::getActiveDocumentContext()

  # Get column of cursor position
  current_col <- context$selection[[1]]$range[[1]][[2]]

  num_dashes <- 80 - current_col + 1

  # Insert dashes
  rstudioapi::insertText(paste0(strrep("-", num_dashes), "\n"))

}
