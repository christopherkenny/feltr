with_mock_dir("t/add_map_layer", {
  test_that("add layer works", {
    actual <- felt_add_map_layers(
      map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
      file_names = fs::path_package('feltr',  'towns.geojson'),
      name = 'Towns')
    expect_equal(length(actual), 1)
    expect_equal(class(actual), 'character')
  })
})
