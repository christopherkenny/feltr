# List all layers in your workspace library

List all layers in your workspace library

## Usage

``` r
felt_get_library(source = "workspace", clean = TRUE)
```

## Arguments

- source:

  character, source of the layers, one of `workspace`, `felt`, or `all`

- clean:

  logical, whether to turn the API response into a
  [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)

## Value

a [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
if `clean = TRUE`, otherwise a list

## Examples

``` r
if (FALSE) { # has_felt_key()
felt_get_library()
}
```
