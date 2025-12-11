# Add Elements to Existing Map

Add Elements to Existing Map

## Usage

``` r
felt_add_map_elements(map_id, elements, clean = TRUE)
```

## Arguments

- map_id:

  character, map identifier from url, from
  `https://felt.com/map/Readable-Name-map_id`

- elements:

  a [sf::sf](https://r-spatial.github.io/sf/reference/sf.html) object or
  a path to a geojson file

- clean:

  logical, whether to turn the API response into a
  [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)

## Value

a [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
with the elements added

## Examples

``` r
if (FALSE) { # has_felt_key()
elem <- felt_add_map_elements(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
                    elements = fs::path_package('feltr',  'bbox.geojson'))
elem
# and delete layer
felt_delete_map_elements(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA', element_id = elem$felt_id)
}
```
