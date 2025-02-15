library(testthat)
library(whatr)

id <- sample(2000:5000, 1)
test_that("answers return from HTML", {
  a <- whatr_html(id) %>% whatr_answers()
  expect_s3_class(a, "tbl")
  expect_length(a, 5)
})

test_that("answers return from game ID", {
  a <- whatr_answers(game = id)
  expect_s3_class(a, "tbl")
  expect_length(a, 5)
})
