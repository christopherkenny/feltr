#' Export Comments on an Existing Map
#'
#' @param map_id map identifier from url, from `https://felt.com/map/Readable-Name-map_id`
#'
#' @return  a [tibble::tibble] for the map
#' @export
#'
#' @concept comments
#'
#' @examplesIf has_felt_key()
#' felt_get_comments('Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA')
felt_get_comments <- function(map_id) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'comments', 'export') |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}
