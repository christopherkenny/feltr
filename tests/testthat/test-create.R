with_mock_dir("t/create", {
  test_that("create works", {
    new_map <- felt_create_map('r package test')
    expect_equal(nrow(new_map), 1)
    expect_s3_class(new_map, 'data.frame')
  })
})
