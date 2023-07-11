with_mock_dir("t/comm", {
  test_that("felt_get_comments works", {
    actual <- felt_get_comments(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA')
    expect_s3_class(actual, 'data.frame')
  })
})
