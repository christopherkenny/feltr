#' Get Map Elements from Map ID
#'
#' @param map_id map identifier from url, from `https://felt.com/map/Map-ID`
#' @param group_id group identifier, as returned by `felt_get_map_element_groups()`
#'
#'
#' @return a [tibble::tibble] for the map
#' @export
#'
#' @concept get
#'
#' @examplesIf has_felt_key()
#' felt_get_map_elements(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA')
#' felt_get_map_element_groups('TBI8sDkmQjuK2GX9CSiHiUA')
#' felt_get_map_elements_in_group('TBI8sDkmQjuK2GX9CSiHiUA', '3Wl5s2AqRmiYgO9CrBFxO3D')
felt_get_map_elements <- function(map_id) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'elements') |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  l <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  geoms <- proc_geometry(l$features)

  dat <- l |>
    proc_elements() |>
    dplyr::select(-dplyr::any_of('geometry'))

  cbind(geoms, dat)
}

#' @rdname felt_get_map_elements
#' @export
felt_get_map_element_groups <- function(map_id) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'element_groups') |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  l <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  geoms <- lapply(l, function(x) x$elements$features |> proc_geometry())

  l |>
    lapply(proc_map_no_layers) |>
    purrr::list_rbind() |>
    dplyr::mutate(geometry = geoms)
}

#' @rdname felt_get_map_elements
#' @export
felt_get_map_elements_in_group <- function(map_id, group_id) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'element_groups') |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  l <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  geoms <- lapply(l, function(x) x$elements$features |> proc_geometry())

  l |>
    lapply(proc_map_no_layers) |>
    purrr::list_rbind() |>
    dplyr::mutate(geometry = geoms)
}
