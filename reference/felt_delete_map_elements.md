# Delete an existing element

Delete an existing element

## Usage

``` r
felt_delete_map_elements(map_id, element_id)
```

## Arguments

- map_id:

  character, map identifier from url, from
  `https://felt.com/map/Readable-Name-map_id`

- element_id:

  element identifier, as returned by
  [`felt_get_map_elements()`](http://christophertkenny.com/feltr/reference/felt_get_map_elements.md)
  or
  [`felt_add_map_elements()`](http://christophertkenny.com/feltr/reference/felt_add_map_elements.md)

## Value

response code

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
