#' List all layers in your workspace library
#'
#' @param source `r template_var_source()`
#' @param clean `r template_var_clean()`
#'
#' @return a [tibble::tibble] if `clean = TRUE`, otherwise a list
#' @export
#'
#' @examplesIf has_felt_key()
#' felt_get_library()
felt_get_library <- function(source = 'workspace', clean = TRUE) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('library') |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_url_query(source = source)

  out <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(out)
  }

  out |>
    relist() |>
    dplyr::mutate(
      layers = lapply(.data$layers, list_hoist),
      layer_groups = lapply(.data$layer_groups, function(x) dplyr::bind_rows(lapply(x, function(z) relist(z))))
    )
}

#' Add layer to library
#'
#' @param map_id `r template_var_map_id()`
#' @param layer_id `r template_var_layer_id()`
#' @param name character, name to save the layer under. Optional.
#' @param clean `r template_var_clean()`
#'
#' @return a [tibble::tibble] if `clean = TRUE`, otherwise a list
#' @export
#'
#' @examples
#' felt_add_library_layer(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA',
#'                       layer_id = '4Lc7RaEyRP2LfARGmR6e4C',
#'                       name = paste0('Test layer ', Sys.time()))
felt_add_library_layer <- function(map_id, layer_id, name = NULL, clean = TRUE) {

  body <- list(
    name = name
  ) |>
    purrr::discard(is.null)

  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'layers', layer_id, 'publish') |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_body_json(data = body, auto_unbox = TRUE) |>
    httr2::req_method(method = 'POST')

  out <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(out)
  }

  out |>
    relist()
}

#' Add layer group to library
#'
#' @param map_id `r template_var_map_id()`
#' @param layer_group_id `r template_var_layer_group_id()`
#' @param name character, name to save the layer group under. Optional.
#' @param clean `r template_var_clean()`
#'
#' @return a [tibble::tibble] if `clean = TRUE`, otherwise a list
#' @export
#'
#' @examplesIf has_felt_key()
#' felt_add_library_layer_group(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA',
#'                             layer_group_id = 'rHxyTef7S9CO8W7n1PvBVwC',
#'                             name = paste0('Test layer group ', Sys.time()))
felt_add_library_layer_group <- function(map_id, layer_group_id, name = NULL, clean = TRUE) {

  body <- list(
    name = name
  ) |>
    purrr::discard(is.null)

  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'layer_groups', layer_group_id, 'publish') |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_body_json(data = body, auto_unbox = TRUE) |>
    httr2::req_method(method = 'POST')

  out <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(out)
  }

  out |>
    relist()
}


