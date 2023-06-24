#' Get Map Information from Map ID
#'
#' - `felt_get_map()` returns identifying information for the map
#' - `felt_get_map_layers()` returns information about each layer in the map
#' - `felt_get_map_elements()` returns the shapes for each layer in the map
#'
#' @param map_id map identifier from url, from `https://felt.com/map/Map-ID`
#'
#' @return a [tibble::tibble] for the map
#' @export
#'
#' @examplesIf has_felt_key()
#' felt_get_map('Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA')
felt_get_map <- function(map_id) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id) |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  req |>
    httr2::req_perform() |>
    httr2::resp_body_json() |>
    proc_map()
}


#' @rdname felt_get_map
#' @export
felt_get_map_elements <- function(map_id) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'elements') |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}


#' @rdname felt_get_map
#' @export
felt_get_map_layers <- function(map_id) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'layers') |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
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

proc_map_layer <- function(l) {
  tibble::tibble(
    name = purrr::map_chr(l$data, .f = function(x) purrr::pluck(x, 'attributes', 'name')),
    progress = purrr::map_int(l$data, .f = function(x) purrr::pluck(x, 'attributes', 'progress')),
    status = purrr::map_chr(l$data, .f = function(x) purrr::pluck(x, 'attributes', 'status')),
    id = purrr::map_chr(l$data, 'id'),
    relationships = purrr::map(l$data, .f = function(x) purrr::pluck(x, 'relationships')),
    type = purrr::map_chr(l$data, 'type'),
  )
}


