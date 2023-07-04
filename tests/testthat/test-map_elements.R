with_mock_dir("t/get_elements", {
  test_that("get_map_elements works", {
    actual <- felt_get_map_elements('TBI8sDkmQjuK2GX9CSiHiUA')
    expect_s3_class(actual, 'data.frame')
  })
})
