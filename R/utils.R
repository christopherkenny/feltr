list_hoist <- function(l) {
  dplyr::bind_rows(lapply(l, function(x) dplyr::bind_rows(unlist(x))))
}

clean_names <- function(x) {
  out <- x |>
    names() |>
    stringr::str_replace('\\.', '_') |>
    stringr::str_replace('([a-z])([A-Z])', '\\1_\\2') |>
    tolower()
  stats::setNames(object = x, nm = out)
}

test_map_id <- 'TBI8sDkmQjuK2GX9CSiHiUA'

lrj <- function() {
  httr2::last_response() |>
    httr2::resp_body_json()
}
