library(testthat)
library(statsUtils)

test_that("data_summary works as expected", {
  df <- data.frame(group = rep(c("A", "B"), each = 5),
                   value = c(1:5, 6:10))
  summary_result <- data_summary(df, "value", "group")
  
  expect_true(all(c("group", "mean", "sd") %in% names(summary_result)))
  expect_equal(nrow(summary_result), 2)
})


test_that("check_anova_assumptions returns expected structure", {
  set.seed(123)
  df <- data.frame(
    group = rep(c("A", "B"), each = 10),
    value = c(rnorm(10, mean = 5), rnorm(10, mean = 7))
  )
  
  result <- check_anova_assumptions(df, response = "value", group = "group", return_results = TRUE, verbose = FALSE)
  
  expect_type(result, "list")
  expect_true(all(c("outlier_results", "normality_results", "levene_test") %in% names(result)))
  expect_s3_class(result$normality_results, "data.frame")
  expect_s3_class(result$levene_test, "anova")
})
