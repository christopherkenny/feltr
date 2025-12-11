# Update a Map's Details

Allows for updates to the title, description, and level of public
access.

## Usage

``` r
felt_update_map_details(
  map_id,
  title = NULL,
  description = NULL,
  public_access = NULL,
  clean = TRUE
)
```

## Arguments

- map_id:

  character, map identifier from url, from
  `https://felt.com/map/Readable-Name-map_id`

- title:

  Title to use for the map. Defaults to `NULL`.

- description:

  Description for the map legend. Defaults to `NULL`.

- public_access:

  Degree of public acess. Defaults to `NULL`, which is `view_only`. Text
  options also include `'private'`, `'view_and_comment'`, and
  `'view_comment_and_edit'`.

- clean:

  logical, whether to turn the API response into a
  [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)

## Value

response data

## Examples

``` r
if (FALSE) { # has_felt_key()
felt_update_map_details(map_id = 'TBI8sDkmQjuK2GX9CSiHiUA',
                        title = paste0('Rockland 2024 Districts, tested ', Sys.Date()))
}
```
