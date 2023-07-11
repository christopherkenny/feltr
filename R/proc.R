proc_map <- function(l) {
  tibble::tibble(
    title = l$data$attributes$title,
    url = l$data$attributes$url,
    id = l$data$id,
    links = l$data$links$self,
    type = l$data$type
  )
}

proc_map_layer <- function(l) {
  tibble::tibble(
    name = purrr::map_chr(l$data, .f = function(x) purrr::pluck(x, 'attributes', 'name')),
    progress = purrr::map_int(l$data, .f = function(x) purrr::pluck(x, 'attributes', 'progress')),
    status = purrr::map_chr(l$data, .f = function(x) purrr::pluck(x, 'attributes', 'status')),
    id = purrr::map_chr(l$data, 'id'),
    relationships = purrr::map(l$data, .f = function(x) purrr::pluck(x, 'relationships', 'datasets') |>
                                 proc_relationships()),
    type = purrr::map_chr(l$data, 'type')
  )
}

proc_relationships <- function(l) {
  if (length(l) == 0) return(NULL)
  tibble::tibble(
    name = purrr::map_chr(l$data, .f = function(x) purrr::pluck(x, 'attributes', 'name')),
    id = purrr::map_chr(l$data, 'id'),
    type = purrr::map_chr(l$data, 'type'),
  )
}

proc_elements <- function(l) {
  tibble::tibble(
    felt_color = purrr::map_chr(l$data$features, .f = function(x) purrr::pluck(x, 'properties', 'felt-color', .default = character(1))),
    felt_has_long_description = purrr::map_lgl(l$data$features, .f = function(x) purrr::pluck(x, 'properties', 'felt-hasLongDescription', .default = NA)),
    felt_id = purrr::map_chr(l$data$features, .f = function(x) purrr::pluck(x, 'properties', 'felt-id', .default = character(1))),
    felt_locked = purrr::map_lgl(l$data$features, .f = function(x) purrr::pluck(x, 'properties', 'felt-locked', .default = NA)),
    felt_ordering = purrr::map_dbl(l$data$features, .f = function(x) purrr::pluck(x, 'properties', 'felt-ordering', .default = double(1))),
    felt_size = purrr::map_dbl(l$data$features, .f = function(x) purrr::pluck(x, 'properties', 'felt-size', .default = double(1))),
    felt_type = purrr::map_chr(l$data$features, .f = function(x) purrr::pluck(x, 'properties', 'felt-type', .default = character(1))),
    felt_width_scale = purrr::map_dbl(l$data$features, .f = function(x) purrr::pluck(x, 'properties', 'felt-widthScale', .default = double(1))),
    felt_zoom = purrr::map_dbl(l$data$features, .f = function(x) purrr::pluck(x, 'properties', 'felt-zoom', .default = double(1))),
    felt_map_image_id = purrr::map_chr(l$data$features, .f = function(x) purrr::pluck(x, 'properties', 'felt-mapImageId', .default = character(1))),
    felt_opacity = purrr::map_dbl(l$data$features, .f = function(x) purrr::pluck(x, 'properties', 'felt-opacity', .default = double(1))),
    felt_text = purrr::map_chr(l$data$features, .f = function(x) purrr::pluck(x, 'properties', 'felt-text', .default = character(1))),
    metadata_felt_id = l$data$metadata$`felt-id`,
    metadata_felt_version = l$data$metadata$`felt-version`,
    links = purrr::map_chr(l$links, 'self')
  )
}

proc_comments <- function(l) {
  tibble::tibble(
    author_email = purrr::map_chr(l, .f = function(x) purrr::pluck(x, 'comments', 1, 'authorEmail')),
    author_name = purrr::map_chr(l, .f = function(x) purrr::pluck(x, 'comments', 1, 'authorName')),
    created_at = purrr::map_chr(l, .f = function(x) purrr::pluck(x, 'comments', 1, 'createdAt')),
    comment_id = purrr::map_chr(l, .f = function(x) purrr::pluck(x, 'comments', 1, 'id')),
    comment_text = purrr::map_chr(l, .f = function(x) purrr::pluck(x, 'comments', 1, 'text')),
    is_resolved = purrr::map_lgl(l, .f = function(x) purrr::pluck(x, 'isResolved')),
    lat = purrr::map_dbl(l, .f = function(x) purrr::pluck(x, 'location', 1)),
    lon = purrr::map_dbl(l, .f = function(x) purrr::pluck(x, 'location', 2))
  )
}
