# Get Map Elements from Map ID

Get Map Elements from Map ID

## Usage

``` r
felt_get_map_elements(map_id, clean = TRUE)

felt_get_map_element_groups(map_id, clean = TRUE)

felt_get_map_elements_in_group(map_id, group_id, clean = TRUE)
```

## Arguments

- map_id:

  character, map identifier from url, from
  `https://felt.com/map/Readable-Name-map_id`

- clean:

  logical, whether to turn the API response into a
  [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)

- group_id:

  group identifier, as returned by `felt_get_map_element_groups()`

## Value

a [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
for the map

## Examples

``` r
if (FALSE) { # has_felt_key()
felt_get_map_elements(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA')
felt_get_map_element_groups('TBI8sDkmQjuK2GX9CSiHiUA')
felt_get_map_elements_in_group('TBI8sDkmQjuK2GX9CSiHiUA', '3Wl5s2AqRmiYgO9CrBFxO3D')
}
```
