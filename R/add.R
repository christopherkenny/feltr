#' Add Layers to Existing Map
#'
#' @param map_id `r template_var_map_id()`
#' @param file_names Files to include. Required.
#' @param name Name of the layer. Required.
#' @param lat For images, the latitude of the center of the image. Optional.
#' @param lng For images, the longitude of the center of the image. Optional.
#' @param zoom For images, the zoom level of the image. Optional.
#' @param clean `r template_var_clean()`
#'
#' @return status of the upload
#' @export
#'
#' @concept edits
#'
#' @examplesIf has_felt_key()
#' layer <- felt_add_map_layers(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
#'                     file_names = fs::path_package('feltr',  'towns.geojson'),
#'                     name = 'Towns  test')
#' layer
felt_add_map_layers <- function(map_id, name = NULL, file_names = NULL,
                                lat = NULL, lng = NULL, zoom = NULL, clean = TRUE) {

  if (is.null(name)) {
    cli::cli_abort('{.arg name} is required.')
  }
  if (is.null(file_names)) {
    cli::cli_abort('{.arg file_names} is required.')
  }

  body <- list(
    name = name,
    lat = lat,
    lng = lng,
    zoom = zoom
  ) |>
    purrr::discard(is.null)

  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'upload') |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_body_json(body, auto_unbox = TRUE)

  upload_info <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  args <- upload_info |>
    purrr::pluck('presigned_attributes')
  upload <- upload_info |>
    purrr::pluck('url') |>
    httr2::request() |>
    req_injected(!!!args, file = curl::form_file(file_names))

  out <- upload |>
    httr2::req_perform()

  if (!clean) {
    return(out)
  }

  out
}

#' Add Layers to Existing Map from URL
#'
#' See [Felt "Upload Anything" documentation](https://feltmaps.notion.site/b26d739e80184127872faa923b55d232?pvs=25#3e37f06bc38c4971b435fbff2f4da6cb)
#' for detailed examples of potential URLs.
#'
#' @param map_id `r template_var_map_id()`
#' @param url Link to layer to include. Required
#' @param name Name of the layer. Required.
#' @param clean `r template_var_clean()`
#'
#' @return a [tibble::tibble] for the created layer
#' @export
#'
#' @concept edits
#'
#' @examplesIf has_felt_key()
#' # split the URL for length reasons
#' url <- paste0(
#' 'https://www.rocklandgis.com/portal/sharing/rest/',
#' 'content/items/73fc78cb0fb04580b4788937fe5ee697/data'
#' )
#' layer <- felt_add_map_layers_url(
#'     map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
#'     url = url,
#'     name = 'URL Parks test')
#' layer
#' # and delete the new layer
#' felt_delete_map_layer(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA',  layer_id = layer$layer_id)
felt_add_map_layers_url <- function(map_id, url, name = NULL, clean = TRUE) {

  if (is.null(name)) {
    cli::cli_abort('{.arg name} is required.')
  }
  if (missing(url)) {
    cli::cli_abort('{.arg url} is required.')
  }

  body <- list(
    import_url = url,
    name = name
  ) |>
    purrr::discard(is.null)

  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'upload') |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_body_json(body, auto_unbox = TRUE)

  out <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(out)
  }

  out |>
    tibble::as_tibble()
}

#' Add Elements to Existing Map
#'
#' @param map_id `r template_var_map_id()`
#' @param elements a [sf::sf] object or a path to a geojson file
#' @param clean `r template_var_clean()`
#'
#' @return a [tibble::tibble] with the elements added
#' @export
#'
#' @concept edits
#'
#' @examplesIf has_felt_key()
#' elem <- felt_add_map_elements(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
#'                     elements = fs::path_package('feltr',  'bbox.geojson'))
#' elem
#' # and delete layer
#' felt_delete_map_elements(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA', element_id = elem$felt_id)
felt_add_map_elements <- function(map_id, elements, clean = TRUE) {

  if (fs::is_file(elements)) {
    elements <- sf::read_sf(elements)
  }
  tf <- tempfile(fileext = '.geojson')
  sf::st_write(elements |> sf::st_transform(4326), tf, quiet = TRUE)
  elements <- jsonlite::read_json(tf)

  body <- list(
    features = elements$features,
    type = 'FeatureCollection'
  )

  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'elements') |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_body_json(body, auto_unbox = TRUE)

  l <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(l)
  }

  l |>
    proc_elements()
}
