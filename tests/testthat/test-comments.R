with_mock_dir("t/comm", {
  test_that("felt_get_comments works", {
    skip_if_not(dir.exists('tests/testthat/t/comm/'), message = 'Test file not portable, test skipped.')
    actual <- felt_get_comments(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA')
    expect_s3_class(actual, 'data.frame')
  })
})
