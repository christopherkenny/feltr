#' Update a Map's Details
#'
#' Allows for updates to the title, description, and level of public access.
#'
#' @param map_id `r template_var_map_id()`
#' @param title Title to use for the map. Defaults to `NULL`.
#' @param description Description for the map legend. Defaults to `NULL`.
#' @param public_access Degree of public acess. Defaults to `NULL`, which is `view_only`.
#' Text options also include `'private'`, `'view_and_comment'`, and `'view_comment_and_edit'`.
#' @param clean `r template_var_clean()`
#'
#' @concept get
#'
#' @return response data
#' @export
#'
#' @examplesIf has_felt_key()
#' felt_update_map_details(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA',
#'                         title = paste0('Rockland 2024 Districts, tested ', Sys.Date()))
felt_update_map_details <- function(map_id, title = NULL, description = NULL,
                                    public_access = NULL, clean = TRUE) {

  body <- list(
    title = title,
    description = description,
    public_access = public_access
  ) |>
    purrr::discard(is.null)

  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'update') |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_body_json(data = body) |> # maybe not auto unbox?
    httr2::req_method(method = 'POST')

  out <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(out)
  }

  out |>
    proc_map()
}

#' Update a Layer's Details
#'
#' Allows for updates to the name, ordering key, and subtitle.
#'
#' @param map_id `r template_var_map_id()`
#' @param layer_id `r template_var_layer_id()`
#' @param layer_group_id `r template_var_layer_group_id()`
#' @param name Name of the layer. Defaults to `NULL`.
#' @param ordering_key Integer to order layers. Defaults to `NULL`.
#' @param subtitle Subtitle for the layer. Defaults to `NULL`.
#' @param clean `r template_var_clean()`
#'
#' @concept get
#'
#' @return response data
#' @export
#'
#' @examplesIf has_felt_key()
#' felt_update_layer_details(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA',
#'                           layer_id = 'eufG5hWKRRSURHE8YcGGXA',
#'                           subtitle = paste0('tested ', Sys.Date()))
felt_update_layer_details <- function(map_id, layer_id,
                                      layer_group_id = NULL, name = NULL, ordering_key = NULL,
                                      subtitle = NULL, clean = TRUE) {

  # TODO: can take a list of layer_ids but then we need to handle diff sizes of inputs
  # might be better to force it to just be length 1 and require a call per layer?

  if (missing(layer_id)) {
    cli::cli_abort('{.arg layer_id} is required.')
  }

  body <- list(
    id = layer_id,
    layer_group_id = layer_group_id,
    name = name,
    ordering_key = ordering_key,
    subtitle = subtitle
  ) |>
    purrr::discard(is.null)

  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'layers') |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_body_json(data = list(body), auto_unbox = TRUE) |> # maybe auto unbox
    httr2::req_method(method = 'POST')

  out <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(req)
  }

  out |>
    lapply(relist) |>
    dplyr::bind_rows()
}


#' Update a Layer Group's Details
#'
#' Allows for updates to the name, ordering key, and subtitle.
#'
#'
#' @param map_id `r template_var_map_id()`
#' @param layer_group_id `r template_var_layer_group_id()`
#' @param name Name of the layer group. Required.
#' @param ordering_key Integer to order by. Defaults to `NULL`.
#' @param subtitle Subtitle for the layer group. Defaults to `NULL`.
#' @param clean `r template_var_clean()`
#'
#' @concept get
#'
#' @return response data
#' @export
#'
#' @examplesIf has_felt_key()
#' felt_update_layer_group_details(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA',
#'                                layer_group_id = 'rHxyTef7S9CO8W7n1PvBVwC',
#'                                name = 'Polling Sites 2020',
#'                                subtitle = paste0('tested ', Sys.Date()))
felt_update_layer_group_details <- function(map_id, layer_group_id,
                                            name = NULL, ordering_key = NULL,
                                            subtitle = NULL, clean = TRUE) {

  if (missing(layer_group_id)) {
    #cli::cli_abort('{.arg layer_group_id} is required.')
    layer_group_id <- NULL
    # can be missing
    # TODO: check if this changes anything weird (looks fine in testing)
  }
  if (missing(name)) {
    cli::cli_abort('{.arg name} is required.')
  }

  body <- list(
    id = layer_group_id,
    name = name,
    ordering_key = ordering_key,
    subtitle = subtitle
  ) |>
    purrr::discard(is.null)

  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'layer_groups') |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_body_json(data = list(body), auto_unbox = TRUE) |> # maybe auto unbox
    httr2::req_method(method = 'POST')

  out <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(req)
  }

  out |>
    lapply(relist) |>
    dplyr::bind_rows()
}
