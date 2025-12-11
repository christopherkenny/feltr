# Export Comments on an Existing Map

Export Comments on an Existing Map

## Usage

``` r
felt_get_comments(map_id, clean = TRUE)
```

## Arguments

- map_id:

  character, map identifier from url, from
  `https://felt.com/map/Readable-Name-map_id`

- clean:

  logical, whether to turn the API response into a
  [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)

## Value

a [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
for the map

## Examples

``` r
if (FALSE) { # has_felt_key()
felt_get_comments(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA')
}
```
