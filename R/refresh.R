#' Refresh an existing layer
#'
#' @param map_id `r template_var_map_id()`
#' @param layer_id `r template_var_layer_id()`
#' @param file_names file names to upload if the original layer was created with a file upload
#' @param clean `r template_var_clean()`
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
felt_refresh_layer <- function(map_id, layer_id, file_names, clean = TRUE) {

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

    out <- upload |>
      httr2::req_perform()

    if (!clean) {
      return(out)
    }

    out |>
      httr2::resp_status()
  } else {

    if (!clean) {
      return(upload_info)
    }

    upload_info |>
      tibble::as_tibble()
  }
}
