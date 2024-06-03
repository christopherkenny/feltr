#' Delete Layer from an Existing Map
#'
#' @param map_id `r template_var_map_id()`
#' @param layer_id `r template_var_layer_id()`
#' @param clean `r template_var_clean()`
#'
#' @return response code
#' @export
#'
#' @concept edits
#'
#' @examplesIf has_felt_key()
#' layer <- felt_add_map_layers('TBI8sDkmQjuK2GX9CSiHiUA',
#'           'test', fs::path_package('feltr', 'towns.geojson'))
#' felt_delete_map_layer(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
#'          layer)
felt_delete_map_layer <- function(map_id, layer_id, clean = TRUE) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'layers', layer_id) |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_method(method = 'DELETE')

  out <- req |>
    httr2::req_perform()

  if (!clean) {
    return(out)
  }

  out |>
    httr2::resp_status()
}

#' Delete an existing map
#'
#' @param map_id `r template_var_map_id()`
#'
#' @return response code
#' @export
#'
#' @concept map
#'
#' @examplesIf has_felt_key()
#' map <- felt_create_map(title = 'feltr example')
#' felt_delete_map(map_id = map$id)
felt_delete_map <- function(map_id) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id) |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_method(method = 'DELETE')

  req |>
    httr2::req_perform() |>
    httr2::resp_status()
}



#' Delete an existing element
#'
#' @param map_id `r template_var_map_id()`
#' @param element_id element identifier, as returned by `felt_get_map_elements()` or `felt_add_map_elements()`
#'
#' @return response code
#' @export
#'
#' @examplesIf has_felt_key()
#' elem <- felt_add_map_elements(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
#'                     elements = fs::path_package('feltr',  'bbox.geojson'))
#' elem
#' # and delete layer
#' felt_delete_map_elements(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA', element_id = elem$felt_id)
felt_delete_map_elements <- function(map_id, element_id) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'elements', element_id) |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_method(method = 'DELETE')

  req |>
    httr2::req_perform() |>
    httr2::resp_status()
}
