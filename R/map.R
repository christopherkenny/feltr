#' Get Map Information from Map ID
#'
#' @param map_id map identifier from url, from `https://felt.com/map/Map-ID`
#'
#' @return a [tibble::tibble] for the map
#' @export
#'
#' @examplesIf has_felt_key()
#' felt_get_map('Phoenix-Arizona-L9Cefd3GJSGuYQaU5tBOlvA')
felt_get_map <- function(map_id) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id) |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  req |>
    httr2::req_perform() |>
    httr2::resp_body_json() |>
    proc_map()
}

proc_map <- function(l) {
  tibble::tibble(
    title = l$data$attributes$title,
    url = l$data$attributes$url,
    id = l$data$id,
    links = l$data$links$self,
    type = l$data$type
  )
}
