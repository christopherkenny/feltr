# Delete an existing map

Delete an existing map

## Usage

``` r
felt_delete_map(map_id)
```

## Arguments

- map_id:

  character, map identifier from url, from
  `https://felt.com/map/Readable-Name-map_id`

## Value

response code

## Examples

``` r
if (FALSE) { # has_felt_key()
map <- felt_create_map(title = 'feltr example')
felt_delete_map(map_id = map$id)
}
```
