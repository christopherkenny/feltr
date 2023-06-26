#' Delete Layer from an Existing Map
#'
#' @param map_id map identifier from url, from `https://felt.com/map/Readable-Name-map_id`
#' @param layer_id layer identifier, as returned by `felt_get_map_layers()` or `felt_add_map_layers()`
#'
#' @return response code
#' @export
#'
#' @examplesIf has_felt_key()
#' layer <- felt_add_map_layers('TBI8sDkmQjuK2GX9CSiHiUA', 'test', fs::path_package('felt', 'towns.geojson'))
#' felt_delete_map_layers(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA', layer)
felt_delete_map_layer <- function(map_id, layer_id) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'layers', layer_id) |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_method(method = 'DELETE')

  req |>
    httr2::req_perform() |>
    httr2::resp_status()
}
