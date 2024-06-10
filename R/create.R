#' Create a new map
#'
#' @param title Title to use for the map. Defaults to `NULL`.
#' @param basemap Basemap for the new map. Defaults to `NULL`. Can be a URL or color hex code.
#' Text options include `'default'` (same as `NULL`), `'light'`, `'dark'`, or `'satellite'`.
#' @param layer_urls vector of URLs to generate layers in map. Defaults to `NULL`.
#' @param lat latitude to center the map. Defaults to `NULL`.
#' @param lon longitude to center the map. Defaults to `NULL`
#' @param zoom zoom level to initialize the map with. Defaults to `NULL`.
#' @param description Description for the map legend. Defaults to `NULL`.
#' @param public_access Degree of public acess. Defaults to `NULL`, which is `view_only`.
#' Text options also include `'private'`, `'view_and_comment'`, and `'view_comment_and_edit'`.
#' @param clean `r template_var_clean()`
#'
#' @return a [tibble::tibble] for the new map
#' @export
#'
#' @concept map
#'
#' @examplesIf has_felt_key()
#' map <- felt_create_map(title = 'feltr example')
#' map
#' # and delete it again
#' felt_delete_map(map_id = map$id)
felt_create_map <- function(title = NULL, basemap = NULL, layer_urls = NULL,
                            lat = NULL, lon = NULL, zoom = NULL, description = NULL,
                            public_access = NULL, clean = TRUE) {
  if (!is.null(layer_urls)) layer_urls <- as.list(layer_urls)

  body <- list(
    title = title,
    basemap = basemap,
    layer_urls = layer_urls,
    lat = lat,
    lon = lon,
    zoom = zoom,
    description = description,
    public_access = public_access
  ) |>
    purrr::discard(is.null)

  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps') |>
    httr2::req_auth_bearer_token(token = get_felt_key()) |>
    httr2::req_body_json(body, auto_unbox = TRUE)

  out <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(out)
  }

  out |>
    proc_map()
}
