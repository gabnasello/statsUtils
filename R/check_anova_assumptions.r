#' Check ANOVA Assumptions
#'
#' Verifies outliers, normality, and homogeneity of variances for ANOVA.
#'
#' @param data A data frame.
#' @param response Name of the response variable (string).
#' @param group Name of the grouping variable (string).
#' @param return_results If TRUE, returns results as a list. Default is FALSE.
#' @param verbose If TRUE, prints messages. Default is TRUE.
#'
#' @return Optionally returns a list with outliers, normality tests, and Levene's test results.
#' @export
#'
#' @importFrom dplyr %>% group_by summarise filter mutate
#' @importFrom car leveneTest
#' @importFrom stats shapiro.test IQR quantile
#' @importFrom stats na.omit sd
check_anova_assumptions <- function(data, response, group, return_results = FALSE, verbose = TRUE) {
  data[[group]] <- as.factor(data[[group]])
  groups <- levels(data[[group]])

  # Outlier detection
  outlier_results <- purrr::map_dfr(groups, function(g) {
    vals <- na.omit(data[data[[group]] == g, response])
    q1 <- quantile(vals, 0.25)
    q3 <- quantile(vals, 0.75)
    iqr <- IQR(vals)
    lb <- q1 - 1.5 * iqr
    ub <- q3 + 1.5 * iqr
    outliers <- vals[vals < lb | vals > ub]
    data.frame(
      Group = g,
      lower_bound = lb,
      upper_bound = ub,
      outlier_count = length(outliers),
      outliers = I(list(if (length(outliers) == 0) NA else outliers))
    )
  })

  # Normality test
  normality_results <- purrr::map_dfr(groups, function(g) {
    vals <- na.omit(data[data[[group]] == g, response])
    p <- shapiro.test(vals)$p.value
    data.frame(
      Group = g,
      P_Value = p,
      Normality = ifelse(p < 0.05, "NOT normal", "Normal")
    )
  })

  # Levene's test
  form <- stats::as.formula(paste(response, "~", group))
  levene_result <- car::leveneTest(form, data)

  if (verbose) {
    message("Outliers:\n"); print(outlier_results[, 1:4])
    message("\nNormality:\n"); print(normality_results)
    message("\nLevene's Test:\n"); print(levene_result)
  }

  if (return_results) {
    list(
      outlier_results = outlier_results,
      normality_results = normality_results,
      levene_test = levene_result
    )
  }
}
