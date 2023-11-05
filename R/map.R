#' Get Map Information from Map ID
#'
#' - `felt_get_map()` returns identifying information for the map
#' - `felt_get_map_layers()` returns information about each layer in the map
#' - `felt_get_map_elements()` returns the shapes for each layer in the map
#'
#' @param map_id map identifier from url, from `https://felt.com/map/Readable-Name-map_id`
#'
#' @return a [tibble::tibble] for the map
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
felt_get_map_layers <- function(map_id) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'layers') |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  req |>
    httr2::req_perform() |>
    httr2::resp_body_json() |>
    proc_map_layer()
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
