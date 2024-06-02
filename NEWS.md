# feltr 0.1.0

* Updates to `v2` of the API, now documented at <https://developers.felt.com/api-reference/maps>.
  * Adds a function `felt_update_map_details()` to update the title, description, or privacy of a map.
  * Adds a function to refresh layers via `felt_refresh_layer()`.
  * Adds a function to download a layer with `felt_get_map_layer()`.
  * Removes the `felt_finish_upload()` function, as it is no longer needed.
  * Removes the `felt_get_style()` function, as it was removed from the API. Instead, use `felt_get_map_layers()` which now includes style information for the layer.
* Adds improvements to working with keys by adding aliases `felt_set_key()`, `felt_get_key()`, and `felt_has_key()`.
* `get_felt_key()` now returns the key invisibly to avoid printing to the console.

# feltr 0.0.4

* Removes `felt_get_map_geojson()` and `felt_get_map_sf()`, as Felt removed these capabilities.
These will be restored in a future version, once the capabilities are available again.

# feltr 0.0.3

* Adds support for the comment export API with `felt_get_comments()`.
* Improves consistency in return values for `felt_add_map_layers_url()`.

# feltr 0.0.2

* Adds path arguments to `felt_set_key()` and `felt_get_map_sf()` to ensure compliance with CRAN policies in writing files.

# feltr 0.0.1

* Added a `NEWS.md` file to track changes to the package.
* Initial package with support for API features as of July 2023.
