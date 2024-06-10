template_var_map_id <- function() { # nocov start
  'character, map identifier from url, from `https://felt.com/map/Readable-Name-map_id`'
} # nocov end

template_var_layer_id <- function() { # nocov start
  'character, layer identifier from url, from `felt_get_map()`'
} # nocov end

template_var_layer_group_id <- function() { # nocov start
  'character, layer group identifier from url, from `felt_get_map()`.'
} # nocov end

template_var_source <- function() { # nocov start
  'character, source of the layers, one of `workspace`, `felt`, or `all`'
} # nocov end

template_var_clean <- function() { # nocov start
  'logical, whether to turn the API response into a [tibble::tibble]'
} # nocov end
