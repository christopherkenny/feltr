# Create a new map

Create a new map

## Usage

``` r
felt_create_map(
  title = NULL,
  basemap = NULL,
  layer_urls = NULL,
  lat = NULL,
  lon = NULL,
  zoom = NULL,
  description = NULL,
  public_access = NULL,
  clean = TRUE
)
```

## Arguments

- title:

  Title to use for the map. Defaults to `NULL`.

- basemap:

  Basemap for the new map. Defaults to `NULL`. Can be a URL or color hex
  code. Text options include `'default'` (same as `NULL`), `'light'`,
  `'dark'`, or `'satellite'`.

- layer_urls:

  vector of URLs to generate layers in map. Defaults to `NULL`.

- lat:

  latitude to center the map. Defaults to `NULL`.

- lon:

  longitude to center the map. Defaults to `NULL`

- zoom:

  zoom level to initialize the map with. Defaults to `NULL`.

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

a [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
for the new map

## Examples

``` r
if (FALSE) { # has_felt_key()
map <- felt_create_map(title = 'feltr example')
map
# and delete it again
felt_delete_map(map_id = map$id)
}
```
