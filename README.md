
<!-- README.md is generated from README.Rmd. Please edit that file -->

# feltr <img src="man/figures/logo.png" align="right" height="138" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/christopherkenny/feltr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/christopherkenny/feltr/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

`feltr` offers an R interface to the [Felt
API](https://feltmaps.notion.site/Felt-Public-API-reference-c01e0e6b0d954a678c608131b894e8e1).
You can create new maps, edit existing maps, and extract data. `feltr`
includes tools for working with layers, which represent geographic data,
and elements, which are interactive annotations. Spatial data accessed
from the API is transformed to work with ‘sf’.

## Installation

You can install the development version of `feltr` from
[GitHub](https://github.com/) with:

``` r
remotes::install_github("christopherkenny/feltr")
```

## API Key

An API key can be obtained by signing into your Felt account and looking
under Account Settings at the Integrations tab. Once obtained, it can be
loaded for persistent use with
`feltr::set_felt_key('YOUR KEY', install = TRUE, r_env = file.path(Sys.getenv('HOME'), '.Renviron'))`.

## Example

We can create a map, add some data to it, and even delete it.

``` r
library(feltr)
## create a map
map <- felt_create_map(title = 'feltr README')
```

Then we can add some data to it from a URL.

``` r
felt_add_map_layers_url(
  map_id = map$id, 
  url = 'https://www.rocklandgis.com/portal/sharing/rest/content/items/73fc78cb0fb04580b4788937fe5ee697/data',
  name = 'Parks'
)
#> # A tibble: 0 × 6
#> # ℹ 6 variables: name <chr>, status <chr>, progress <dbl>, id <chr>,
#> #   type <chr>, relationships <list>
```

Finally, we can even delete the map from R.

``` r
felt_delete_map(map_id = map$id)
#> [1] 204
```

This returns a 204 on success.
