proc_map <- function(l) {
  l |>
    lapply(function(li) {
      if (length(li) != 1) {
        list(li)
      } else if (is.null(li) || length(li) == 0) {
        NULL
      } else {
        li
      }
    }) |>
    dplyr::as_tibble() |>
    dplyr::mutate(
      elements = lapply(.data$elements, proc_elements),
      layers = lapply(.data$layers, function(x) x |> list_hoist() |> clean_names())
    )
}

proc_map_no_layers <- function(l) {
  l |>
    lapply(function(li) {
      if (length(li) != 1) {
        list(li)
      } else if (is.null(li) || length(li) == 0) {
        NULL
      } else {
        li
      }
    }) |>
    dplyr::as_tibble() |>
    dplyr::mutate(
      elements = lapply(.data$elements, proc_elements)
    )
}

proc_elements <- function(l) {
  tibble::tibble(
    felt_color = purrr::map_chr(l$features, .f = function(x) purrr::pluck(x, 'properties', 'felt:color', .default = character(1))),
    felt_has_long_description = purrr::map_lgl(l$features, .f = function(x) purrr::pluck(x, 'properties', 'felt:hasLongDescription', .default = NA)),
    felt_id = purrr::map_chr(l$features, .f = function(x) purrr::pluck(x, 'properties', 'felt:id', .default = character(1))),
    felt_locked = purrr::map_lgl(l$features, .f = function(x) purrr::pluck(x, 'properties', 'felt:locked', .default = NA)),
    felt_ordering = purrr::map_dbl(l$features, .f = function(x) purrr::pluck(x, 'properties', 'felt:ordering', .default = double(1))),
    felt_size = purrr::map_dbl(l$features, .f = function(x) purrr::pluck(x, 'properties', 'felt:size', .default = double(1))),
    felt_type = purrr::map_chr(l$features, .f = function(x) purrr::pluck(x, 'properties', 'felt:type', .default = character(1))),
    felt_width_scale = purrr::map_dbl(l$features, .f = function(x) purrr::pluck(x, 'properties', 'felt:widthScale', .default = double(1))),
    felt_zoom = purrr::map_dbl(l$features, .f = function(x) purrr::pluck(x, 'properties', 'felt:zoom', .default = double(1))),
    felt_map_image_id = purrr::map_chr(l$features, .f = function(x) purrr::pluck(x, 'properties', 'felt:mapImageId', .default = character(1))),
    felt_opacity = purrr::map_dbl(l$features, .f = function(x) purrr::pluck(x, 'properties', 'felt:opacity', .default = double(1))),
    felt_text = purrr::map_chr(l$features, .f = function(x) purrr::pluck(x, 'properties', 'felt:text', .default = character(1)))#,
    #geometry = purrr::map(l$features, .f = function(x) purrr::pluck(x, 'geometry'))
  )
}

proc_comments <- function(l) {
  tibble::tibble(
    author_email = purrr::map(l,
                              .f = function(x) purrr::map_chr(purrr::pluck(x, 'comments'),
                                                              function(y) purrr::pluck(y, 'authorEmail'))),
    author_name = purrr::map(l,
                             .f = function(x) purrr::map_chr(purrr::pluck(x, 'comments'),
                                                             function(y) purrr::pluck(y, 'authorName'))),
    created_at = purrr::map(l,
                            .f = function(x) purrr::map_chr(purrr::pluck(x, 'comments'),
                                                            function(y) purrr::pluck(y, 'createdAt'))),
    comment_id = purrr::map(l,
                            .f = function(x) purrr::map_chr(purrr::pluck(x, 'comments'),
                                                            function(y) purrr::pluck(y, 'id'))),
    comment_text = purrr::map(l,
                              .f = function(x) purrr::map_chr(purrr::pluck(x, 'comments'),
                                                              function(y) purrr::pluck(y, 'text'))),
    id = purrr::map_chr(l, .f = function(x) purrr::pluck(x, 'id')),
    is_resolved = purrr::map_lgl(l, .f = function(x) purrr::pluck(x, 'isResolved')),
    lat = purrr::map_dbl(l, .f = function(x) purrr::pluck(x, 'location', 1)),
    lon = purrr::map_dbl(l, .f = function(x) purrr::pluck(x, 'location', 2))
  ) |>
    tidyr::unnest_longer(
      col = c('author_email', 'author_name', 'created_at', 'comment_id', 'comment_text')
    )
}

proc_geometry <- function(feats) {
  lapply(seq_along(feats), function(i) {
    list(
      type = feats[[i]]$type,
      geometry = feats[[i]]$geometry
    )|>
      jsonlite::toJSON(auto_unbox = TRUE) |>
      geojsonsf::geojson_sf()
  }) |>
    purrr::list_rbind() |>
    sf::st_as_sf()
}
