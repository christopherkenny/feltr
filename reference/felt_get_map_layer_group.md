# Get information for a layer group

Get information for a layer group

## Usage

``` r
felt_get_map_layer_group(map_id, layer_group_id, clean = TRUE)
```

## Arguments

- map_id:

  character, map identifier from url, from
  `https://felt.com/map/Readable-Name-map_id`

- layer_group_id:

  character, layer group identifier from url, from
  [`felt_get_map()`](http://christophertkenny.com/feltr/reference/felt_get_map.md).

- clean:

  logical, whether to turn the API response into a
  [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)

## Value

a [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
for the layer group, if `clean = TRUE`, otherwise a list

## Examples

``` r
if (FALSE) { # has_felt_key()
felt_get_map_layer_group(
  map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
  layer_group_id = 'rHxyTef7S9CO8W7n1PvBVwC'
)
}
```
