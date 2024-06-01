#' Get Felt Style Information for a Layer
#'
#' For details on the Felt Style Language, see <https://felt.com/blog/felt-style-language>.
#'
#' @param map_id map identifier from url, from `https://felt.com/map/Readable-Name-map_id`
#' @param layer_id layer identifier, as returned by `felt_get_map_layers()` or `felt_add_map_layers()`
#'
#' @return a list version of style information
#' @export
#'
#' @concept style
#'
#' @examplesIf has_felt_key()
#' felt_get_style(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA', layer_id = 'Qno0gfmkTS9BggbesfQooND')
felt_get_style <- function(map_id, layer_id) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'layers', layer_id, 'style') |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  req |>
    httr2::req_perform() |>
    httr2::resp_body_json() |>
    purrr::pluck('data') |>
    jsonlite::fromJSON()
}

#' Update Felt Style Information for a Layer
#'
#' For details on the Felt Style Language, see <https://felt.com/blog/felt-style-language>.
#'
#' @param map_id map identifier from url, from `https://felt.com/map/Readable-Name-map_id`
#' @param layer_id layer identifier, as returned by `felt_get_map_layers()` or `felt_add_map_layers()`
#' @param fsl A list indicating the Felt style language to update the layer to
#'
#' @return response data
#' @export
#'
#' @concept style
#'
#' @examplesIf has_felt_key()
#' felt_get_style(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA', layer_id = 'Qno0gfmkTS9BggbesfQooND')
felt_patch_style <- function(map_id, layer_id, fsl) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'layers', layer_id, 'style') |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_body_json(data = list(style = fsl), auto_unbox = TRUE) |> # maybe not auto unbox?
    httr2::req_method(method = 'PATCH')

  req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}
