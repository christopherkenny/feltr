function(resp) {
  resp |>
    # shorten url
    httptest2::gsub_response(pattern = 'felt.com/api/v2/', '') |>
    # redact key
    httptest2::gsub_response(pattern = feltr::get_felt_key(), '')
}
