# Refresh an existing layer

Refresh an existing layer

## Usage

``` r
felt_refresh_layer(map_id, layer_id, file_names, clean = TRUE)
```

## Arguments

- map_id:

  character, map identifier from url, from
  `https://felt.com/map/Readable-Name-map_id`

- layer_id:

  character, layer identifier from url, from
  [`felt_get_map()`](http://christophertkenny.com/feltr/reference/felt_get_map.md)

- file_names:

  file names to upload if the original layer was created with a file
  upload

- clean:

  logical, whether to turn the API response into a
  [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)

## Value

a [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
with upload information

## Examples

``` r
if (FALSE) { # has_felt_key()
felt_refresh_layer(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
                  layer_id = 'rCfurZSFShycXHCBw69CdKB',
                  file_names = fs::path_package('feltr',  'towns.geojson'))
felt_refresh_layer(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
                  layer_id = 'eufG5hWKRRSURHE8YcGGXA')
}
```
