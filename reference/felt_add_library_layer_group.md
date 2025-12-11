# Add layer group to library

Add layer group to library

## Usage

``` r
felt_add_library_layer_group(map_id, layer_group_id, name = NULL, clean = TRUE)
```

## Arguments

- map_id:

  character, map identifier from url, from
  `https://felt.com/map/Readable-Name-map_id`

- layer_group_id:

  character, layer group identifier from url, from
  [`felt_get_map()`](http://christophertkenny.com/feltr/reference/felt_get_map.md).

- name:

  character, name to save the layer group under. Optional.

- clean:

  logical, whether to turn the API response into a
  [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)

## Value

a [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
if `clean = TRUE`, otherwise a list

## Examples

``` r
if (FALSE) { # has_felt_key()
felt_add_library_layer_group(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA',
                            layer_group_id = 'rHxyTef7S9CO8W7n1PvBVwC',
                            name = paste0('Test layer group ', Sys.time()))
}
```
