#' What is the information?
#'
#' _These_ must be given by the contestants in the form of a question in
#' response to the clues asked.
#'
#' @inheritParams whatr_scores
#' @return A tidy tibble of clue text.
#' @format A tibble with 1 row and 3 variables:
#' \describe{
#'   \item{game}{The non-sequential J! Archive game ID.}
#'   \item{show}{The sequential show number of an episode.}
#'   \item{date}{The air date of an episode.}
#' }
#' @examples
#' whatr_info(game = 6304)
#' whatr_html(6304) %>% whatr_info()
#' @importFrom rvest html_node html_text
#' @importFrom stringr str_extract
#' @importFrom tibble tibble
#' @export
whatr_info <- function(game) {
  if (is(game, "xml_document") & grepl("ddred", as.character(game), )) {
    stop("a 'showgame' HTML input is needed")
  } else if (!is(game, "xml_document")) {
    game <- whatr_html(x = game, out = "showgame")
  }

  c <- as.character(game)
  id <- stringr::str_extract(c, "(?<=chartgame.php\\?game_id\\=)\\d+")
  title <- rvest::html_text(rvest::html_node(game, "title"))
  info <- tibble::tibble(
    game = as.integer(id),
    show = as.integer(stringr::str_extract(title, "(\\d+)")),
    date = as.Date(stringr::str_extract(title, "\\d+-\\d+-\\d+$"))
  )
  return(info)
}
