#' Create a new map
#'
#' @param title Title to use for the map. Defaults to `NULL`.
#' @param basemap Basemap for the new map. Defaults to `NULL`. Can be a URL or color hex code
#' @param layer_urls vector of URLs to generate layers in map. Defaults to `NULL`.
#' @param lat latitude to center the map. Defaults to `NULL`.
#' @param lon longitude to center the map. Defaults to `NULL`
#' @param zoom zoom level to initialize the map with.
#'
#' @return a [tibble::tibble] for the new map
#' @export
#'
#' @concept map
#'
#' @examplesIf has_felt_key()
#' felt_create_map(title = 'feltr example')
felt_create_map <- function(title = NULL, basemap = NULL, layer_urls = NULL,
                            lat = NULL, lon = NULL, zoom = NULL) {
  if (!is.null(layer_urls)) layer_urls <- as.list(layer_urls)

  body <- list(
    title = title,
    basemap = basemap,
    layer_urls = layer_urls,
    lat = lat,
    lon = lon,
    zoom = zoom
  ) |>
    purrr::discard(is.null)

  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps') |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_body_json(body, auto_unbox = TRUE)

  req |>
    httr2::req_perform() |>
    httr2::resp_body_json() |>
    proc_map()
}
