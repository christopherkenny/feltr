felt_get_map <- function(map_id) {
  req <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id) |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}
