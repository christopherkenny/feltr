#' Obtain information about the user
#'
#' @param clean `r template_var_clean()`
#'
#' @return a [tibble::tibble] of information about the user
#' @export
#'
#' @concept user
#'
#' @examplesIf has_felt_key()
#' felt_get_user()
felt_get_user <- function(clean = TRUE) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('user') |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  out <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(out)
  }

  tibble::tibble(
    name = out$name,
    email = out$email,
    id = out$id,
    type = out$type
  )
}
