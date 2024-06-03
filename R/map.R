#' Get Map Information from Map ID
#'
#' - `felt_get_map()` returns identifying information for the map
#' - `felt_get_map_layers()` returns information about each layer in the map
#' - `felt_get_map_elements()` returns the shapes for each layer in the map
#'
#' @param map_id `r template_var_map_id()`
#' @param layer_id `r template_var_layer_id()`
#' @param clean `r template_var_clean()`
#'
#' @return a [tibble::tibble] for the map, if `clean = TRUE`, otherwise a list
#' @export
#'
#' @concept get
#'
#' @examplesIf has_felt_key()
#' felt_get_map('Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA')
#' felt_get_map_layers('Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA')
#' \donttest{
#' # slower, as it has to build the shapes from the API result
#' felt_get_map_elements('Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA')
#' }
felt_get_map <- function(map_id, clean = TRUE) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id) |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  out <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(out)
  }

  out |>
    proc_map()
}

#' @rdname felt_get_map
#' @export
felt_get_map_layers <- function(map_id, clean = TRUE) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'layers') |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  out <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(out)
  }

  out |>
    list_hoist() |>
    clean_names()
}


#' @rdname felt_get_map
#' @export
felt_get_map_layer <- function(map_id, layer_id, clean = TRUE) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'layers', layer_id) |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  out <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(out)
  }

  out |>
    relist()
}

#' Get information for a layer group
#'
#' @param map_id `r template_var_map_id()`
#' @param layer_group_id `r template_var_layer_group_id()`
#' @param clean `r template_var_clean()`
#'
#' @return a [tibble::tibble] for the layer group, if `clean = TRUE`, otherwise a list
#' @export
#'
#' @examplesIf has_felt_key()
#' felt_get_map_layer_group(
#'   map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
#'   layer_group_id = 'rHxyTef7S9CO8W7n1PvBVwC'
#' )
felt_get_map_layer_group <- function(map_id, layer_group_id, clean = TRUE) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'layer_groups', layer_group_id) |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  out <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(out)
  }

  out |>
    relist()
}



# #' @rdname felt_get_map
# #' @export
# #' @param path path to save map to locally as a `.geojson` file
# felt_get_map_geojson <- function(map_id, path = tempfile(fileext = '.geojson')) {
#   curl::curl_download(paste0('https://felt.com/map/', map_id, '.geojson'),
#                       destfile = path)
# }
#
# #' @rdname felt_get_map
# #' @export
# felt_get_map_sf <- function(map_id, path = tempfile(fileext = '.geojson')) {
#   curl::curl_download(paste0('https://felt.com/map/', map_id, '.geojson'),
#                       destfile = path) |>
#     sf::read_sf()
# }
