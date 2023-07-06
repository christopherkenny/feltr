#' Get Map Elements from Map ID
#'
#' @param map_id map identifier from url, from `https://felt.com/map/Map-ID`
#'
#' @return a [tibble::tibble] for the map
#' @export
#'
#' @concept get
#'
#' @examplesIf has_felt_key()
#' felt_get_map_elements(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA')
felt_get_map_elements <- function(map_id) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'elements') |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  l <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  feats <- l$data$features

  geoms <- lapply(seq_along(feats), function(i) {
    list(
      type = feats[[i]]$type,
      geometry = feats[[i]]$geometry#,
      #properties = feats[[1]]$properties
    )|>
      jsonlite::toJSON(auto_unbox = TRUE) |>
      geojsonsf::geojson_sf()
  }) |>
    purrr::list_rbind() |>
    sf::st_as_sf()

  dat <- proc_elements(l)

  cbind(geoms, dat)
}
