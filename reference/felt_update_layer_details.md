# Update a Layer's Details

Allows for updates to the name, ordering key, and subtitle.

## Usage

``` r
felt_update_layer_details(
  map_id,
  layer_id,
  layer_group_id = NULL,
  name = NULL,
  ordering_key = NULL,
  subtitle = NULL,
  clean = TRUE
)
```

## Arguments

- map_id:

  character, map identifier from url, from
  `https://felt.com/map/Readable-Name-map_id`

- layer_id:

  character, layer identifier from url, from
  [`felt_get_map()`](http://christophertkenny.com/feltr/reference/felt_get_map.md)

- layer_group_id:

  character, layer group identifier from url, from
  [`felt_get_map()`](http://christophertkenny.com/feltr/reference/felt_get_map.md).

- name:

  Name of the layer. Defaults to `NULL`.

- ordering_key:

  Integer to order layers. Defaults to `NULL`.

- subtitle:

  Subtitle for the layer. Defaults to `NULL`.

- clean:

  logical, whether to turn the API response into a
  [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)

## Value

response data

## Examples

``` r
if (FALSE) { # has_felt_key()
felt_update_layer_details(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA',
                          layer_id = 'eufG5hWKRRSURHE8YcGGXA',
                          subtitle = paste0('tested ', Sys.Date()))
}
```
