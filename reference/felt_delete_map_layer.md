# Delete Layer from an Existing Map

Delete Layer from an Existing Map

## Usage

``` r
felt_delete_map_layer(map_id, layer_id, clean = TRUE)
```

## Arguments

- map_id:

  character, map identifier from url, from
  `https://felt.com/map/Readable-Name-map_id`

- layer_id:

  character, layer identifier from url, from
  [`felt_get_map()`](http://christophertkenny.com/feltr/reference/felt_get_map.md)

- clean:

  logical, whether to turn the API response into a
  [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)

## Value

response code

## Examples

``` r
if (FALSE) { # has_felt_key()
# split the URL for length reasons
url <- paste0(
'https://www.rocklandgis.com/portal/sharing/rest/',
'content/items/73fc78cb0fb04580b4788937fe5ee697/data'
)
layer <- felt_add_map_layers_url(
    map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
    url = url,
    name = 'URL Parks test')
layer
# and delete the new layer
felt_delete_map_layer(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA',  layer_id = layer$layer_id)
}
```
