# Get Map Information from Map ID

- `felt_get_map()` returns identifying information for the map

- `felt_get_map_layers()` returns information about each layer in the
  map

- [`felt_get_map_elements()`](http://christophertkenny.com/feltr/reference/felt_get_map_elements.md)
  returns the shapes for each layer in the map

## Usage

``` r
felt_get_map(map_id, clean = TRUE)

felt_get_map_layers(map_id, clean = TRUE)

felt_get_map_layer(map_id, layer_id, clean = TRUE)
```

## Arguments

- map_id:

  character, map identifier from url, from
  `https://felt.com/map/Readable-Name-map_id`

- clean:

  logical, whether to turn the API response into a
  [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)

- layer_id:

  character, layer identifier from url, from `felt_get_map()`

## Value

a [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
for the map, if `clean = TRUE`, otherwise a list

## Examples

``` r
if (FALSE) { # has_felt_key()
felt_get_map('Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA')
felt_get_map_layers('Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA')
# \donttest{
# slower, as it has to build the shapes from the API result
felt_get_map_elements('Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA')
# }
}
```
