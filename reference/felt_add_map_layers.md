# Add Layers to Existing Map

Add Layers to Existing Map

## Usage

``` r
felt_add_map_layers(
  map_id,
  name = NULL,
  file_names = NULL,
  lat = NULL,
  lng = NULL,
  zoom = NULL,
  clean = TRUE
)
```

## Arguments

- map_id:

  character, map identifier from url, from
  `https://felt.com/map/Readable-Name-map_id`

- name:

  Name of the layer. Required.

- file_names:

  Files to include. Required.

- lat:

  For images, the latitude of the center of the image. Optional.

- lng:

  For images, the longitude of the center of the image. Optional.

- zoom:

  For images, the zoom level of the image. Optional.

- clean:

  logical, whether to turn the API response into a
  [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)

## Value

status of the upload

## Examples

``` r
if (FALSE) { # has_felt_key()
layer <- felt_add_map_layers(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
                    file_names = fs::path_package('feltr',  'towns.geojson'),
                    name = 'Towns  test')
layer
}
```
