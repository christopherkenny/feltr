#' Update Felt Style Information for a Layer
#'
#' For details on the Felt Style Language, see <https://felt.com/blog/felt-style-language>.
#'
#' @param map_id map identifier from url, from `https://felt.com/map/Readable-Name-map_id`
#' @param layer_id layer identifier, as returned by `felt_get_map_layers()` or `felt_add_map_layers()`
#' @param fsl A list indicating the Felt style language to update the layer to. It must be valid FSL.
#' @param clean `r template_var_clean()`
#'
#' @return response data
#' @export
#'
#' @concept style
#'
#' @examplesIf has_felt_key()
#' # URL Parks layer
#' # read as a list
#' layer <- felt_get_map_layer(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA',
#'                             layer_id = 'eufG5hWKRRSURHE8YcGGXA',
#'                             clean = FALSE)
#' # use the existing style for easiest modification
#' style <- layer$style
#' style$label$minZoom <- round(runif(1, 0, 23))
#'
#' felt_patch_style(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
#'                  layer_id = 'eufG5hWKRRSURHE8YcGGXA',
#'                  fsl = style)
felt_patch_style <- function(map_id, layer_id, fsl, clean = TRUE) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'layers', layer_id, 'update_style') |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_body_json(data = list(style = fsl), auto_unbox = TRUE)

  req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(out)
  }

  out |>
    relist()
}
