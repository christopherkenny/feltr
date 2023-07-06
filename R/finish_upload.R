#' Finish Upload
#'
#' Uploads are redirected to Amazon S3 buckets and must be confirmed once done.
#' This function is *primarily* internal, but may have uses for custom uploads.
#'
#' @param map_id map identifier from url, from `https://felt.com/map/Readable-Name-map_id`
#'
#' @return `httr2` status code
#' @export
#'
#' @concept edit
#'
#' @examplesIf has_felt_key()
#' felt_finish_upload('TBI8sDkmQjuK2GX9CSiHiUA')
felt_finish_upload <- function(map_id) {
  finish_upload <- httr2::request(base_url = api_url()) |>
    httr2::req_url_path_append('maps', map_id, 'layers:layer_id', 'finish_upload') |>
    httr2::req_auth_bearer_token(token = get_felt_key())

  finish_upload |>
    httr2::req_perform()
}
