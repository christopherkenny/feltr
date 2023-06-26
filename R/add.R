#' Add Layers to Existing Map
#'
#' @param map_id map identifier from url, from `https://felt.com/map/Readable-Name-map_id`
#' @param file_names Files to include
#' @param name Name of the layer
#' @param fill_color Color to fill shape with, typically a hexcode. Defaults to `NULL`.
#' @param stroke_color Color to outline shape with, typically a hexcode. Defaults to `NULL`.
#'
#' @return a string with the created layer
#' @export
#'
#' @examplesIf has_felt_key()
#' felt_add_map_layers(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
#'                     file_names = fs::path_package('feltr',  'towns.geojson'),
#'                     name = 'Towns')
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
    httr2::req_url_path_append('maps', map_id, 'layers') |>
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
#' @return TODO
#' @export
#'
#' @examplesIf has_felt_key()
#' #TODO
felt_add_map_layers_url <- function(map_id, url, name = NULL) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'layers', 'url_import') |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_body_raw('TODO')

}
