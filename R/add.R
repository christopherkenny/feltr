#' Add Layers to Existing Map
#'
#' @param map_id map identifier from url, from `https://felt.com/map/Readable-Name-map_id`
#' @param file_names Files to include
#' @param name Name of the layer
#' @param fill_color Color to fill shape with, typically a hexcode. Defaults to `NULL`.v
#' @param stroke_color Color to outline shape with, typically a hexcode. Defaults to `NULL`.
#'
#' @return a string with the id for the created layer
#' @export
#'
#' @concept edits
#'
#' @examplesIf has_felt_key()
#' layer <- felt_add_map_layers(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
#'                     file_names = fs::path_package('feltr',  'towns.geojson'),
#'                     name = 'Towns')
#' layer
#' # and delete layer
#' felt_delete_map_layer(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA', layer_id = layer)
felt_add_map_layers <- function(map_id, name = NULL, file_names = NULL,
                                fill_color = NULL, stroke_color = NULL) {
  # don't support webhooks for now
  webhook_url = NULL

  body <- list(
    file_names = list(fs::path_file(file_names)),
    name = name,
    fill_color = fill_color,
    stroke_color = stroke_color,
    webhook_url = webhook_url
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
    purrr::pluck('data', 'attributes', 'presigned_attributes')
  upload <- upload_info |>
    purrr::pluck('data', 'attributes', 'url') |>
    httr2::request() |>
    req_injected(!!!args, file = curl::form_file(file_names))

  out <- upload |>
    httr2::req_perform()

  finish_upload <- felt_finish_upload(map_id)

  upload_info$data$attributes$layer_id
}

#' Add Layers to Existing Map from URL
#'
#' See [Felt "Upload Anything" documentation](https://feltmaps.notion.site/b26d739e80184127872faa923b55d232?pvs=25#3e37f06bc38c4971b435fbff2f4da6cb)
#' for detailed examples of potential URLs.
#'
#' @param map_id map identifier from url, from `https://felt.com/map/Readable-Name-map_id`
#' @param url Link to layer to include
#' @param name Name of the layer
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
#'     name = 'Parks')
#' layer
#' # and delete the new layer
#' felt_delete_map_layer(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA',  layer_id = layer$id)
felt_add_map_layers_url <- function(map_id, url, name = NULL) {

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

  tibble::tibble(
    name = out$data$attributes$name,
    status = out$data$attributes$status,
    progress = out$data$attributes$progress,
    id = out$data$id,
    type = out$data$type,
    relationships = list(out$data$relationships$datasets$data)
  )
}

#' Add Elements to Existing Map
#'
#' @param map_id map identifier from url, from `https://felt.com/map/Readable-Name-map_id`
#' @param elements a [sf::sf] object or a path to a geojson file
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
felt_add_map_elements <- function(map_id, elements) {

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

  l |>
    proc_elements()
}
