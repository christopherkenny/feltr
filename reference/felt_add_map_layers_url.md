# Add Layers to Existing Map from URL

See [Felt "Upload Anything"
documentation](https://feltmaps.notion.site/b26d739e80184127872faa923b55d232?pvs=25#3e37f06bc38c4971b435fbff2f4da6cb)
for detailed examples of potential URLs.

## Usage

``` r
felt_add_map_layers_url(map_id, url, name = NULL, clean = TRUE)
```

## Arguments

- map_id:

  character, map identifier from url, from
  `https://felt.com/map/Readable-Name-map_id`

- url:

  Link to layer to include. Required

- name:

  Name of the layer. Required.

- clean:

  logical, whether to turn the API response into a
  [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)

## Value

a [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
for the created layer

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
