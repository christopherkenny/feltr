#' Update a Map's Details
#'
#' Allows for updates to the title, description, and level of public access.
#'
#' @param map_id map identifier from url, from `https://felt.com/map/Readable-Name-map_id`
#' @param title Title to use for the map. Defaults to `NULL`.
#' @param description Description for the map legend. Defaults to `NULL`.
#' @param public_access Degree of public acess. Defaults to `NULL`, which is `view_only`.
#' Text options also include `'private'`, `'view_and_comment'`, and `'view_comment_and_edit'`.
#'
#' @concept get
#'
#' @return response data
#' @export
#'
#' @examplesIf has_felt_key()
#' felt_update_details(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA', title = paste0('Rockland 2024 Districts, tested ', Sys.Date()))
felt_update_details <- function(map_id, title = NULL, description = NULL, public_access = NULL) {

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

  req |>
    httr2::req_perform() |>
    httr2::resp_body_json() |>
    proc_map()
}
