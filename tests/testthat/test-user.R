with_mock_dir("t/user", {
  test_that("felt_get_user works", {
    actual <- felt_get_user()
    expect_equal(nrow(actual), expected = 1)
    expect_s3_class(actual, 'data.frame')
  })
})
