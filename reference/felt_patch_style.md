# Update Felt Style Information for a Layer

For details on the Felt Style Language, see
<https://felt.com/blog/felt-style-language>.

## Usage

``` r
felt_patch_style(map_id, layer_id, fsl, clean = TRUE)
```

## Arguments

- map_id:

  character, map identifier from url, from
  `https://felt.com/map/Readable-Name-map_id`

- layer_id:

  character, layer identifier from url, from
  [`felt_get_map()`](http://christophertkenny.com/feltr/reference/felt_get_map.md)

- fsl:

  A list indicating the Felt style language to update the layer to. It
  must be valid FSL.

- clean:

  logical, whether to turn the API response into a
  [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)

## Value

response data

## Examples

``` r
if (FALSE) { # has_felt_key()
# URL Parks layer
# read as a list
layer <- felt_get_map_layer(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA',
                            layer_id = 'eufG5hWKRRSURHE8YcGGXA',
                            clean = FALSE)
# use the existing style for easiest modification
style <- layer$style
style$label$minZoom <- round(runif(1, 0, 23))

felt_patch_style(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
                 layer_id = 'eufG5hWKRRSURHE8YcGGXA',
                 fsl = style)
}
```
