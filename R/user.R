#' Obtain information about the user
#'
#' @return a `tibble` of information about the user
#' @export
#'
#' @examplesIf has_felt_key()
#' felt_get_user()
felt_get_user <- function() {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('user') |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  out <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  tibble::tibble(
    email = out$data$attributes$email,
    name = out$data$attributes$name,
    id = out$data$id,
    type = out$data$type
  )
}
