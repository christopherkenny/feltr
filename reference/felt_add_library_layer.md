# Add layer to library

Add layer to library

## Usage

``` r
felt_add_library_layer(map_id, layer_id, name = NULL, clean = TRUE)
```

## Arguments

- map_id:

  character, map identifier from url, from
  `https://felt.com/map/Readable-Name-map_id`

- layer_id:

  character, layer identifier from url, from
  [`felt_get_map()`](http://christophertkenny.com/feltr/reference/felt_get_map.md)

- name:

  character, name to save the layer under. Optional.

- clean:

  logical, whether to turn the API response into a
  [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)

## Value

a [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
if `clean = TRUE`, otherwise a list

## Examples

``` r
if (FALSE) { # has_felt_key()
felt_add_library_layer(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA',
                      layer_id = '4Lc7RaEyRP2LfARGmR6e4C',
                      name = paste0('Test layer ', Sys.time()))
}
```
