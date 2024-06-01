#' Refresh an existing layer
#'
#' @param map_id map identifier from url, from `https://felt.com/map/Map-ID`
#' @param layer_id layer identifier, as returned by `felt_get_map_layers()` or `felt_add_map_layers()`
#' @param file_names file names to upload if the original layer was created with a file upload
#'
#' @return a [tibble::tibble] with upload information
#' @export
#'
#' @examplesIf has_felt_key()
#' felt_refresh_layer(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
#'                   layer_id = 'rCfurZSFShycXHCBw69CdKB',
#'                   file_names = fs::path_package('feltr',  'towns.geojson'))
#' felt_refresh_layer(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
#'                   layer_id = 'eufG5hWKRRSURHE8YcGGXA')
felt_refresh_layer <- function(map_id, layer_id, file_names) {

  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'layers', layer_id, 'refresh') |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_method('POST')

  upload_info <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if ('presigned_attributes' %in% names(upload_info)) {
    if (missing(file_names)) {
      cli::cli_abort('{.arg file_names} must be required for this layer.')
    }

    args <- upload_info |>
      purrr::pluck('presigned_attributes')

    upload <- upload_info |>
      purrr::pluck('url') |>
      httr2::request() |>
      req_injected(!!!args, file = curl::form_file(file_names))

    upload |>
      httr2::req_perform() |>
      httr2::resp_status()


  } else {
    upload_info |>
      tibble::as_tibble()
  }
}
