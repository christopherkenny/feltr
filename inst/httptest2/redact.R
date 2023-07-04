function(resp) {
  resp |>
    httptest2::gsub_response(pattern = feltr::get_felt_key(), '')
}
